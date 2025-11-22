# XML to SQL Converter

A comprehensive tool to convert XML documents to SQL schema with automatic type detection.

## Features

- 🚀 **Multiple Interfaces**: CLI, Web, Desktop (Electron)
- 🔧 **Automatic Type Detection**: Intelligent type detection
- 📊 **Custom Rules**: Define custom type mapping rules
- 🗃️ **SQL Schema Generation**: PostgreSQL-compatible schema
- 💾 **Multiple Output Formats**: JSON and SQL

## Installation

```bash
git clone https://github.com/yourusername/xml-to-sql-converter
cd xml-to-sql-converter
npm install
```

## Usage
### CLI Tool

- Convert XML file to SQL
```bash
npm start -- -f input.xml -o schema.sql
```

- Or use directly
```bash
node converter.js -f input.xml -o schema.sql
```

- With custom rules
```bash
node converter.js -f input.xml -rf rules/nfe-rules.json -o schema.sql
```

### Web Server
```bash
npm run serve
# Open http://localhost:3000
```

### Electron Desktop App
```bash
npm run electron
```

## Examples

### Convert NFe XML
```bash
node converter.js -f nfe.xml -rf rules/nfe-rules.json -o nfe_schema.sql
```

### Convert with custom rules
```bash
node converter.js -f data.xml -r '{"string":["id"],"integer":["code"]}' -o schema.sql
```

