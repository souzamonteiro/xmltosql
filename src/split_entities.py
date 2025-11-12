import os
import re

def split_java_entities(java_file_path):
    """Separa um arquivo Java com múltiplas entidades em arquivos individuais"""
    
    print(f"📁 Processando: {java_file_path}")
    
    try:
        with open(java_file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Encontra todas as classes no arquivo
        class_pattern = r'@Entity\s*@Table\(name\s*=\s*"[^"]+"\)\s*public\s+class\s+(\w+)\s*\{[^}]*(?:\{[^}]*\}[^}]*)*\}'
        classes = re.findall(class_pattern, content, re.DOTALL)
        
        # Encontra o conteúdo de cada classe
        class_content_pattern = r'(@Entity\s*@Table\(name\s*=\s*"[^"]+"\)\s*public\s+class\s+\w+\s*\{[^}]*(?:\{[^}]*\}[^}]*)*\})'
        class_contents = re.findall(class_content_pattern, content, re.DOTALL)
        
        print(f"📦 Encontradas {len(classes)} entidades")
        
        # Cria diretório para as entidades
        entities_dir = "entities"
        if not os.path.exists(entities_dir):
            os.makedirs(entities_dir)
            print(f"📂 Criado diretório: {entities_dir}")
        
        # Salva cada classe em um arquivo separado
        for i, class_name in enumerate(classes):
            if i < len(class_contents):
                class_content = class_contents[i]
                
                # Adiciona package e imports se necessário
                if "package com.example.nfe.entities;" not in class_content:
                    full_content = "package com.example.nfe.entities;\n\n"
                    full_content += "import javax.persistence.*;\n"
                    full_content += "import java.math.BigDecimal;\n"
                    full_content += "import java.time.LocalDateTime;\n"
                    full_content += "import java.util.Objects;\n\n"
                    full_content += class_content
                else:
                    full_content = class_content
                
                # Salva o arquivo
                file_path = os.path.join(entities_dir, f"{class_name}.java")
                with open(file_path, 'w', encoding='utf-8') as f:
                    f.write(full_content)
                
                print(f"  ✅ {class_name}.java")
        
        print(f"🎉 Todas as entidades salvas em: {entities_dir}/")
        
        # Cria o arquivo de configuração do Hibernate
        create_hibernate_config(classes, entities_dir)
        
        return True
        
    except Exception as e:
        print(f"❌ Erro ao processar arquivo: {e}")
        return False

def create_hibernate_config(class_names, entities_dir):
    """Cria arquivos de configuração para Hibernate/Spring Boot"""
    
    # application.properties para Spring Boot
    app_properties = """# Spring Boot Configuration
spring.datasource.url=jdbc:postgresql://localhost:5432/nfe_database
spring.datasource.username=postgres
spring.datasource.password=password

# JPA/Hibernate
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format_sql=true
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect

# Server
server.port=8080
"""
    
    with open("application.properties", 'w', encoding='utf-8') as f:
        f.write(app_properties)
    print("✅ application.properties criado")
    
    # Classe principal do Spring Boot
    spring_boot_app = """package com.example.nfe;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class NFeApplication {
    public static void main(String[] args) {
        SpringApplication.run(NFeApplication.class, args);
    }
}
"""
    
    with open("NFeApplication.java", 'w', encoding='utf-8') as f:
        f.write(spring_boot_app)
    print("✅ NFeApplication.java criado")
    
    # pom.xml para Maven
    pom_xml = """<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    
    <groupId>com.example</groupId>
    <artifactId>nfe-app</artifactId>
    <version>1.0.0</version>
    <packaging>jar</packaging>
    
    <name>NFe Application</name>
    
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.7.0</version>
        <relativePath/>
    </parent>
    
    <properties>
        <java.version>11</java.version>
    </properties>
    
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.postgresql</groupId>
            <artifactId>postgresql</artifactId>
            <scope>runtime</scope>
        </dependency>
    </dependencies>
    
    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
"""
    
    with open("pom.xml", 'w', encoding='utf-8') as f:
        f.write(pom_xml)
    print("✅ pom.xml criado")

def main():
    """Função principal"""
    if len(sys.argv) < 2:
        print("Uso: python split_entities.py <arquivo_entities.java>")
        print("Exemplo: python split_entities.py NFe-teste_entities.java")
        return
    
    java_file = sys.argv[1]
    split_java_entities(java_file)

if __name__ == "__main__":
    main()