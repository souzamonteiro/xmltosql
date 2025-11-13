import re
import os
import sys

def extract_entities_properly(java_file_path):
    """Extrai entidades corretamente preservando todos os métodos"""
    
    print(f"📁 Processando: {java_file_path}")
    
    try:
        with open(java_file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Encontra todas as ocorrências de "package" para dividir as entidades
        package_positions = []
        for match in re.finditer(r'package com\.example\.nfe\.entities;', content):
            package_positions.append(match.start())
        
        print(f"📦 Encontrados {len(package_positions)} blocos de entidades")
        
        # Cria diretório para as entidades
        entities_dir = "proper-entities"
        if not os.path.exists(entities_dir):
            os.makedirs(entities_dir)
            print(f"📂 Criado diretório: {entities_dir}")
        
        # Extrai cada entidade
        entities_count = 0
        for i in range(len(package_positions)):
            start_pos = package_positions[i]
            if i < len(package_positions) - 1:
                end_pos = package_positions[i + 1]
            else:
                end_pos = len(content)
            
            entity_content = content[start_pos:end_pos].strip()
            
            # Encontra o nome da classe
            class_match = re.search(r'public class (\w+)', entity_content)
            if class_match:
                class_name = class_match.group(1)
                
                # Salva a entidade completa
                file_path = os.path.join(entities_dir, f"{class_name}.java")
                with open(file_path, 'w', encoding='utf-8') as f:
                    f.write(entity_content)
                
                print(f"  ✅ {class_name}.java")
                entities_count += 1
        
        print(f"🎉 {entities_count} entidades salvas em: {entities_dir}/")
        return True
        
    except Exception as e:
        print(f"❌ Erro ao processar arquivo: {e}")
        import traceback
        traceback.print_exc()
        return False

def main():
    """Função principal"""
    if len(sys.argv) < 2:
        print("Uso: python extract_entities_properly.py <arquivo_entities.java>")
        print("Exemplo: python extract_entities_properly.py NFe-teste_entities.java")
        return
    
    java_file = sys.argv[1]
    
    if not os.path.exists(java_file):
        print(f"❌ Arquivo não encontrado: {java_file}")
        return
    
    extract_entities_properly(java_file)

if __name__ == "__main__":
    main()