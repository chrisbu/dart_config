library config_loader_filesystem;

import 'dart:html';
import 'dart:async';
import '../config.dart';

class ConfigHttpRequestLoader extends ConfigLoader {
  
  /**
   * A config loader will load 
   */
  Future<String> loadConfig(String path) {
    var completer = new Completer<String>();
    
    var errorHandler = (error) => completer.completeError(error);
    
    HttpRequest.getString(path).then(
        (responseText) => completer.complete(responseText),
        onError: errorHandler);
    
    return completer.future;
  }

  String loadConfigSync(String path) {
    String result = "";

    HttpRequest request = new HttpRequest();
    request.open('GET', path, async : false);
    request.send();
    result = request.responseText;

    if (request.statusText != "OK") {
      print("Synchronous config load of $path was not possible");
    }

    return result;
  }

}