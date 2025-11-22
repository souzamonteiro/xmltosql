#!/usr/bin/env node

import express from 'express';
import cors from 'cors';
import path from 'path';
import { fileURLToPath } from 'url';
import { DOMParser } from 'xmldom';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Reuse the same conversion functions from converter.js
import { xmlToJson, generateFlatSqlSchema, defaultRules } from './converter.js';

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json({ limit: '10mb' }));
app.use(express.static(path.join(__dirname, 'src')));

// Routes
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'src', 'index.html'));
});

// API endpoint for XML to JSON conversion
app.post('/api/convert-to-json', (req, res) => {
  try {
    const { xml, rules = defaultRules } = req.body;
    
    if (!xml) {
      return res.status(400).json({ error: 'XML content is required' });
    }

    const jsonResult = xmlToJson(xml, rules);
    res.json({ success: true, result: jsonResult });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

// API endpoint for XML to SQL conversion
app.post('/api/convert-to-sql', (req, res) => {
  try {
    const { xml, rules = defaultRules } = req.body;
    
    if (!xml) {
      return res.status(400).json({ error: 'XML content is required' });
    }

    const jsonResult = xmlToJson(xml, rules);
    const sqlSchema = generateFlatSqlSchema(jsonResult);
    
    res.json({ success: true, result: sqlSchema });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

// Health check endpoint
app.get('/api/health', (req, res) => {
  res.json({ status: 'OK', timestamp: new Date().toISOString() });
});

// Start server
app.listen(PORT, () => {
  console.log(`🚀 Web server running at http://localhost:${PORT}`);
  console.log(`📋 API endpoints:`);
  console.log(`   POST /api/convert-to-json`);
  console.log(`   POST /api/convert-to-sql`);
  console.log(`   GET  /api/health`);
});