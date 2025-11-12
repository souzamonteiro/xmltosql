# XML to SQL & Hibernate Entity Generator

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Python](https://img.shields.io/badge/Python-3.6%2B-blue)](https://www.python.org/)
[![Java](https://img.shields.io/badge/Java-8%2B-orange)](https://www.java.com/)

A powerful Python tool that automatically converts Brazilian NFe (Nota Fiscal Eletrônica) XML files into complete SQL database schemas and Java JPA/Hibernate entities. Perfect for integrating NFe data into Java applications with full ORM support.

## Features

- **🔧 Automatic Schema Generation**: Converts XML structure to optimized SQL tables
- **🚀 Complete JPA Entities**: Generates full Java beans with Hibernate annotations
- **🔄 Relationship Mapping**: Automatically creates foreign keys and relationships
- **📊 Data Type Inference**: Intelligently maps XML data types to SQL/Java types
- **⚡ Performance Optimized**: Includes indexes and constraints
- **🎯 Batch Processing**: Handles multiple XML files in one execution

## Generated Output

- **SQL Scripts**: Complete database schema with tables, constraints, and indexes
- **Java Entities**: Full JPA entities with:
  - Hibernate annotations (`@Entity`, `@Table`, `@Column`, etc.)
  - Complete getters and setters
  - `equals()`, `hashCode()`, and `toString()` methods
  - Constructors (default and parameterized)
  - Relationship mappings (`@ManyToOne`, `@JoinColumn`)
  - Proper import statements

## Requirements

- Python 3.6 or higher
- Java 8 or higher (for using generated entities)
- PostgreSQL, MySQL, or any JPA-compatible database

## Installation

1. Clone or download this repository
2. Ensure Python 3.6+ is installed on your system
3. No additional dependencies required - uses only Python standard library

## Usage

### Basic Usage

```bash
# Process a single XML file
python3 xml_to_sql.py nfe.xml

# Process multiple XML files
python3 xml_to_sql.py nfe1.xml nfe2.xml nfe3.xml

# Process all XML files in directory
python3 xml_to_sql.py *.xml
```

### Output Files

For each input XML file, the tool generates:

- `{filename}_schema.sql` - Complete SQL schema
- `{filename}_entities.java` - Java JPA entities

### Example

```bash
python3 xml_to_sql.py nota_fiscal_123.xml
```

Generates:
- `nota_fiscal_123_schema.sql`
- `nota_fiscal_123_entities.java`

## Generated SQL Features

- **Primary Keys**: Auto-incrementing BIGINT primary keys
- **Foreign Keys**: Proper relationship constraints
- **Indexes**: Performance-optimized indexes
- **Data Types**: Appropriate SQL types based on XML content
- **Sequences**: Hibernate sequence for ID generation

## Generated Java Features

- **JPA Annotations**: Full Hibernate/JPA support
- **Complete Beans**: All required methods and constructors
- **Type Safety**: Proper Java types (BigDecimal, LocalDateTime, etc.)
- **Relationships**: Correctly mapped entity relationships
- **Best Practices**: Follows Java and JPA conventions

## Example Generated Entity

```java
@Entity
@Table(name = "prod")
public class Prod {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "hibernate_sequence")
    @SequenceGenerator(name = "hibernate_sequence", sequenceName = "hibernate_sequence")
    @Column(name = "id_prod")
    private Long id;

    @Column(name = "cprod")
    private String cprod;

    @Column(name = "xprod")
    private String xprod;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_det")
    private Det det;

    // Constructors, getters, setters, equals, hashCode, toString...
}
```

## Supported XML Structure

The tool is specifically designed for Brazilian NFe (Nota Fiscal Eletrônica) XML format, including:

- NFe header information (emitente, destinatário)
- Product details (det/prod)
- Tax information (ICMS, IPI, PIS, COFINS)
- Shipping and payment data
- Additional information and technical details

## Database Support

The generated SQL is compatible with most relational databases:
- PostgreSQL (recommended)
- MySQL/MariaDB
- Oracle
- SQL Server
- H2 Database

## Integration with Spring Boot

Add the generated entities to your Spring Boot project:

1. Copy the Java entities to `src/main/java/com/yourpackage/entities/`
2. Configure your `application.properties`:

```properties
# PostgreSQL example
spring.datasource.url=jdbc:postgresql://localhost:5432/nfe_db
spring.datasource.username=your_username
spring.datasource.password=your_password
spring.jpa.hibernate.ddl-auto=validate
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect
```

## Project Structure

```
xml_to_sql.py              # Main conversion script
nfe_schema.sql            # Generated SQL schema (example)
nfe_entities.java         # Generated Java entities (example)
README.md                 # This file
```

## Performance Notes

- The generated schema includes indexes for all primary and foreign keys
- Large XML files may take a few seconds to process
- For production use, consider adding additional indexes based on query patterns

## Troubleshooting

### Common Issues

1. **Encoding Problems**: Ensure XML files are UTF-8 encoded
2. **Large Files**: The tool can handle large NFe files, but very large files may require more memory
3. **Invalid XML**: Verify that input files are valid XML documents

### Error Messages

- `File not found`: Check the file path and permissions
- `XML parsing error`: Verify XML file is valid and well-formed
- `Permission denied`: Ensure write permissions in output directory

## Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues for bugs and feature requests.

## License

Copyright 2024 XML to SQL Generator Contributors

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

## Disclaimer

This tool is designed for Brazilian NFe XML formats. While it should work with any well-formed XML, it's optimized for the specific structure of NFe documents. Always verify the generated schema and entities for your specific use case.

## Support

For issues and questions:
1. Check the troubleshooting section above
2. Review generated files for any inconsistencies
3. Ensure your XML files follow the NFe standard format

---

**Happy coding!** 🚀
