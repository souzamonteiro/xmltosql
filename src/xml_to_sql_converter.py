import xml.etree.ElementTree as ET
from collections import defaultdict
import re
import sys
import os
from datetime import datetime

class XMLToSQLConverter:
    def __init__(self):
        self.tables = defaultdict(dict)
        self.relationships = []
        self.namespace = {'ns': 'http://www.portalfiscal.inf.br/nfe'}
        
    def clean_name(self, name):
        """Remove caracteres especiais e converte para snake_case"""
        name = re.sub(r'[^a-zA-Z0-9_]', '_', name)
        name = re.sub(r'_+', '_', name)
        return name.lower()
    
    def infer_data_type(self, value):
        """Infere o tipo de dados baseado no valor"""
        if value is None:
            return 'VARCHAR(255)'
        
        value_str = str(value)
        
        # Verifica se é numérico
        try:
            float(value_str)
            if '.' in value_str:
                return 'DECIMAL(15,4)'
            else:
                return 'INTEGER'
        except ValueError:
            pass
        
        # Verifica se é data
        if re.match(r'\d{4}-\d{2}-\d{2}', value_str):
            return 'TIMESTAMP'
        
        # Verifica tamanho do texto
        length = len(value_str)
        if length <= 50:
            return 'VARCHAR(50)'
        elif length <= 100:
            return 'VARCHAR(100)'
        elif length <= 255:
            return 'VARCHAR(255)'
        else:
            return 'TEXT'
    
    def analyze_xml_structure(self, element, parent_path="", parent_table=""):
        """Analisa recursivamente a estrutura do XML"""
        current_path = f"{parent_path}/{element.tag.split('}')[-1]}" if parent_path else element.tag.split('}')[-1]
        current_table = self.clean_name(element.tag.split('}')[-1])
        
        # Se é um elemento que se repete, cria uma tabela separada
        if parent_table and len(element) > 0 and any(child.text for child in element):
            if current_table not in self.tables:
                self.tables[current_table] = {
                    'columns': {},
                    'primary_key': f'id_{current_table}',
                    'parent': parent_table
                }
                
            # Adiciona foreign key para a tabela pai
            if parent_table and current_table != parent_table:
                fk_column = f'id_{parent_table}'
                self.tables[current_table]['columns'][fk_column] = 'BIGINT'
                self.relationships.append({
                    'from_table': current_table,
                    'to_table': parent_table,
                    'from_column': fk_column,
                    'to_column': f'id_{parent_table}'
                })
        
        # Processa atributos
        for attr_name, attr_value in element.attrib.items():
            clean_attr = self.clean_name(attr_name)
            if parent_table:
                table_name = parent_table
            else:
                table_name = current_table
                
            if table_name not in self.tables:
                self.tables[table_name] = {
                    'columns': {},
                    'primary_key': f'id_{table_name}'
                }
            
            self.tables[table_name]['columns'][clean_attr] = self.infer_data_type(attr_value)
        
        # Processa elementos filhos
        has_text_content = element.text and element.text.strip()
        child_elements = list(element)
        
        if has_text_content and not child_elements:
            # Elemento com apenas texto
            if parent_table:
                table_name = parent_table
                column_name = self.clean_name(element.tag.split('}')[-1])
                
                if table_name not in self.tables:
                    self.tables[table_name] = {
                        'columns': {},
                        'primary_key': f'id_{table_name}'
                    }
                
                self.tables[table_name]['columns'][column_name] = self.infer_data_type(element.text)
        else:
            # Elemento com filhos, processa recursivamente
            for child in element:
                self.analyze_xml_structure(child, current_path, current_table)
    
    def generate_sql_script(self):
        """Gera o script SQL completo"""
        sql_script = ["-- SQL Schema gerado automaticamente a partir do XML da NFe"]
        sql_script.append("-- Otimizado para uso com Hibernate/JPA\n")
        
        # Cria sequência para IDs (se usar PostgreSQL)
        sql_script.append("CREATE SEQUENCE hibernate_sequence START 1 INCREMENT 1;\n")
        
        # Cria tabelas
        for table_name, table_info in self.tables.items():
            sql_script.append(f"CREATE TABLE {table_name} (")
            
            # Coluna ID primária
            pk_column = table_info['primary_key']
            sql_script.append(f"    {pk_column} BIGINT PRIMARY KEY,")
            
            # Demais colunas
            columns = list(table_info['columns'].items())
            for i, (col_name, col_type) in enumerate(columns):
                comma = "," if i < len(columns) - 1 else ""
                sql_script.append(f"    {col_name} {col_type}{comma}")
            
            sql_script.append(");\n")
        
        # Cria constraints de foreign keys
        for rel in self.relationships:
            sql_script.append(
                f"ALTER TABLE {rel['from_table']} "
                f"ADD CONSTRAINT fk_{rel['from_table']}_{rel['to_table']} "
                f"FOREIGN KEY ({rel['from_column']}) "
                f"REFERENCES {rel['to_table']}({rel['to_column']});"
            )
        
        # Cria índices para melhor performance
        for table_name in self.tables.keys():
            sql_script.append(f"CREATE INDEX idx_{table_name}_id ON {table_name}({self.tables[table_name]['primary_key']});")
        
        # Índices para foreign keys
        for rel in self.relationships:
            sql_script.append(f"CREATE INDEX idx_{rel['from_table']}_{rel['from_column']} ON {rel['from_table']}({rel['from_column']});")
        
        sql_script.append("\n-- Fim do script SQL")
        
        return "\n".join(sql_script)
    
    def generate_java_entities(self):
        """Gera classes Java/JPA completas com todos os métodos"""
        entities = []
        
        for table_name, table_info in self.tables.items():
            class_name = ''.join(word.capitalize() for word in table_name.split('_'))
            
            # Header da classe
            entities.append("package com.example.nfe.entities;")
            entities.append("")
            entities.append("import javax.persistence.*;")
            entities.append("import java.math.BigDecimal;")
            entities.append("import java.time.LocalDateTime;")
            entities.append("import java.util.Objects;")
            entities.append("")
            entities.append("@Entity")
            entities.append(f"@Table(name = \"{table_name}\")")
            entities.append(f"public class {class_name} {{")
            entities.append("")
            
            # Campos
            fields = []
            
            # Campo ID
            fields.append("    @Id")
            fields.append("    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = \"hibernate_sequence\")")
            fields.append("    @SequenceGenerator(name = \"hibernate_sequence\", sequenceName = \"hibernate_sequence\")")
            fields.append(f"    @Column(name = \"{table_info['primary_key']}\")")
            fields.append("    private Long id;")
            fields.append("")
            
            # Demais campos
            for col_name, col_type in table_info['columns'].items():
                java_type = self.get_java_type(col_type)
                field_name = self.convert_to_camel_case(col_name)
                
                # Verifica se é foreign key
                is_fk = col_name.startswith('id_') and any(r['from_column'] == col_name for r in self.relationships)
                
                if is_fk:
                    # Encontra a tabela relacionada
                    rel = next(r for r in self.relationships if r['from_column'] == col_name)
                    target_class = ''.join(word.capitalize() for word in rel['to_table'].split('_'))
                    
                    fields.append("    @ManyToOne(fetch = FetchType.LAZY)")
                    fields.append(f"    @JoinColumn(name = \"{col_name}\")")
                    fields.append(f"    private {target_class} {self.convert_to_camel_case(rel['to_table'])};")
                else:
                    fields.append(f"    @Column(name = \"{col_name}\")")
                    fields.append(f"    private {java_type} {field_name};")
                fields.append("")
            
            # Construtor padrão
            fields.append(f"    public {class_name}() {{")
            fields.append("        // Construtor padrão exigido pelo JPA")
            fields.append("    }")
            fields.append("")
            
            # Construtor com campos
            field_names = []
            for col_name in table_info['columns'].keys():
                is_fk = col_name.startswith('id_') and any(r['from_column'] == col_name for r in self.relationships)
                if not is_fk:
                    field_names.append(self.convert_to_camel_case(col_name))
            
            if field_names:
                constructor_params = []
                for field_name in field_names:
                    java_type = next(self.get_java_type(table_info['columns'][col]) 
                                   for col in table_info['columns'] 
                                   if self.convert_to_camel_case(col) == field_name)
                    constructor_params.append(f"{java_type} {field_name}")
                
                fields.append(f"    public {class_name}({', '.join(constructor_params)}) {{")
                for field_name in field_names:
                    fields.append(f"        this.{field_name} = {field_name};")
                fields.append("    }")
                fields.append("")
            
            # Getters e Setters
            all_fields = ['id'] + [self.convert_to_camel_case(col) for col in table_info['columns'].keys()]
            
            # Adiciona campos de relacionamento
            for rel in [r for r in self.relationships if r['from_table'] == table_name]:
                field_name = self.convert_to_camel_case(rel['to_table'])
                target_class = ''.join(word.capitalize() for word in rel['to_table'].split('_'))
                all_fields.append(field_name)
                
                # Getter para relacionamento
                fields.append(f"    public {target_class} get{field_name.capitalize()}() {{")
                fields.append(f"        return {field_name};")
                fields.append("    }")
                fields.append("")
                
                # Setter para relacionamento
                fields.append(f"    public void set{field_name.capitalize()}({target_class} {field_name}) {{")
                fields.append(f"        this.{field_name} = {field_name};")
                fields.append("    }")
                fields.append("")
            
            for field_name in all_fields:
                if field_name == 'id':
                    java_type = 'Long'
                else:
                    # Encontra o tipo correto
                    if any(r['from_table'] == table_name and self.convert_to_camel_case(r['to_table']) == field_name for r in self.relationships):
                        rel = next(r for r in self.relationships if r['from_table'] == table_name and self.convert_to_camel_case(r['to_table']) == field_name)
                        java_type = ''.join(word.capitalize() for word in rel['to_table'].split('_'))
                    else:
                        col_name = next((col for col in table_info['columns'] if self.convert_to_camel_case(col) == field_name), None)
                        if col_name:
                            java_type = self.get_java_type(table_info['columns'][col_name])
                        else:
                            continue
                
                # Getter
                fields.append(f"    public {java_type} get{field_name.capitalize()}() {{")
                fields.append(f"        return {field_name};")
                fields.append("    }")
                fields.append("")
                
                # Setter
                fields.append(f"    public void set{field_name.capitalize()}({java_type} {field_name}) {{")
                fields.append(f"        this.{field_name} = {field_name};")
                fields.append("    }")
                fields.append("")
            
            # equals e hashCode
            fields.append("    @Override")
            fields.append("    public boolean equals(Object o) {")
            fields.append("        if (this == o) return true;")
            fields.append("        if (o == null || getClass() != o.getClass()) return false;")
            fields.append(f"        {class_name} that = ({class_name}) o;")
            fields.append("        return Objects.equals(id, that.id);")
            fields.append("    }")
            fields.append("")
            
            fields.append("    @Override")
            fields.append("    public int hashCode() {")
            fields.append("        return Objects.hash(id);")
            fields.append("    }")
            fields.append("")
            
            # toString - CORRIGIDO
            fields.append("    @Override")
            fields.append("    public String toString() {")
            fields.append(f"        return \"{class_name}{{\" +")
            
            toString_fields = ['id']
            for col_name in table_info['columns'].keys():
                if not col_name.startswith('id_') or not any(r['from_column'] == col_name for r in self.relationships):
                    toString_fields.append(self.convert_to_camel_case(col_name))
            
            toString_parts = []
            for i, field in enumerate(toString_fields):
                if i == 0:
                    toString_parts.append(f'                \"{field}=\" + {field}')
                else:
                    toString_parts.append(f'                \", {field}=\" + {field}')
            
            fields.append(" + \n".join(toString_parts) + " +")
            fields.append("                '}';")
            fields.append("    }")
            
            # Fim da classe
            entities.extend(fields)
            entities.append("}")
            entities.append("")
        
        return "\n".join(entities)
    
    def get_java_type(self, sql_type):
        """Converte tipo SQL para tipo Java"""
        type_mapping = {
            'BIGINT': 'Long',
            'INTEGER': 'Integer',
            'DECIMAL': 'BigDecimal',
            'VARCHAR': 'String',
            'TEXT': 'String',
            'TIMESTAMP': 'LocalDateTime'
        }
        
        for sql, java in type_mapping.items():
            if sql in sql_type:
                return java
        return 'String'
    
    def convert_to_camel_case(self, snake_str):
        """Converte snake_case para camelCase"""
        components = snake_str.split('_')
        return components[0] + ''.join(x.title() for x in components[1:])

