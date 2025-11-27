#!/usr/bin/env node

import { DOMParser } from 'xmldom';
import fs from 'fs';
import yargs from 'yargs';
import { hideBin } from 'yargs/helpers';

// Default rules
export const defaultRules = {
  string: ["CNPJ", "CPF", "CEP", "fone", "telefone", "chNFe", "IE", "cEAN", "cEANTrib"],
  integer: ["tpNF", "idDest", "tpImp", "tpEmis", "cDV", "tpAmb", "finNFe", "indFinal", "indPres", "procEmi", "CRT", "indIEDest", "indTot", "nItemPed", "modBC", "CST", "cEnq", "modFrete", "nVol", "indPag", "tPag", "tpIntegra", "tBand"],
  real: ["vUnCom", "vProd", "vUnTrib", "pRedBC", "vBC", "pICMS", "vICMS", "pIPI", "vIPI", "vBC", "pPIS", "vPIS", "pCOFINS", "vCOFINS", "vOrig", "vLiq", "vDup", "vPag", "pesoL", "pesoB"]
};

// Data type detection functions
export function isString(value) {
  return typeof value === 'string';
}

export function isInteger(value) {
  const numberValue = Number(value);
  return !isNaN(numberValue) && Number.isInteger(numberValue);
}

export function isReal(value) {
  const numberValue = Number(value);
  return !isNaN(numberValue) && !Number.isInteger(numberValue);
}

export function isArrayOrObject(value) {
  try {
    const parsedValue = JSON.parse(value);
    if (Array.isArray(parsedValue)) {
      return 'array';
    } else if (typeof parsedValue === 'object' && parsedValue !== null) {
      return 'object';
    }
  } catch (e) {
    return 'not-array-or-object';
  }
  return 'not-array-or-object';
}

export function detectType(inputString, tagName = '', customRules = defaultRules) {
  for (const [type, tags] of Object.entries(customRules)) {
    if (tags.includes(tagName)) {
      return type;
    }
  }
  
  if (!inputString || inputString.trim() === '') {
    return 'null';
  }
  
  if (isInteger(inputString)) {
    return 'integer';
  } else if (isReal(inputString)) {
    return 'real';
  }
  
  const arrayOrObjectType = isArrayOrObject(inputString);
  if (arrayOrObjectType === 'array') {
    return 'array';
  } else if (arrayOrObjectType === 'object') {
    return 'object';
  }
  
  return 'string';
}

// XML to JSON conversion
export function xmlToJson(xmlString, customRules = defaultRules) {
  try {
    const parser = new DOMParser();
    const xmlDoc = parser.parseFromString(xmlString, "text/xml");
    
    const parseError = xmlDoc.getElementsByTagName("parsererror")[0];
    if (parseError) {
      throw new Error("Invalid XML format: " + parseError.textContent);
    }
    
    const rootElement = xmlDoc.documentElement;
    return convertElement(rootElement, customRules);
  } catch (error) {
    throw new Error("XML parsing error: " + error.message);
  }
}

function convertElement(element, customRules) {
  const result = {
    name: element.tagName,
    type: "",
    contents: null
  };
  
  const childElements = Array.from(element.childNodes).filter(node => node.nodeType === 1);
  const textContent = element.textContent.trim();
  
  if (childElements.length > 0) {
    const childNames = childElements.map(child => child.tagName);
    const allSameName = childNames.every(name => name === childNames[0]);
    
    if (allSameName) {
      result.type = "array";
      result.contents = childElements.map(child => convertElement(child, customRules));
    } else {
      result.type = "object";
      result.contents = childElements.map(child => convertElement(child, customRules));
    }
  } else {
    if (textContent === "") {
      result.type = "null";
      result.contents = null;
    } else {
      result.type = detectType(textContent, element.tagName, customRules);
      
      if (result.type === "integer") {
        result.contents = parseInt(textContent, 10);
      } else if (result.type === "real") {
        result.contents = parseFloat(textContent);
      } else {
        result.contents = textContent;
      }
    }
  }
  
  return result;
}

