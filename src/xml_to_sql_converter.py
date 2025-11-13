import xml.etree.ElementTree as ET
from collections import defaultdict
import re
import sys
import os
from decimal import Decimal, InvalidOperation

class XMLToSQLConverter:
    def __init__(self):
        self.tables = defaultdict(dict)
        self.relationships = []
        self.value_samples = defaultdict(list)
        self.table_counter = 1
        
    def clean_name(self, name):
        """Remove special characters and convert to snake_case"""
        if '}' in name:
            name = name.split('}')[-1]
        name = re.sub(r'[^a-zA-Z0-9_]', '_', name)
        name = re.sub(r'_+', '_', name)
        return name.lower()
    
    def analyze_value_pattern(self, value):
        """Generic value pattern analysis for any XML"""
        if value is None or value == "":
            return 'VARCHAR(255)'
        
        value_str = str(value).strip()
        
        # 1. Check for datetime patterns
        dt_pattern = self._check_datetime_pattern(value_str)
        if dt_pattern:
            return dt_pattern
        
        # 2. Check for boolean patterns
        if self._is_boolean(value_str):
            return 'BOOLEAN'
        
        # 3. Check for numeric patterns
        num_pattern = self._check_numeric_pattern(value_str)
        if num_pattern:
            return num_pattern
        
        # 4. Check for UUID/GUID patterns
        if self._is_uuid(value_str):
            return 'UUID'
        
        # 5. Check for email patterns
        if self._is_email(value_str):
            return 'VARCHAR(255)'
        
        # 6. Check for URL patterns
        if self._is_url(value_str):
            return 'VARCHAR(500)'
        
        # 7. Default to string based on length and content analysis
        return self._determine_string_type(value_str)
    
    def _check_datetime_pattern(self, value):
        """Check for various datetime patterns"""
        patterns = [
            # ISO 8601 with timezone
            (r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}[+-]\d{2}:\d{2}$', 'TIMESTAMP'),
            # ISO 8601 without timezone
            (r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}$', 'TIMESTAMP'),
            # Date only
            (r'^\d{4}-\d{2}-\d{2}$', 'DATE'),
            # Various date formats
            (r'^\d{2}/\d{2}/\d{4}$', 'DATE'),
            (r'^\d{2}-\d{2}-\d{4}$', 'DATE'),
            # Time only
            (r'^\d{2}:\d{2}:\d{2}$', 'TIME'),
            (r'^\d{2}:\d{2}:\d{2}\.\d+$', 'TIME'),
        ]
        
        for pattern, sql_type in patterns:
            if re.match(pattern, value):
                return sql_type
        return None
    
    def _is_boolean(self, value):
        """Check for boolean patterns"""
        boolean_values = {'true', 'false', '1', '0', 'yes', 'no', 'y', 'n', 't', 'f'}
        return value.lower() in boolean_values
    
    def _check_numeric_pattern(self, value):
        """Comprehensive numeric type analysis"""
        # Skip if value contains letters (except for decimal separators and minus sign)
        if re.search(r'[a-zA-Z]', value.replace(',', '').replace('.', '').replace('-', '')):
            return None
            
        cleaned = re.sub(r'[^\d.,-]', '', value)
        if not cleaned:
            return None
        
        try:
            # Handle different decimal separators
            if ',' in cleaned and '.' in cleaned:
                # If both separators present, assume comma is thousands and dot is decimal
                if cleaned.rfind(',') > cleaned.rfind('.'):
                    cleaned = cleaned.replace('.', '').replace(',', '.')
                else:
                    cleaned = cleaned.replace(',', '')
            elif ',' in cleaned:
                # Check if comma is used as decimal separator
                parts = cleaned.split(',')
                if len(parts) == 2 and len(parts[1]) <= 2:
                    # Likely decimal separator (e.g., "123,45")
                    cleaned = cleaned.replace(',', '.')
                else:
                    # Likely thousands separator (e.g., "1,234")
                    cleaned = cleaned.replace(',', '')
            
            cleaned = re.sub(r'[^\d.-]', '', cleaned)
            
            if not cleaned or cleaned == '-' or cleaned == '.':
                return None
                
            numeric_value = Decimal(cleaned)
            
            # Check if it's an integer
            if numeric_value == numeric_value.to_integral_value():
                # Integer types based on value range
                if abs(numeric_value) <= 127:
                    return 'SMALLINT'
                elif abs(numeric_value) <= 32767:
                    return 'INTEGER'
                elif abs(numeric_value) <= 2147483647:
                    return 'BIGINT'
                else:
                    return 'NUMERIC(20,0)'
            else:
                # Decimal type - analyze precision and scale
                parts = str(numeric_value).split('.')
                integer_digits = len(parts[0].lstrip('-'))
                decimal_digits = len(parts[1]) if len(parts) > 1 else 0
                
                total_digits = integer_digits + decimal_digits
                if total_digits <= 15:
                    return f'DECIMAL(15,{min(decimal_digits, 4)})'
                else:
                    return f'DECIMAL({total_digits},{min(decimal_digits, 4)})'
                    
        except (InvalidOperation, ValueError):
            return None
    
    def _is_uuid(self, value):
        """Check for UUID/GUID patterns"""
        uuid_patterns = [
            r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
            r'^[0-9a-f]{32}$',
            r'^{[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}}$',
        ]
        return any(re.match(pattern, value.lower()) for pattern in uuid_patterns)
    
    def _is_email(self, value):
        """Check for email pattern"""
        email_pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
        return re.match(email_pattern, value) is not None
    
    def _is_url(self, value):
        """Check for URL pattern"""
        url_pattern = r'^(https?|ftp)://[^\s/$.?#].[^\s]*$'
        return re.match(url_pattern, value) is not None
    
    def _determine_string_type(self, value):
        """Determine appropriate string type based on content analysis"""
        length = len(value)
        
        # Analyze content characteristics
        has_spaces = ' ' in value
        has_special_chars = bool(re.search(r'[^a-zA-Z0-9\s\.\-_]', value))
        is_multi_line = '\n' in value
        
        if is_multi_line or length > 1000:
            return 'TEXT'
        elif length <= 10 and not has_spaces and not has_special_chars:
            return 'VARCHAR(10)'
        elif length <= 20 and not has_spaces:
            return 'VARCHAR(20)'
        elif length <= 50:
            return 'VARCHAR(50)'
        elif length <= 100:
            return 'VARCHAR(100)'
        elif length <= 255:
            return 'VARCHAR(255)'
        elif length <= 500:
            return 'VARCHAR(500)'
        elif length <= 1000:
            return 'VARCHAR(1000)'
        else:
            return 'TEXT'

    def analyze_xml_structure(self, element, parent_table="", depth=0, path=""):
        """Recursively analyzes XML structure for any type of XML"""
        if depth > 20:  # Prevent infinite recursion
            return
        
        current_tag = element.tag.split('}')[-1] if '}' in element.tag else element.tag
        current_table = self.clean_name(current_tag)
        current_path = f"{path}/{current_tag}" if path else current_tag
        
        # Collect value samples for type inference
        if element.text and element.text.strip():
            element_text = element.text.strip()
            sample_key = f"{current_path}/text"
            self.value_samples[sample_key].append(element_text)
        
        # TABLE DETECTION LOGIC - Generic approach
        should_create_table = self._should_create_table(element, current_tag, depth, parent_table)
        
        # Determine target table for columns
        if should_create_table:
            target_table = current_table
            if target_table not in self.tables:
                self.tables[target_table] = {
                    'columns': {},
                    'primary_key': f'id_{target_table}',
                    'parent': parent_table,
                }
            
            # Add foreign key to parent table
            if parent_table and target_table != parent_table:
                fk_column = f'id_{parent_table}'
                self.tables[target_table]['columns'][fk_column] = 'BIGINT'
                
                if not any(r['from_column'] == fk_column and r['from_table'] == target_table 
                          for r in self.relationships):
                    self.relationships.append({
                        'from_table': target_table,
                        'to_table': parent_table,
                        'from_column': fk_column,
                        'to_column': f'id_{parent_table}'
                    })
        else:
            target_table = parent_table if parent_table else current_table
        
        # Ensure target table exists
        if target_table and target_table not in self.tables:
            self.tables[target_table] = {
                'columns': {},
                'primary_key': f'id_{target_table}',
                'parent': parent_table,
            }
        
        # Process attributes as columns
        for attr_name, attr_value in element.attrib.items():
            clean_attr = self.clean_name(attr_name)
            attr_sample_key = f"{current_path}/@{attr_name}"
            self.value_samples[attr_sample_key].append(attr_value)
            
            samples = self.value_samples[attr_sample_key]
            inferred_type = self.analyze_value_pattern(attr_value)
            self.tables[target_table]['columns'][clean_attr] = inferred_type
        
        # Process element content
        has_text_content = element.text and element.text.strip()
        child_elements = list(element)
        
        if has_text_content and not child_elements:
            column_name = self.clean_name(current_tag)
            sample_key = f"{current_path}/text"
            samples = self.value_samples[sample_key]
            inferred_type = self.analyze_value_pattern(element.text.strip())
            self.tables[target_table]['columns'][column_name] = inferred_type
        
        # Process children recursively
        for child in child_elements:
            child_target_table = current_table if should_create_table else target_table
            self.analyze_xml_structure(child, child_target_table, depth + 1, current_path)
    
    def _should_create_table(self, element, tag_name, depth, parent_table):
        """Generic table creation logic for any XML"""
        child_elements = list(element)
        
        # Root element always becomes a table
        if depth == 0:
            return True
        
        # Elements with attributes are good table candidates
        if element.attrib:
            return True
        
        # Elements with multiple different children
        if child_elements:
            child_tags = set(child.tag.split('}')[-1].lower() for child in child_elements)
            if len(child_tags) > 2:
                return True
            
            # If many children of same type, might be a list (create table)
            if len(child_elements) > 3 and len(child_tags) == 1:
                return True
        
        # Elements that appear to be complex structures
        if len(child_elements) > 0 and any(len(list(child)) > 0 for child in child_elements):
            return True
        
        return False

    def generate_sql_script(self):
        """Generates SQL script with discovered data types"""
        sql_script = ["-- SQL Schema automatically generated from XML"]
        sql_script.append("-- Generic XML to SQL converter\n")
        
        sql_script.append("CREATE SEQUENCE hibernate_sequence START 1 INCREMENT 1;\n")
        
        # Create tables
        for table_name, table_info in self.tables.items():
            data_columns = {k: v for k, v in table_info['columns'].items() 
                          if not k.startswith('id_') or k == table_info['primary_key']}
            
            if len(data_columns) <= 1:
                continue
                
            sql_script.append(f"CREATE TABLE {table_name} (")
            
            pk_column = table_info['primary_key']
            sql_script.append(f"    {pk_column} BIGINT PRIMARY KEY,")
            
            columns = list(data_columns.items())
            for i, (col_name, col_type) in enumerate(columns):
                if col_name != pk_column:
                    comma = "," if i < len(columns) - 1 or any(c[0] != pk_column for c in columns[i+1:]) else ""
                    sql_script.append(f"    {col_name} {col_type}{comma}")
            
            sql_script.append(");\n")
        
        # Foreign keys
        if self.relationships:
            sql_script.append("-- Foreign key constraints")
            for rel in self.relationships:
                if (rel['from_table'] in self.tables and 
                    rel['to_table'] in self.tables):
                    sql_script.append(
                        f"ALTER TABLE {rel['from_table']} "
                        f"ADD CONSTRAINT fk_{rel['from_table']}_{rel['to_table']} "
                        f"FOREIGN KEY ({rel['from_column']}) "
                        f"REFERENCES {rel['to_table']}({rel['to_column']});"
                    )
        
        # Indexes
        sql_script.append("\n-- Indexes for performance")
        for table_name, table_info in self.tables.items():
            if len(table_info['columns']) > 1:
                pk = table_info['primary_key']
                sql_script.append(f"CREATE INDEX idx_{table_name}_pk ON {table_name}({pk});")
        
        for rel in self.relationships:
            if rel['from_table'] in self.tables:
                sql_script.append(f"CREATE INDEX idx_{rel['from_table']}_{rel['from_column']} ON {rel['from_table']}({rel['from_column']});")
        
        sql_script.append("\n-- End of SQL script")
        return "\n".join(sql_script)

