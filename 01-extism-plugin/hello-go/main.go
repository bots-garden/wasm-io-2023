package main
// CLI demo

import (
	"github.com/extism/go-pdk"
	"github.com/valyala/fastjson"
)

//export say_hello
func say_hello() int32 {
	
	// read function argument from the memory
	input := pdk.Input()

	// use config + req. + resp
	route, _:= pdk.GetConfig("route")
	req := pdk.NewHTTPRequest("GET", route)
	res := req.Send()
	// https://jsonplaceholder.typicode.com/todos/3
	parser := fastjson.Parser{}
	jsonValue, _ := parser.Parse(string(res.Body()))
	title := string(jsonValue.GetStringBytes("title"))

	output := "param: " + string(input) + " title: " +title

	mem := pdk.AllocateString(output)
	// copy output to host memory
	pdk.OutputMemory(mem)

	return 0
}

func main() {}