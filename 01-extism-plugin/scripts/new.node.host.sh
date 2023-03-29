#!/bin/bash

# Usage:
# ./new.node.host.sh host_name
# ./new.node.host.sh js-host

project_name=$1

mkdir ${project_name}
cd ${project_name}

# -----------------------------
# Generate the run.sh file
# -----------------------------
read -r -d '' run_sh << EOM
#!/bin/bash
COL='\033[0;31m'
NC='\033[0m'
echo -e "\${COL}node index.js\${NC}"
node index.js
EOM
printf "${run_sh}" >> run.sh
chmod +x  run.sh

# -----------------------------
# Generate the index.js file
# -----------------------------
read -r -d '' index_js << EOM
import { Context, HostFunction, ValType } from '@extism/extism'
import { readFileSync } from 'fs'

let wasm = readFileSync("path to the wasm file")

// Create the WASM plugin
let ctx = new Context()
let plugin = ctx.plugin(wasm, true, [])

// Call the WASM function,
let buf = await plugin.call("function name", "param"); 
let result = buf.toString()

console.log("From Node.js Host: ", result)
EOM

printf "${index_js}" >> index.js

# -----------------------------
# Generate package.json
# -----------------------------
read -r -d '' package_json << EOM
{
  "dependencies": {
    "@extism/extism": "^0.2.0"
  },
  "type": "module"
}
EOM
printf "${package_json}" >> package.json
#npm install
npm install --prefer-offline

#npm cache add @extism/extism@0.2.0
#npm cache verify