def process_xml_file(xml_file_path):
    """Processa um arquivo XML individual"""
    print(f"\n{'='*60}")
    print(f"Processando arquivo: {xml_file_path}")
    print(f"{'='*60}")
    
    try:
        # Verifica se o arquivo existe
        if not os.path.exists(xml_file_path):
            print(f"ERRO: Arquivo não encontrado: {xml_file_path}")
            return False
        
        # Lê o conteúdo do arquivo
        with open(xml_file_path, 'r', encoding='utf-8') as f:
            xml_content = f.read()
        
        # Cria o conversor
        converter = XMLToSQLConverter()
        
        # Parse do XML
        root = ET.fromstring(xml_content)
        
        # Encontra o elemento NFe dentro do namespace
        nfe_element = root.find('.//ns:NFe', converter.namespace)
        if nfe_element is None:
            nfe_element = root
        
        # Analisa a estrutura do XML
        converter.analyze_xml_structure(nfe_element)
        
        # Gera nomes de arquivo baseados no arquivo de entrada
        base_name = os.path.splitext(os.path.basename(xml_file_path))[0]
        sql_file = f"{base_name}_schema.sql"
        java_file = f"{base_name}_entities.java"
        
        # Gera SQL
        sql_script = converter.generate_sql_script()
        print("✓ Script SQL gerado com sucesso")
        
        # Gera classes Java
        java_entities = converter.generate_java_entities()
        print("✓ Classes Java completas geradas com sucesso")
        
        # Salva em arquivos
        with open(sql_file, 'w', encoding='utf-8') as f:
            f.write(sql_script)
        
        with open(java_file, 'w', encoding='utf-8') as f:
            f.write(java_entities)
            
        print(f"✓ Arquivos salvos:")
        print(f"  - {sql_file}")
        print(f"  - {java_file}")
        
        # Exibe estatísticas
        print(f"\n📊 Estatísticas:")
        print(f"  - Tabelas criadas: {len(converter.tables)}")
        print(f"  - Relacionamentos: {len(converter.relationships)}")
        
        return True
        
    except ET.ParseError as e:
        print(f"❌ Erro ao parsear XML: {e}")
        return False
    except Exception as e:
        print(f"❌ Erro ao processar arquivo: {e}")
        return False

