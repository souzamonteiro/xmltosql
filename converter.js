#!/usr/bin/env node

import { DOMParser } from 'xmldom';
import fs from 'fs';
import yargs from 'yargs';
import { hideBin } from 'yargs/helpers';

// Default rules - compatíveis com o index.html
export const defaultRules = {
  string: ["CNPJ", "CPF", "CEP", "fone", "telefone", "chNFe", "IE", "cEAN", "cEANTrib"],
  integer: ["tpNF", "idDest", "tpImp", "tpEmis", "cDV", "tpAmb", "finNFe", "indFinal", "indPres", "procEmi", "CRT", "indIEDest", "indTot", "nItemPed", "modBC", "CST", "cEnq", "modFrete", "nVol", "indPag", "tPag", "tpIntegra", "tBand"],
  real: ["vUnCom", "vProd", "vUnTrib", "pRedBC", "vBC", "pICMS", "vICMS", "pIPI", "vIPI", "vBC", "pPIS", "vPIS", "pCOFINS", "vCOFINS", "vOrig", "vLiq", "vDup", "vPag", "pesoL", "pesoB"]
};

// Data type detection functions - compatíveis com o index.html
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

// XML to JSON conversion - compatível com o index.html
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
    contents: null,
    value: element.textContent.trim(),
    attributes: {}
  };
  
  // Capture ALL attributes including xmlns - compatível com index.html
  for (let i = 0; i < element.attributes.length; i++) {
    const attr = element.attributes[i];
    result.attributes[attr.name] = attr.value;
  }
  
  const childElements = Array.from(element.children);
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

