class XMLToSQLConverter {
  constructor() {
    this.currentXmlFile = null;
    this.currentSqlContent = null;
    this.isElectron = !!window.electronAPI;
    
    this.init();
  }

  init() {
    this.setupEventListeners();
    this.setupDragAndDrop();
    this.setupMenuHandlers();
    this.loadDefaultRules();
    
    if (this.isElectron) {
      this.setupElectronUI();
      this.checkAppVersion();
    }
    
    console.log('XML to SQL Converter initialized - Electron:', this.isElectron);
  }

  setupEventListeners() {
    document.getElementById('convert-btn').addEventListener('click', () => this.convertXML());
    document.getElementById('clear-btn').addEventListener('click', () => this.clearAll());
    document.getElementById('save-sql-btn').addEventListener('click', () => this.saveSQL());
    
    if (this.isElectron) {
      document.getElementById('load-xml-btn').addEventListener('click', () => this.loadXMLFile());
      document.getElementById('export-json-btn').addEventListener('click', () => this.exportJSON());
    }
    
    document.addEventListener('keydown', (e) => this.handleKeyboardShortcuts(e));
  }

  setupMenuHandlers() {
    if (this.isElectron) {
      window.electronAPI.onMenuLoadXml(() => this.loadXMLFile());
      window.electronAPI.onMenuSaveSql(() => this.saveSQL());
    }
  }

  setupElectronUI() {
    const title = document.querySelector('h1');
    if (title) {
      title.innerHTML += ' <small style="font-size: 0.6em; color: #7f8c8d;">(Desktop Edition)</small>';
    }
  }

  async checkAppVersion() {
    try {
      const version = await window.electronAPI.getAppVersion();
      console.log('App version:', version);
    } catch (error) {
      console.log('Could not get app version:', error);
    }
  }

