# WASI & Go

```bash
tinygo build -scheduler=none --no-debug -o hello.wasm -target wasi ./main.go

wasmer hello.wasm John
wasmedge hello.wasm John
wasmtime hello.wasm John
```
