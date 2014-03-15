library config_parser_json;

import 'dart:async';
import 'dart:convert';

import '../config.dart';

class JsonConfigParser implements ConfigParser {
  
  Future<Map> parse(String configText) {
    var completer = new Completer<Map>();
    
    var map = JSON.decode(configText);
    completer.complete(map);
    
    return completer.future;
  }
}