  setupDragAndDrop() {
    const xmlInput = document.getElementById('xml-input');
    const dropZone = document.querySelector('.input-section');

    ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
      dropZone.addEventListener(eventName, preventDefaults, false);
      document.body.addEventListener(eventName, preventDefaults, false);
    });

    function preventDefaults(e) {
      e.preventDefault();
      e.stopPropagation();
    }

    ['dragenter', 'dragover'].forEach(eventName => {
      dropZone.addEventListener(eventName, highlight, false);
    });

    ['dragleave', 'drop'].forEach(eventName => {
      dropZone.addEventListener(eventName, unhighlight, false);
    });

    function highlight() {
      dropZone.style.backgroundColor = '#f0f8ff';
      dropZone.style.border = '2px dashed #3498db';
    }

    function unhighlight() {
      dropZone.style.backgroundColor = '';
      dropZone.style.border = '';
    }

    dropZone.addEventListener('drop', (e) => {
      const dt = e.dataTransfer;
      const files = dt.files;

      this.handleDroppedFiles(files);
    }, false);
  }

  async handleDroppedFiles(files) {
    if (files.length > 0) {
      const file = files[0];
      
      if (file.type === 'text/xml' || file.name.endsWith('.xml')) {
        try {
          const content = await this.readFileContent(file);
          document.getElementById('xml-input').value = content;
          this.currentXmlFile = file.name;
          this.showNotification(`XML carregado: ${file.name}`, 'success');
        } catch (error) {
          this.showNotification(`Erro ao ler arquivo: ${error.message}`, 'error');
        }
      } else {
        this.showNotification('Por favor, solte um arquivo XML', 'warning');
      }
    }
  }

  readFileContent(file) {
    return new Promise((resolve, reject) => {
      const reader = new FileReader();
      reader.onload = (e) => resolve(e.target.result);
      reader.onerror = (e) => reject(e);
      reader.readAsText(file);
    });
  }

  async loadXMLFile() {
    if (!this.isElectron) return;

    try {
      const result = await window.electronAPI.readFile({
        filters: [
          { name: 'XML Files', extensions: ['xml'] },
          { name: 'All Files', extensions: ['*'] }
        ],
        properties: ['openFile']
      });

      if (result.success) {
        document.getElementById('xml-input').value = result.content;
        this.currentXmlFile = result.fileName;
        this.showNotification(`XML carregado: ${result.fileName}`, 'success');
      } else if (result.error !== 'No file selected') {
        this.showNotification(`Erro: ${result.error}`, 'error');
      }
    } catch (error) {
      this.showNotification(`Erro ao carregar arquivo: ${error.message}`, 'error');
    }
  }

  async convertXML() {
    const xmlContent = document.getElementById('xml-input').value.trim();
    
    if (!xmlContent) {
      this.showNotification('Por favor, insira ou carregue um XML', 'warning');
      return;
    }

    this.showNotification('Convertendo XML...', 'info');
    
    try {
      let result;
      
      if (this.isElectron) {
        result = await window.electronAPI.convertXml({
          xml: xmlContent,
          rules: this.getCurrentRules()
        });
      } else {
        const response = await fetch('/api/convert-to-sql', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ 
            xml: xmlContent,
            rules: this.getCurrentRules()
          })
        });
        result = await response.json();
        result.success = result.success || false;
        result.sql = result.result || result.sql;
      }

      if (result.success) {
        document.getElementById('sql-output').value = result.sql;
        this.currentSqlContent = result.sql;
        this.showNotification('Conversão concluída com sucesso!', 'success');
        
        this.showConversionStats(result.sql);
      } else {
        this.showNotification(`Erro na conversão: ${result.error}`, 'error');
      }
    } catch (error) {
      this.showNotification(`Erro: ${error.message}`, 'error');
    }
  }

  showConversionStats(sqlContent) {
    const tableCount = (sqlContent.match(/CREATE TABLE/g) || []).length;
    const lineCount = sqlContent.split('\n').length;
    
    console.log(`Conversão: ${tableCount} tabelas, ${lineCount} linhas SQL`);
  }

  async saveSQL() {
    const sqlContent = document.getElementById('sql-output').value;
    
    if (!sqlContent) {
      this.showNotification('Nenhum conteúdo SQL para salvar', 'warning');
      return;
    }

    if (this.isElectron) {
      await this.saveSQLFileElectron(sqlContent);
    } else {
      this.downloadSQLFile(sqlContent);
    }
  }

  async saveSQLFileElectron(sqlContent) {
    try {
      const result = await window.electronAPI.showSaveDialog({
        defaultPath: this.currentXmlFile ? 
          `${this.currentXmlFile.replace('.xml', '')}_schema.sql` : 'schema.sql',
        filters: [
          { name: 'SQL Files', extensions: ['sql'] },
          { name: 'Text Files', extensions: ['txt'] },
          { name: 'All Files', extensions: ['*'] }
        ]
      });

      if (!result.canceled && result.filePath) {
        const saveResult = await window.electronAPI.writeFile(result.filePath, sqlContent);
        
        if (saveResult.success) {
          this.showNotification(`SQL salvo em: ${result.filePath}`, 'success');
        } else {
          this.showNotification(`Erro ao salvar: ${saveResult.error}`, 'error');
        }
      }
    } catch (error) {
      this.showNotification(`Erro: ${error.message}`, 'error');
    }
  }

  downloadSQLFile(sqlContent) {
    const blob = new Blob([sqlContent], { type: 'text/sql' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'schema.sql';
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    URL.revokeObjectURL(url);
    
    this.showNotification('SQL baixado com sucesso!', 'success');
  }

  async exportJSON() {
    if (!this.isElectron) return;

    const xmlContent = document.getElementById('xml-input').value.trim();
    
    if (!xmlContent) {
      this.showNotification('Nenhum XML para converter para JSON', 'warning');
      return;
    }

    try {
      const result = await window.electronAPI.convertXml({
        xml: xmlContent,
        rules: this.getCurrentRules()
      });

      if (result.success && result.json) {
        const jsonContent = JSON.stringify(result.json, null, 2);
        
        const saveResult = await window.electronAPI.showSaveDialog({
          defaultPath: this.currentXmlFile ? 
            `${this.currentXmlFile.replace('.xml', '')}.json` : 'conversion.json',
          filters: [
            { name: 'JSON Files', extensions: ['json'] },
            { name: 'All Files', extensions: ['*'] }
          ]
        });

        if (!saveResult.canceled && saveResult.filePath) {
          const writeResult = await window.electronAPI.writeFile(saveResult.filePath, jsonContent);
          
          if (writeResult.success) {
            this.showNotification(`JSON salvo em: ${saveResult.filePath}`, 'success');
          }
        }
      }
    } catch (error) {
      this.showNotification(`Erro ao exportar JSON: ${error.message}`, 'error');
    }
  }

  clearAll() {
    document.getElementById('xml-input').value = '';
    document.getElementById('sql-output').value = '';
    this.currentXmlFile = null;
    this.currentSqlContent = null;
    this.showNotification('Campos limpos', 'info');
  }

  loadDefaultRules() {
    const defaultRules = {
      string: ["CNPJ", "CPF", "CEP", "fone", "telefone", "chNFe", "IE", "cEAN", "cEANTrib"],
      integer: ["tpNF", "idDest", "tpImp", "tpEmis", "cDV", "tpAmb", "finNFe", "indFinal", "indPres", "procEmi", "CRT", "indIEDest", "indTot", "nItemPed", "modBC", "CST", "cEnq", "modFrete", "nVol", "indPag", "tPag", "tpIntegra", "tBand"],
      real: ["vUnCom", "vProd", "vUnTrib", "pRedBC", "vBC", "pICMS", "vICMS", "pIPI", "vIPI", "vBC", "pPIS", "vPIS", "pCOFINS", "vCOFINS", "vOrig", "vLiq", "vDup", "vPag", "pesoL", "pesoB"]
    };
    
    this.currentRules = defaultRules;
  }

  getCurrentRules() {
    return this.currentRules;
  }

  handleKeyboardShortcuts(e) {
    if (e.ctrlKey || e.metaKey) {
      switch (e.key) {
        case 'o':
          e.preventDefault();
          if (this.isElectron) this.loadXMLFile();
          break;
        case 's':
          e.preventDefault();
          this.saveSQL();
          break;
        case 'Enter':
          e.preventDefault();
          if (e.shiftKey) this.convertXML();
          break;
      }
    }
  }

  showNotification(message, type = 'info') {
    const existingNotifications = document.querySelectorAll('.notification');
    existingNotifications.forEach(notification => {
      if (notification.parentNode) {
        notification.parentNode.removeChild(notification);
      }
    });

    const notification = document.createElement('div');
    notification.className = `notification notification-${type}`;
    notification.innerHTML = `
      <div class="notification-content">
        <span class="notification-message">${message}</span>
        <button class="notification-close" onclick="this.parentElement.parentElement.remove()">×</button>
      </div>
    `;

    notification.style.cssText = `
      position: fixed;
      top: 20px;
      right: 20px;
      background: ${this.getNotificationColor(type)};
      color: white;
      padding: 0;
      border-radius: 8px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.15);
      z-index: 10000;
      max-width: 400px;
      animation: slideIn 0.3s ease-out;
    `;

    notification.querySelector('.notification-content').style.cssText = `
      padding: 12px 16px;
      display: flex;
      align-items: center;
      justify-content: space-between;
    `;

    notification.querySelector('.notification-close').style.cssText = `
      background: none;
      border: none;
      color: white;
      font-size: 18px;
      cursor: pointer;
      margin-left: 10px;
      padding: 0;
      width: 20px;
      height: 20px;
      display: flex;
      align-items: center;
      justify-content: center;
    `;

    document.body.appendChild(notification);

    setTimeout(() => {
      if (notification.parentNode) {
        notification.parentNode.removeChild(notification);
      }
    }, 5000);
  }

  getNotificationColor(type) {
    const colors = {
      success: '#27ae60',
      error: '#e74c3c',
      warning: '#f39c12',
      info: '#3498db'
    };
    return colors[type] || colors.info;
  }
}

const style = document.createElement('style');
style.textContent = `
  @keyframes slideIn {
    from {
      transform: translateX(100%);
      opacity: 0;
    }
    to {
      transform: translateX(0);
      opacity: 1;
    }
  }

  .electron-only {
    display: none;
  }

  .electron-available .electron-only {
    display: inline-block;
  }
`;
document.head.appendChild(style);

document.addEventListener('DOMContentLoaded', () => {
  if (window.electronAPI) {
    document.body.classList.add('electron-available');
    
    const inputActions = document.querySelector('.input-section .actions');
    if (inputActions && !document.getElementById('load-xml-btn')) {
      inputActions.innerHTML = `
        <button id="load-xml-btn" class="electron-only" title="Ctrl+O">📁 Carregar XML</button>
        <button id="convert-btn">🔄 Converter para SQL</button>
        <button id="clear-btn">🗑️ Limpar</button>
        <button id="export-json-btn" class="electron-only" title="Exportar JSON">📊 Exportar JSON</button>
      ` + inputActions.innerHTML;
    }

    const outputActions = document.querySelector('.output-section');
    if (outputActions) {
      const saveButton = outputActions.querySelector('#save-sql-btn');
      if (saveButton) {
        saveButton.innerHTML = '💾 Salvar SQL';
        saveButton.title = 'Ctrl+S';
      }
    }
  }

  window.xmlToSQLApp = new XMLToSQLConverter();
});

const electronStyles = `
  .electron-available .input-section {
    border-left: 4px solid #3498db;
  }

  .electron-available .output-section {
    border-left: 4px solid #27ae60;
  }

  #load-xml-btn {
    background-color: #9b59b6;
  }

  #load-xml-btn:hover {
    background-color: #8e44ad;
  }

  #export-json-btn {
    background-color: #f39c12;
  }

  #export-json-btn:hover {
    background-color: #e67e22;
  }
`;

const styleElement = document.createElement('style');
styleElement.textContent = electronStyles;
document.head.appendChild(styleElement);