#!/bin/bash

# Usage:
# ./new.go.plugin.sh plugin_name function_name
# ./new.go.plugin.sh hello say_hello

project_name=$1
function_name=$2

mkdir ${project_name}

# ------------------------------
# Generate build script
# ------------------------------
read -r -d '' build_script << EOM
#!/bin/bash
COL='\033[0;31m'
NC='\033[0m'
echo -e "\${COL}tinygo build -scheduler=none --no-debug -o ${project_name}.wasm -target wasi main.go\${NC}"
tinygo build -scheduler=none --no-debug -o ${project_name}.wasm -target wasi main.go
echo -e "\${COL}ls -lh *.wasm\${NC}"
ls -lh *.wasm
EOM

cd ${project_name}

printf "${build_script}" >> build.sh
chmod +x  build.sh

go mod init ${project_name}

# ------------------------------
# Generate function code
# ------------------------------
read -r -d '' golang_script << EOM
package main
// CLI demo

import (
	"github.com/extism/go-pdk"
	"github.com/valyala/fastjson"
)

//export ${function_name}
func ${function_name}() int32 {
	
	// read function argument from the memory
	input := pdk.Input()

	// use config + req. + resp

	output := "param: " + string(input)

	mem := pdk.AllocateString(output)
	// copy output to host memory
	pdk.OutputMemory(mem)

	return 0
}

func main() {}
EOM

printf "${golang_script}" >> main.go

go mod tidy

# ------------------------------
# Generate calling script
# ------------------------------
read -r -d '' call_plugin << EOM
#!/bin/bash
COL='\033[0;31m'
NC='\033[0m'
echo -e "\${COL}extism call --input \\\"😀 Hello WASM.IO 2023! (from TinyGo)\\\" ./${project_name}.wasm ${function_name} --wasi"
echo -e "--config route=https://jsonplaceholder.typicode.com/todos/3\${NC}"
echo ""
extism call --input "😀 Hello WASM.IO 2023! (from TinyGo)" ./${project_name}.wasm ${function_name} --wasi \\
  --config route=https://jsonplaceholder.typicode.com/todos/3
echo ""
echo ""
EOM

printf "${call_plugin}" >> call.plugin.with.cli.sh
chmod +x  call.plugin.sh
