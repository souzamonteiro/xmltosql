#!/usr/bin/env node

import { execSync } from 'child_process';
import fs from 'fs';

const sizes = [192, 512, 144, 96, 72, 48, 36];
const svgContent = `...`; // Coloque o conteúdo SVG aqui

// Salvar SVG original
fs.writeFileSync('src/icon.svg', svgContent);

console.log('🎨 Gerando ícones...');

// Nota: Você precisaria do ImageMagick ou outra ferramenta
// Para converter SVG para PNG no Termux

sizes.forEach(size => {
  const filename = `src/icon-${size}.png`;
  console.log(`Criando: ${filename}`);
  
  // No Termux, você pode usar:
  // pkg install imagemagick
  // convert -background none -resize ${size}x${size} src/icon.svg ${filename}
});