def process_xml_file(xml_file_path):
    """Processes individual XML file"""
    print(f"\n{'='*60}")
    print(f"Processing file: {xml_file_path}")
    print(f"{'='*60}")
    
    try:
        if not os.path.exists(xml_file_path):
            print(f"ERROR: File not found: {xml_file_path}")
            return False
        
        with open(xml_file_path, 'r', encoding='utf-8') as f:
            xml_content = f.read()
        
        converter = XMLToSQLConverter()
        root = ET.fromstring(xml_content)
        
        converter.analyze_xml_structure(root)
        
        if not converter.tables:
            print(f"WARNING: No tables generated from XML structure")
            return False
        
        base_name = os.path.splitext(os.path.basename(xml_file_path))[0]
        output_dir = f"{base_name}_output"
        
        if not os.path.exists(output_dir):
            os.makedirs(output_dir)
        
        sql_script = converter.generate_sql_script()
        sql_file = os.path.join(output_dir, f"{base_name}_schema.sql")
        
        with open(sql_file, 'w', encoding='utf-8') as f:
            f.write(sql_script)
        
        print(f"✅ SQL script generated successfully: {sql_file}")
        
        print(f"\n📊 Statistics:")
        print(f"  - Tables created: {len(converter.tables)}")
        print(f"  - Relationships: {len(converter.relationships)}")
        
        # Show some type inference examples
        print(f"\n🔍 Type inference examples:")
        for sample_key, samples in list(converter.value_samples.items())[:5]:
            if samples:
                inferred_type = converter.analyze_value_pattern(samples[0])
                print(f"  - {sample_key}: '{samples[0]}' → {inferred_type}")
        
        return True
        
    except Exception as e:
        print(f"❌ Error processing file: {e}")
        import traceback
        traceback.print_exc()
        return False

def main():
    if len(sys.argv) < 2:
        print("Generic XML to SQL Converter")
        print("Usage: python xml_to_sql_converter.py <file1.xml> [file2.xml ...]")
        return
    
    xml_files = sys.argv[1:]
    print("🚀 Starting XML to SQL conversion")
    
    valid_files = [f for f in xml_files if os.path.exists(f) and f.lower().endswith('.xml')]
    
    if not valid_files:
        print("❌ No valid XML files to process")
        return
    
    success_count = 0
    for xml_file in valid_files:
        if process_xml_file(xml_file):
            success_count += 1
    
    print(f"\n{'='*60}")
    print(f"✅ Files processed successfully: {success_count}/{len(valid_files)}")

if __name__ == "__main__":
    main()