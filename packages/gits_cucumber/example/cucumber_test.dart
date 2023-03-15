import 'package:gits_cucumber/gits_cucumber.dart';

import 'support/cucumber_config.dart';
import 'support/cucumber_hook.dart';
import 'support/step_definitions.dart';

void main() async {
  await GitsCucumber(
    config: CucumberConfig(),
    hook: CucumberHook(),
    reporter: [JsonReporter(), StdoutReporter()],
    stepDefinitions: stepDefinitions,
  ).execute();
}
