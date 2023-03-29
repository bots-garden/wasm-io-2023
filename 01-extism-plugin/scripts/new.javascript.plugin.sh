#!/bin/bash

# Usage:
# ./new.javascript.plugin.sh plugin_name function_name
# ./new.javascript.plugin.sh hello say_hello

project_name=$1
function_name=$2

mkdir ${project_name}

# ------------------------------
# Generate build script
# ------------------------------
read -r -d '' build_script << EOM
COL='\033[0;31m'
NC='\033[0m'
#!/bin/bash
echo -e "\${COL}extism-js index.js -o ${project_name}.wasm\${NC}"
extism-js index.js -o ${project_name}.wasm
echo -e "\${COL}ls -lh *.wasm\${NC}"
ls -lh *.wasm
EOM

cd ${project_name}

printf "${build_script}" >> build.sh
chmod +x  build.sh

# ------------------------------
# Generate function code
# ------------------------------
read -r -d '' javascript_script << EOM

function ${function_name}() {

	// read function argument from the memory
	let input = Host.inputString()

	let output = "param: " + input

	// copy output to host memory
	Host.outputString(output)

	return 0
}

module.exports = {${function_name}}
EOM

printf "${javascript_script}" >> index.js

# ------------------------------
# Generate calling script
# ------------------------------
read -r -d '' call_plugin << EOM
#!/bin/bash
COL='\033[0;31m'
NC='\033[0m'
echo -e "\${COL}extism call --input \\\"😀 Hello WASM.IO 2023! (from JavaScript)\\\" ./${project_name}.wasm ${function_name} --wasi\${NC}"
extism call --input "😀 Hello WASM.IO 2023! (from JavaScript)" ./${project_name}.wasm ${function_name} --wasi
echo ""
EOM

printf "${call_plugin}" >> call.plugin.sh
chmod +x  call.plugin.sh