// SQL Schema Generation
export function generateFlatSqlSchema(jsonData) {
  let sql = "";
  const tables = new Map();
  const relationships = [];
  let tableCount = 0;
  let fieldCount = 0;

  function sanitizeName(name) {
    return name.replace(/[^a-zA-Z0-9_]/g, '_').toLowerCase();
  }

  function processStructure(node, parentTable = null, path = "") {
    const currentPath = path ? `${path}_${node.name}` : node.name;
    const tableName = sanitizeName(currentPath);
    
    if (node.type === "object" || node.type === "array") {
      if (!tables.has(tableName)) {
        tables.set(tableName, []);
        tableCount++;
      }
      
      if (parentTable) {
        const parentRef = `${sanitizeName(parentTable)}_id INTEGER NOT NULL`;
        if (!tables.get(tableName).includes(parentRef)) {
          tables.get(tableName).push(parentRef);
        }
        relationships.push({
          child: tableName,
          parent: parentTable
        });
      }
      
      if (!tables.get(tableName).includes("id SERIAL PRIMARY KEY")) {
        tables.get(tableName).unshift("id SERIAL PRIMARY KEY");
      }
      
      if (node.contents && Array.isArray(node.contents)) {
        node.contents.forEach(child => {
          if (child.type === "object" || child.type === "array") {
            processStructure(child, tableName, currentPath);
          } else {
            let fieldType = "TEXT";
            switch (child.type) {
              case "integer": fieldType = "INTEGER"; break;
              case "real": fieldType = "DECIMAL(15,4)"; break;
              case "null": fieldType = "TEXT"; break;
              default: fieldType = "TEXT";
            }
            
            const fieldDef = `${sanitizeName(child.name)} ${fieldType}`;
            if (!tables.get(tableName).includes(fieldDef)) {
              tables.get(tableName).push(fieldDef);
              fieldCount++;
            }
          }
        });
      }
    }
  }

  processStructure(jsonData);

  sql += "-- Generated SQL Schema from XML Structure\n";
  sql += "-- =========================================\n\n";

  for (const [tableName, fields] of tables) {
    sql += `-- Table: ${tableName}\n`;
    sql += `CREATE TABLE ${tableName} (\n`;
    sql += `  ${fields.join(",\n  ")}\n`;
    sql += `);\n\n`;
  }

  if (relationships.length > 0) {
    sql += "-- Foreign Key Constraints\n";
    sql += "-- =======================\n\n";
    
    relationships.forEach(rel => {
      sql += `ALTER TABLE ${rel.child}\n`;
      sql += `ADD CONSTRAINT fk_${rel.child}_${rel.parent}\n`;
      sql += `FOREIGN KEY (${rel.parent}_id) REFERENCES ${rel.parent}(id);\n\n`;
    });
  }

  sql += `-- Schema Statistics:\n`;
  sql += `-- Tables: ${tableCount}\n`;
  sql += `-- Fields: ${fieldCount}\n`;
  sql += `-- Relationships: ${relationships.length}\n`;

  return sql;
}

// === API MODE FOR ELECTRON ===
export async function handleApiRequest(inputData) {
  try {
    const data = typeof inputData === 'string' ? JSON.parse(inputData) : inputData;
    
    if (data.action === 'xmlToJson') {
      const jsonResult = xmlToJson(data.xml, data.rules);
      return JSON.stringify(jsonResult);
    } 
    else if (data.action === 'generateSql') {
      const sqlSchema = generateFlatSqlSchema(data.json);
      return sqlSchema;
    }
    else {
      throw new Error('Unknown action: ' + data.action);
    }
  } catch (error) {
    throw new Error('API request failed: ' + error.message);
  }
}

// Check if running in API mode (called from electron wrapper)
if (process.stdin && process.stdout && process.argv[1] && process.argv[1].includes('converter.js')) {
  let inputData = '';
  
  process.stdin.setEncoding('utf8');
  process.stdin.on('data', (chunk) => {
    inputData += chunk;
  });
  
  process.stdin.on('end', async () => {
    try {
      const result = await handleApiRequest(inputData);
      process.stdout.write(result);
      process.exit(0);
    } catch (error) {
      process.stderr.write(error.message);
      process.exit(1);
    }
  });
}

