package garden.bots.hello;

import org.extism.sdk.Context;
import org.extism.sdk.manifest.Manifest;
import org.extism.sdk.wasm.WasmSourceResolver;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.nio.file.Path;

public class Main {

  public static void runWasmPlugin(String wasmFilePath, String functionName, String param) {
    var wasmSourceResolver = new WasmSourceResolver();
    //! load the wasm file
    var manifest = new Manifest(wasmSourceResolver.resolve(Path.of(wasmFilePath)));

      //! extism context
      try (var ctx = new Context()) {
        //! new plugin
        try (var plugin = ctx.newPlugin(manifest, true)) {
          // ? read config memory
          plugin.updateConfig("{\"route\":\"https://jsonplaceholder.typicode.com/todos/3\"}");
          //! call wasm function
          var output = plugin.call(functionName, param);
          System.out.println("From Java Host: " + output);
        }
      }
  }

  public static void main(String[] args) throws IOException, ClassNotFoundException, InvocationTargetException, NoSuchMethodException, InstantiationException, IllegalAccessException {
    //! Add the path to the wasm file & the function name
    runWasmPlugin(
      "../hello-go/hello-go.wasm", 
      "say_hello", 
      "👋 WASM IO 2023 🤗"
    );
  }
}
