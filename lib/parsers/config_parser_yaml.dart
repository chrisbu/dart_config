library config_parser_yaml;

import 'dart:async';
import 'package:yaml/yaml.dart' as YAML;

import '../config.dart';

class YamlConfigParser implements ConfigParser {
  
  Future<Map> parse(String configText) {
    var completer = new Completer<Map>();
    
    var map = YAML.loadYaml(configText);
    completer.complete(map);
    
    return completer.future;
  }
}