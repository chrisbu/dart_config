library config_filesystem_test;

import '../lib/loaders/config_loader_filesystem.dart';

import 'package:unittest/unittest.dart';
import 'tests.dart' as tests;

main() {
  tests.pathMap[tests.SIMPLE_CONFIG_JSON] = "test/configs/testsimpleconfig.json";
  tests.pathMap[tests.SIMPLE_CONFIG_YAML] = "test/configs/testsimpleconfig.yaml";
  tests.loaderImpl = new ConfigFilesystemLoader();
  tests.runTests();
}

