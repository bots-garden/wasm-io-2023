#!/bin/bash

# Usage:
# ./new.java.host.sh host_name package_name
# ./new.java.host.sh java-host garden.bots.hello

project_name=$1
package_name=$2
extism_version="0.2.0"

# ./new.java.host.sh java-host garden.bots.hello

package_directories=""
IFS='.'                             # delimiter
read -ra PARTS <<< "$package_name"   # package_name is read into an array as tokens separated by IFS
for directory in "${PARTS[@]}"; do           # access each element of array
    package_directories="${package_directories}/${directory}"
    #echo "${package_directories}"
done

mkdir -p ${project_name}/src/main/java/${package_directories}
cd ${project_name}

# -----------------------------
# Generate the README file
# -----------------------------
read -r -d '' read_me << EOM
#!/bin/bash
# Extism Java Host application: ${project_name}
> This is a work in progress 🚧

EOM
printf "${read_me}" >> README.md

# -----------------------------
# Generate the pom.xml file
# -----------------------------
read -r -d '' pom_xml << EOM
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

    <groupId>${package_name}</groupId>
    <artifactId>${project_name}</artifactId>
    <version>0.0.0-SNAPSHOT</version>

    <properties>
      <maven.compiler.source>19</maven.compiler.source>
      <maven.compiler.target>19</maven.compiler.target>
      <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>

    <dependencies>
    <!-- Extism -->
      <dependency>
        <groupId>org.extism.sdk</groupId>
          <artifactId>extism</artifactId>
          <version>${extism_version}</version>
        </dependency>
    </dependencies>

    <build>
      <plugins>
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-shade-plugin</artifactId>
          <version>3.4.1</version>
          <executions>
            <execution>
              <phase>package</phase>
              <goals>
                <goal>shade</goal>
              </goals>
              <configuration>
                <transformers>
                  <transformer implementation="org.apache.maven.plugins.shade.resource.ManifestResourceTransformer">
                    <mainClass>${package_name}.Main</mainClass>
                  </transformer>
                </transformers>
              </configuration>
            </execution>
          </executions>
        </plugin>
        </plugins>
    </build>
</project>
EOM
printf "${pom_xml}" >> pom.xml

# -----------------------------
# Generate the build.sh file
# -----------------------------
read -r -d '' build_sh << EOM
#!/bin/bash
COL='\033[0;31m'
NC='\033[0m'
echo -e "\${COL}LD_LIBRARY_PATH=/usr/local/lib mvn clean package\${NC}"
LD_LIBRARY_PATH=/usr/local/lib mvn clean package
EOM
printf "${build_sh}" >> build.sh
chmod +x  build.sh


# -----------------------------
# Generate the run.sh file
# -----------------------------
read -r -d '' run_sh << EOM
#!/bin/bash
COL='\033[0;31m'
NC='\033[0m'
echo -e "\${COL}java -jar target/${project_name}-0.0.0-SNAPSHOT.jar\${NC}"
java -jar target/${project_name}-0.0.0-SNAPSHOT.jar
EOM
printf "${run_sh}" >> run.sh
chmod +x  run.sh

# -----------------------------
# Generate the Main.java file
# -----------------------------
cd src/main/java/${package_directories}
read -r -d '' main_java << EOM
package ${package_name};

import org.extism.sdk.Context;
import org.extism.sdk.manifest.Manifest;
import org.extism.sdk.wasm.WasmSourceResolver;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.nio.file.Path;

public class Main {

  public static void runWasmPlugin(String wasmFilePath, String functionName, String param) {
    var wasmSourceResolver = new WasmSourceResolver();
    // load the wasm file
    var manifest = new Manifest(wasmSourceResolver.resolve(Path.of(wasmFilePath)));

      // extism context
      try (var ctx = new Context()) {
        // new plugin
        try (var plugin = ctx.newPlugin(manifest, true)) {
          // ? read config memory
          // call wasm function
          var output = plugin.call(functionName, param);
          System.out.println("From Java Host: " + output);
        }
      }
  }

  public static void main(String[] args) throws IOException, ClassNotFoundException, InvocationTargetException, NoSuchMethodException, InstantiationException, IllegalAccessException {
    //! Add the path to the wasm file & the function name
    runWasmPlugin(
      "path to wasm file", 
      "function name", 
      "👋 Jane Doe 🤗"
    );
  }
}
EOM
printf "${main_java}" >> Main.java
