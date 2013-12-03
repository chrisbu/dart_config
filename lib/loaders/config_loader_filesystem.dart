library config_loader_httprequest;

import 'dart:io';
import 'dart:async';
import '../config.dart';


class ConfigFilesystemLoader extends ConfigLoader {
  
  /**
   * A config loader will load 
   */
  Future<String> loadConfig(String path) {
    var completer = new Completer<String>();
    
    var errorHandler = (error) => completer.completeError(error);
    
    var file = new File(path);
    file.exists().then(
        (exists) {
          if (exists) {
            file.open(mode: FileMode.READ).then(
                (RandomAccessFile f) {
                  f.length().then(
                      (length) {
                        f.read(length).then((List<int> buffer) {
                          var configText = new String.fromCharCodes(buffer);
                          f.close().then(
                              (f) {
                                completer.complete(configText);
                              }, 
                              onError: errorHandler);
                        },
                        onError: errorHandler);
                      }, 
                      onError: errorHandler);
                }, 
                onError: errorHandler);
          }
          else {
            completer.completeError("${path} does not exist");
          }
        },
        onError: errorHandler);
    
    
    return completer.future;
  }
  
  
}