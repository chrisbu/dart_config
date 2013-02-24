library test_browser;

import 'package:unittest/unittest.dart';
import 'package:unittest/html_config.dart';

import '../lib/loaders/config_loader_httprequest.dart';
import '../lib/parsers/config_parser_json.dart';
import '../lib/parsers/config_parser_yaml.dart';
import '../lib/config.dart';

import 'tests.dart' as tests;

main() {
  useHtmlConfiguration();
 
  tests.pathMap[tests.SIMPLE_CONFIG_JSON] = "configs/testsimpleconfig.json";
  tests.pathMap[tests.SIMPLE_CONFIG_YAML] = "configs/testsimpleconfig.yaml";
  tests.loaderImpl = new ConfigHttpRequestLoader();
  tests.runTests();
}
  