const { contextBridge, ipcRenderer } = require('electron');

contextBridge.exposeInMainWorld('electronAPI', {
  // File operations
  readFile: (options) => ipcRenderer.invoke('read-file', options),
  writeFile: (filePath, content) => ipcRenderer.invoke('write-file', filePath, content),
  showSaveDialog: (options) => ipcRenderer.invoke('show-save-dialog', options),
  
  // XML conversion
  convertXml: (data) => ipcRenderer.invoke('convert-xml', data),
  
  // App info
  getAppVersion: () => ipcRenderer.invoke('get-app-version'),
  showMessageBox: (options) => ipcRenderer.invoke('show-message-box', options),
  
  // Menu events
  onMenuLoadXml: (callback) => ipcRenderer.on('menu-load-xml', callback),
  onMenuSaveSql: (callback) => ipcRenderer.on('menu-save-sql', callback),
  
  // Remove listeners
  removeAllListeners: (channel) => ipcRenderer.removeAllListeners(channel)
});