def main():
    """Função principal que processa arquivos da linha de comando"""
    
    # Verifica se foram passados argumentos
    if len(sys.argv) < 2:
        print("Uso: python xml_to_sql_converter.py <arquivo1.xml> [arquivo2.xml ...]")
        print("\nExemplos:")
        print("  python xml_to_sql_converter.py nfe.xml")
        print("  python xml_to_sql_converter.py nfe1.xml nfe2.xml nfe3.xml")
        print("  python xml_to_sql_converter.py *.xml")
        return
    
    # Lista de arquivos para processar
    xml_files = sys.argv[1:]
    
    print("🚀 Iniciando conversão de XML para SQL/Hibernate")
    print(f"📁 Arquivos a processar: {len(xml_files)}")
    
    # Contadores de sucesso/erro
    success_count = 0
    error_count = 0
    
    # Processa cada arquivo
    for xml_file in xml_files:
        if process_xml_file(xml_file):
            success_count += 1
        else:
            error_count += 1
    
    # Resumo final
    print(f"\n{'='*60}")
    print("📋 RESUMO FINAL")
    print(f"{'='*60}")
    print(f"✅ Arquivos processados com sucesso: {success_count}")
    print(f"❌ Arquivos com erro: {error_count}")
    print(f"📊 Total de arquivos: {len(xml_files)}")
    
    if success_count > 0:
        print(f"\n🎉 Conversão concluída! Os seguintes arquivos foram gerados:")
        for xml_file in xml_files:
            if os.path.exists(xml_file):
                base_name = os.path.splitext(os.path.basename(xml_file))[0]
                print(f"   📄 {base_name}_schema.sql")
                print(f"   📄 {base_name}_entities.java")

if __name__ == "__main__":
    main()
