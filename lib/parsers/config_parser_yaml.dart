library config_parser_yaml;

import 'dart:async';
import 'package:yaml/yaml.dart' as YAML;

import '../config.dart';

class YamlConfigParser extends ConfigParser {

  Map parseSync(String configText) {
    return YAML.loadYaml(configText);
  }

}