// === CLI FUNCTIONALITY === 
if (import.meta.url === `file://${process.argv[1]}`) {
  const argv = yargs(hideBin(process.argv))
    .option('xml', {
      alias: 'x',
      type: 'string',
      description: 'XML input string',
      conflicts: 'xml-file'
    })
    .option('xml-file', {
      alias: 'f',
      type: 'string',
      description: 'Path to XML file',
      conflicts: 'xml'
    })
    .option('rules', {
      alias: 'r',
      type: 'string',
      description: 'Custom rules as JSON string'
    })
    .option('rules-file', {
      alias: 'rf',
      type: 'string',
      description: 'Path to custom rules JSON file'
    })
    .option('output', {
      alias: 'o',
      type: 'string',
      description: 'Output file for SQL (optional)'
    })
    .option('json-output', {
      alias: 'j',
      type: 'string',
      description: 'Output file for JSON (optional)'
    })
    .option('verbose', {
      alias: 'v',
      type: 'boolean',
      description: 'Run with verbose output'
    })
    .example('$0 -x "<root><item>test</item></root>"', 'Convert XML string to SQL')
    .example('$0 -f input.xml -o schema.sql', 'Convert XML file to SQL file')
    .example('$0 -f input.xml -rf rules.json', 'Use custom rules from file')
    .check((argv, options) => {
      // Verificar manualmente se pelo menos um dos argumentos foi fornecido
      if (!argv.xml && !argv.xmlFile) {
        throw new Error('Must provide either --xml or --xml-file');
      }
      return true; // tell Yargs that the arguments passed the check
    })
    .help()
    .argv;

  // Main execution
  async function main() {
    try {
      let xmlContent = '';
      let customRules = defaultRules;
      
      if (argv.xml) {
        xmlContent = argv.xml;
        if (argv.verbose) console.log('📥 Using XML from command line argument');
      } else if (argv.xmlFile) {
        xmlContent = fs.readFileSync(argv.xmlFile, 'utf8');
        if (argv.verbose) console.log(`📥 Read XML from file: ${argv.xmlFile}`);
      }
      
      if (argv.rules) {
        try {
          customRules = JSON.parse(argv.rules);
          if (argv.verbose) console.log('📋 Using custom rules from command line');
        } catch (e) {
          throw new Error('Invalid rules JSON format: ' + e.message);
        }
      } else if (argv.rulesFile) {
        try {
          const rulesContent = fs.readFileSync(argv.rulesFile, 'utf8');
          customRules = JSON.parse(rulesContent);
          if (argv.verbose) console.log(`📋 Using custom rules from file: ${argv.rulesFile}`);
        } catch (e) {
          throw new Error('Error loading rules file: ' + e.message);
        }
      }
      
      if (argv.verbose) console.log('🔄 Converting XML to JSON...');
      
      const jsonResult = xmlToJson(xmlContent, customRules);
      
      if (argv.jsonOutput) {
        fs.writeFileSync(argv.jsonOutput, JSON.stringify(jsonResult, null, 2));
        if (argv.verbose) console.log(`💾 JSON saved to: ${argv.jsonOutput}`);
      }
      
      if (argv.verbose) console.log('🔄 Generating SQL schema...');
      
      const sqlSchema = generateFlatSqlSchema(jsonResult);
      
      if (argv.output) {
        fs.writeFileSync(argv.output, sqlSchema);
        if (argv.verbose) console.log(`💾 SQL schema saved to: ${argv.output}`);
      } else {
        console.log(sqlSchema);
      }
      
      if (argv.verbose) console.log('✅ Conversion completed successfully!');
      
    } catch (error) {
      console.error('❌ Error:', error.message);
      process.exit(1);
    }
  }

  // Run the CLI
  main();
}