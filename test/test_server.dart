library config_filesystem_test;

import '../lib/loaders/config_loader_filesystem.dart';

import 'package:unittest/unittest.dart';
import 'tests.dart' as tests;

main() {
  tests.pathMap[tests.SIMPLE_CONFIG_JSON] = "test/configs/testsimpleconfig.json";
  tests.pathMap[tests.NESTED_CONFIG_JSON] = "test/configs/testnestedconfig.json";
  tests.pathMap[tests.SIMPLE_CONFIG_YAML] = "test/configs/testsimpleconfig.yaml";
  tests.pathMap[tests.NESTED_CONFIG_YAML] = "test/configs/testnestedconfig.yaml";
  tests.loaderImpl = new ConfigFilesystemLoader();
  tests.runTests();
}

