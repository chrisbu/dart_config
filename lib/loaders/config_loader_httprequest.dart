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


}