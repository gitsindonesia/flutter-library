import 'package:patrol/patrol.dart';

class Hook {
  const Hook();

  Future<void> onBeforeExecute() async {}
  Future<void> onAfterExecute() async {}
  Future<void> onBeforeFeature(PatrolIntegrationTester $) async {}
  Future<void> onAfterFeature(PatrolIntegrationTester $) async {}
  Future<void> onBeforeScenario(PatrolIntegrationTester $) async {}
  Future<void> onAfterScenario(PatrolIntegrationTester $) async {}
  Future<void> onBeforeStep(PatrolIntegrationTester $) async {}
  Future<void> onAfterStep(PatrolIntegrationTester $) async {}
}
