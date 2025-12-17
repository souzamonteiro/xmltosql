#!/usr/bin/env node

import express from 'express';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import https from 'https';
import http from 'http';

// Reuse the same conversion functions from converter.js
import { xmlToJson, generateSqlSchema, defaultRules } from './converter.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();
const PORT_HTTP = 3000;
const PORT_HTTPS = 3443;

// Middleware to parse JSON requests
app.use(express.json());

// Serve static files from the www directory
app.use(express.static(path.join(__dirname, 'www')));

// Your existing endpoints
app.get('/api/status', (req, res) => {
    res.json({ status: 'Server is running', timestamp: new Date() });
});

app.get('/api/data', (req, res) => {
    res.json({ message: 'This is API data' });
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
    const sqlSchema = generateSqlSchema(jsonResult);
    
    res.json({ success: true, result: sqlSchema });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

// Handle 404 for API routes
app.use('/api/*', (req, res) => {
    res.status(404).json({ error: 'API endpoint not found' });
});

// For non-API routes that aren't static files, serve index.html (for SPAs)
app.get('*', (req, res) => {
    // Check if the request is for an API endpoint
    if (req.path.startsWith('/api/')) {
        return res.status(404).json({ error: 'API endpoint not found' });
    }
    
    // Otherwise, check if file exists in www directory
    const filePath = path.join(__dirname, 'www', req.path);
    if (fs.existsSync(filePath) && !fs.statSync(filePath).isDirectory()) {
        return res.sendFile(filePath);
    }
    
    // For Single Page Applications, serve index.html for routes not found
    res.sendFile(path.join(__dirname, 'www', 'index.html'));
});

// Check for SSL certificates
const sslOptions = {
    key: fs.existsSync('localhost+2-key.pem') ? fs.readFileSync('localhost+2-key.pem') : null,
    cert: fs.existsSync('localhost+2.pem') ? fs.readFileSync('localhost+2.pem') : null
};

// Start HTTP server
http.createServer(app).listen(PORT_HTTP, () => {
    console.log(`HTTP server running on port ${PORT_HTTP}`);
});

// Start HTTPS server if certificates exist
if (sslOptions.key && sslOptions.cert) {
    https.createServer(sslOptions, app).listen(PORT_HTTPS, () => {
        console.log(`HTTPS server running on port ${PORT_HTTPS}`);
    });
    console.log('HTTPS enabled with SSL certificates');
} else {
    console.log('HTTPS not enabled - missing localhost+2-key.pem or localhost+2.pem files');
    console.log('To generate self-signed certificates, run:');
    console.log('openssl req -x509 -newkey rsa:4096 -keyout localhost+2-key.pem -out localhost+2.pem -days 365 -nodes');
}

console.log(`Server is configured to serve all files from: ${path.join(__dirname, 'www')}`);