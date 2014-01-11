library config_parser_json;

import 'dart:async';
import 'dart:convert';

import '../config.dart';

class JsonConfigParser extends ConfigParser {

  Map parseSync(String configText) {
    return JSON.decode(configText);
  }

}