// Enhanced SQL Schema Generation with INSERTs - compatível com index.html
export function generateSqlSchema(jsonData) {
  let schemaSql = "";
  let insertSql = "";
  const tables = new Map(); // tableName -> {fields: Set, data: [], parentRef: null}
  const relationships = [];
  const relationshipSet = new Set(); // To avoid duplicate foreign keys
  let tableCount = 0;
  let fieldCount = 0;
  let relationshipCount = 0;
  let insertCount = 0;

  // Helper function to sanitize table names
  function sanitizeName(name) {
    return name.replace(/[^a-zA-Z0-9_]/g, '_').toLowerCase();
  }

  // Escape SQL values
  function escapeSqlValue(value) {
    if (value === null || value === undefined || value === '') {
      return 'NULL';
    }
    if (typeof value === 'string') {
      // Check if it's a number disguised as string
      if (!isNaN(value) && value.trim() !== '') {
        const num = Number(value);
        if (!isNaN(num)) {
          return value;
        }
      }
      return "'" + value.replace(/'/g, "''") + "'";
    }
    return value;
  }

  // Recursive function to process JSON structure and collect data
  function processNode(node, parentTable = null, parentId = null, tablePath = [], siblingIndex = 0, customRules = defaultRules) {
    const currentTable = sanitizeName(node.name);
    const fullTableName = tablePath.length > 0 ? 
      sanitizeName([...tablePath, node.name].join('_')) : 
      currentTable;
    
    if (node.type === "object" || node.type === "array") {
      // Create table entry if not exists
      if (!tables.has(fullTableName)) {
        tables.set(fullTableName, {
          fields: new Set(["id INT AUTO_INCREMENT PRIMARY KEY"]),
          data: [],
          parentRef: null,
          variableName: `@${fullTableName}_id`
        });
        tableCount++;
      }
      
      const tableInfo = tables.get(fullTableName);
      
      // Prepare row data
      const rowData = {};
      
      // Store parent reference if exists
      if (parentTable) {
        const parentRefField = `${parentTable}_id`;
        tableInfo.fields.add(`${parentRefField} INT NOT NULL`);
        tableInfo.parentRef = parentTable;
        
        // Store relationship for foreign key (avoid duplicates)
        const relKey = `${fullTableName}|${parentTable}|${parentRefField}`;
        if (!relationshipSet.has(relKey)) {
          relationshipSet.add(relKey);
          relationships.push({
            childTable: fullTableName,
            parentTable: parentTable,
            field: parentRefField
          });
          relationshipCount++;
        }
      }
      
      // Add attributes as fields
      for (const [attrName, attrValue] of Object.entries(node.attributes)) {
        const fieldName = `${sanitizeName(attrName)}_attr`;
        
        // Determine appropriate data type for attribute
        let fieldType = "VARCHAR(255)";
        const detectedType = detectType(attrValue, attrName, customRules);
        if (detectedType === "integer") {
          fieldType = "INT";
        } else if (detectedType === "real") {
          fieldType = "DECIMAL(15,4)";
        }
        
        tableInfo.fields.add(`${fieldName} ${fieldType}`);
        fieldCount++;
        rowData[fieldName] = attrValue;
      }
      
      // Process contents (fields or child objects)
      if (node.contents && Array.isArray(node.contents)) {
        // Group children by type to handle arrays properly
        const regularFields = [];
        const childTables = [];
        
        node.contents.forEach((child, index) => {
          if (child.type === "object" || child.type === "array") {
            childTables.push({
              child: child,
              index: index
            });
          } else {
            regularFields.push({
              child: child,
              index: index
            });
          }
        });
        
        // Process regular fields first
        regularFields.forEach(item => {
          const child = item.child;
          const fieldName = sanitizeName(child.name);
          let fieldType = "VARCHAR(500)";
          
          switch (child.type) {
            case "integer":
              fieldType = "INT";
              break;
            case "real":
              fieldType = "DECIMAL(15,4)";
              break;
            case "null":
              fieldType = "VARCHAR(255)";
              break;
            default:
              fieldType = "VARCHAR(500)";
          }
          
          tableInfo.fields.add(`${fieldName} ${fieldType}`);
          fieldCount++;
          
          // Store value in row data
          rowData[fieldName] = child.contents;
        });
        
        // Process child tables recursively
        childTables.forEach((item, childIndex) => {
          processNode(
            item.child,
            fullTableName,
            null,
            [...tablePath, node.name],
            childIndex,
            customRules
          );
        });
      }
      
      // Store row data
      tableInfo.data.push({
        table: fullTableName,
        data: rowData,
        parentTable: parentTable,
        siblingIndex: siblingIndex
      });
      
      insertCount++;
      
      return fullTableName;
      
    } else {
      // Primitive field - should be handled by parent table
      return null;
    }
  }

  // Start processing from root
  schemaSql += "-- Generated MySQL SQL Schema from XML Structure\n";
  schemaSql += "-- =================================================\n";
  processNode(jsonData);

  // Generate CREATE TABLE statements with IF NOT EXISTS
  for (const [tableName, tableInfo] of tables) {
    schemaSql += `\n-- Table: ${tableName}\n`;
    schemaSql += `CREATE TABLE IF NOT EXISTS ${tableName} (\n`;
    schemaSql += `  ${Array.from(tableInfo.fields).join(",\n  ")}\n`;
    schemaSql += `) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;\n`;
  }

  // Generate foreign key constraints (without duplicates)
  if (relationships.length > 0) {
    schemaSql += `\n-- Foreign Key Constraints\n`;
    schemaSql += `-- =======================\n`;
    
    relationships.forEach(rel => {
      schemaSql += `\nALTER TABLE ${rel.childTable}\n`;
      schemaSql += `ADD CONSTRAINT fk_${rel.childTable}_${rel.field.replace('_id', '')}\n`;
      schemaSql += `FOREIGN KEY (${rel.field}) REFERENCES ${rel.parentTable}(id);\n`;
    });
  }

  // Generate INSERT statements using MySQL session variables for console execution
  insertSql += "-- INSERT Statements with MySQL Session Variables\n";
  insertSql += "-- ==============================================\n";
  insertSql += "-- This script uses MySQL session variables (@variables) to maintain\n";
  insertSql += "-- referential integrity. Execute in MySQL console or client.\n\n";
  insertSql += "START TRANSACTION;\n\n";

  // Track processed tables to avoid duplicates
  const processedTables = new Set();
  
  // Get tables in hierarchical order (roots first)
  const sortedTables = Array.from(tables.entries())
    .sort(([aName, aInfo], [bName, bInfo]) => {
      // Tables without parent go first
      if (!aInfo.parentRef && bInfo.parentRef) return -1;
      if (aInfo.parentRef && !bInfo.parentRef) return 1;
      
      // Otherwise maintain original order
      return 0;
    });

  // Process each table
  for (const [tableName, tableInfo] of sortedTables) {
    if (processedTables.has(tableName)) {
      continue;
    }
    processedTables.add(tableName);

    // Process each row of data for this table
    tableInfo.data.forEach((rowData, rowIndex) => {
      const fields = Object.keys(rowData.data);
      const values = fields.map(field => escapeSqlValue(rowData.data[field]));
      
      if (tableInfo.parentRef) {
        // Child table - use parent variable
        const parentVar = `@${tableInfo.parentRef}_id`;
        
        insertSql += `-- Insert into ${tableName} (child of ${tableInfo.parentRef})\n`;
        insertSql += `SET @${tableName}_id = NULL;\n`;
        insertSql += `INSERT INTO ${tableName} (${tableInfo.parentRef}_id, ${fields.join(', ')}) \n`;
        insertSql += `VALUES (${parentVar}, ${values.join(', ')});\n`;
        insertSql += `SET @${tableName}_id = LAST_INSERT_ID();\n\n`;
      } else {
        // Root table
        insertSql += `-- Insert into ${tableName} (root table)\n`;
        insertSql += `SET @${tableName}_id = NULL;\n`;
        
        if (fields.length > 0) {
          insertSql += `INSERT INTO ${tableName} (${fields.join(', ')}) \n`;
          insertSql += `VALUES (${values.join(', ')});\n`;
        } else {
          // Handle tables with only id column
          insertSql += `INSERT INTO ${tableName} () VALUES ();\n`;
        }
        
        insertSql += `SET @${tableName}_id = LAST_INSERT_ID();\n\n`;
      }
    });
  }

  insertSql += "COMMIT;\n";

  // Combine everything for full script
  const fullSql = schemaSql + "\n\n" + insertSql;

  return {
    schema: schemaSql,
    inserts: insertSql,
    full: fullSql,
    stats: {
      tables: tableCount,
      fields: fieldCount,
      relationships: relationshipCount,
      inserts: insertCount
    }
  };
}

// === API MODE FOR ELECTRON ===
export async function handleApiRequest(inputData) {
  try {
    const data = typeof inputData === 'string' ? JSON.parse(inputData) : inputData;
    
    if (data.action === 'xmlToJson') {
      const jsonResult = xmlToJson(data.xml, data.rules || defaultRules);
      return JSON.stringify(jsonResult, null, 2);
    } 
    else if (data.action === 'generateSql') {
      const jsonData = typeof data.json === 'string' ? JSON.parse(data.json) : data.json;
      const sqlResult = generateSqlSchema(jsonData);
      
      if (data.outputType === 'schema') {
        return sqlResult.schema;
      } else if (data.outputType === 'inserts') {
        return sqlResult.inserts;
      } else {
        return sqlResult.full;
      }
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
    .option('sql-type', {
      alias: 't',
      type: 'string',
      choices: ['schema', 'inserts', 'full'],
      default: 'full',
      description: 'Type of SQL output: schema, inserts, or full'
    })
    .option('verbose', {
      alias: 'v',
      type: 'boolean',
      description: 'Run with verbose output'
    })
    .example('$0 -x "<root><item>test</item></root>"', 'Convert XML string to SQL')
    .example('$0 -f input.xml -o schema.sql', 'Convert XML file to SQL file')
    .example('$0 -f input.xml -rf rules.json', 'Use custom rules from file')
    .example('$0 -f input.xml -t schema', 'Generate only schema SQL')
    .check((argv, options) => {
      if (!argv.xml && !argv.xmlFile) {
        throw new Error('Must provide either --xml or --xml-file');
      }
      return true;
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
      
      const sqlResult = generateSqlSchema(jsonResult);
      let sqlOutput = sqlResult.full;
      
      if (argv.sqlType === 'schema') {
        sqlOutput = sqlResult.schema;
      } else if (argv.sqlType === 'inserts') {
        sqlOutput = sqlResult.inserts;
      }
      
      if (argv.output) {
        fs.writeFileSync(argv.output, sqlOutput);
        if (argv.verbose) console.log(`💾 SQL saved to: ${argv.output}`);
      } else {
        console.log(sqlOutput);
      }
      
      if (argv.verbose) {
        console.log('✅ Conversion completed successfully!');
        console.log(`📊 Statistics:`);
        console.log(`   Tables: ${sqlResult.stats.tables}`);
        console.log(`   Fields: ${sqlResult.stats.fields}`);
        console.log(`   Relationships: ${sqlResult.stats.relationships}`);
        console.log(`   INSERT statements: ${sqlResult.stats.inserts}`);
      }
      
    } catch (error) {
      console.error('❌ Error:', error.message);
      if (argv.verbose) console.error(error.stack);
      process.exit(1);
    }
  }

  // Run the CLI
  main();
}