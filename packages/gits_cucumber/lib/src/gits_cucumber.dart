import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gits_cucumber/src/report/reporter.dart';
import 'package:gits_cucumber/src/support/support.dart';
import 'package:patrol/patrol.dart';

import 'models/models.dart';

class GitsCucumber {
  GitsCucumber({
    this.config,
    this.hook = const Hook(),
    this.reporter = const [],
    required this.stepDefinitions,
  });

  final Config? config;
  final Hook hook;
  final List<Reporter> reporter;
  final Map<RegExp, Function> stepDefinitions;

  List<Gherkin> gherkins = [];

  List<Gherkin> _getGherkinFromNdjson() {
    const ndjsonGherkin = String.fromEnvironment('NDJSON_GHERKIN');

    if (ndjsonGherkin.isEmpty) {
      print(
          'ndjson gherkin is empty, make sure to set --dart-define="NDJSON_GHERKIN=<gzip_gherkin>"');
      exit(1);
    }

    List<Gherkin> gherkins = [];

    final gzipNdjson =
        ndjsonGherkin.split(',').map((e) => int.parse(e)).toList();
    final decoded = gzip.decode(gzipNdjson);
    final ndjson = utf8.decode(decoded);

    final List jsonGherkin = jsonDecode(ndjson);

    for (final element in jsonGherkin) {
      Source? source;
      GherkinDocument? gherkinDocument;
      List<Pickle> pickles = [];

      final jsons = element['ndjson'].split('\n');
      for (int i = 0; i < jsons.length; i++) {
        final json = jsons[i];
        switch (i) {
          case 0:
            source = Source.fromJson(json);
            break;
          case 1:
            gherkinDocument = GherkinDocument.fromJson(json);
            break;
          default:
            pickles.add(Pickle.fromJson(json));
        }
      }

      gherkins.add(Gherkin(
        source: source,
        gherkinDocument: gherkinDocument,
        pickles: pickles,
      ));
    }

    return gherkins;
  }

  Future<void> execute() async {
    gherkins = _getGherkinFromNdjson();
    await reporter.onGherkinLoaded(gherkins);

    await hook.onBeforeExecute();
    for (final feature in gherkins) {
      await _handleFeature(feature);
    }
  }

  Future<void> _handleFeature(Gherkin feature) async {
    group(feature.gherkinDocument?.gherkinDocument?.feature?.name ?? '', () {
      for (final scenario in feature.pickles) {
        patrolTest(
          scenario.pickle?.name ?? '',
          ($) async {
            if (feature.pickles.first == scenario) {
              await reporter.onBeforeFeature(feature);
              await hook.onBeforeFeature($);
            }

            await _handleScenario(feature, scenario, $);

            if (feature.pickles.last == scenario) {
              await hook.onAfterFeature($);
              await reporter.onAfterFeature(feature);
            }

            if (gherkins.last == feature && feature.pickles.last == scenario) {
              await hook.onAfterExecute();
              await reporter.onDoneTest();
            }
          },
          timeout: Timeout(config?.timeout),
          nativeAutomation: config?.nativeAutomation ?? false,
          nativeAutomatorConfig:
              config?.nativeAutomatorConfig ?? NativeAutomatorConfig(),
          config: config?.patrolTesterConfig ?? PatrolTesterConfig(),
          skip: config?.skipScenario,
        );
      }
    });
  }

  Future<void> _handleScenario(
      Gherkin feature, Pickle scenario, PatrolTester $) async {
    bool skipAnotherStep = false;
    await reporter.onBeforeScenario(feature, scenario);
    await hook.onBeforeScenario($);
    for (final step in scenario.pickle?.steps ?? <StepsPickle>[]) {
      if (skipAnotherStep) {
        await reporter.onBeforeStep(feature, scenario, step);
        await reporter.onSkipStep(feature, scenario, step);
        continue;
      }
      try {
        for (final regExp in stepDefinitions.keys) {
          if (regExp.hasMatch(step.text ?? '')) {
            await _handleStep($, regExp, feature, scenario, step);
            break;
          }
        }
      } catch (e) {
        await reporter.onFailedStep(feature, scenario, step);
        skipAnotherStep = true;
      }
    }
    await hook.onAfterScenario($);
    await reporter.onAfterScenario(feature, scenario);
  }

  Future<void> _handleStep(PatrolTester $, RegExp regExp, Gherkin feature,
      Pickle scenario, StepsPickle step) async {
    await reporter.onBeforeStep(feature, scenario, step);
    await hook.onBeforeStep($);

    final match = regExp.firstMatch(step.text ?? '');
    final count = match?.groupCount;
    switch (count ?? 0) {
      case 0:
        await stepDefinitions[regExp]?.call($);
        break;
      case 1:
        await stepDefinitions[regExp]?.call($, match?.group(1));
        break;
      case 2:
        await stepDefinitions[regExp]
            ?.call($, match?.group(1), match?.group(2));
        break;
      case 3:
        await stepDefinitions[regExp]
            ?.call($, match?.group(1), match?.group(2), match?.group(3));
        break;
      case 4:
        await stepDefinitions[regExp]?.call($, match?.group(1), match?.group(2),
            match?.group(3), match?.group(4));
        break;
      case 5:
        await stepDefinitions[regExp]?.call($, match?.group(1), match?.group(2),
            match?.group(3), match?.group(4), match?.group(5));
        break;
      case 6:
        await stepDefinitions[regExp]?.call($, match?.group(1), match?.group(2),
            match?.group(3), match?.group(4), match?.group(5), match?.group(6));
        break;
      case 7:
        await stepDefinitions[regExp]?.call(
            $,
            match?.group(1),
            match?.group(2),
            match?.group(3),
            match?.group(4),
            match?.group(5),
            match?.group(6),
            match?.group(7));
        break;
      case 8:
        await stepDefinitions[regExp]?.call(
            $,
            match?.group(1),
            match?.group(2),
            match?.group(3),
            match?.group(4),
            match?.group(5),
            match?.group(6),
            match?.group(7),
            match?.group(8));
        break;
      case 9:
        await stepDefinitions[regExp]?.call(
            $,
            match?.group(1),
            match?.group(2),
            match?.group(3),
            match?.group(4),
            match?.group(5),
            match?.group(6),
            match?.group(7),
            match?.group(8),
            match?.group(9));
        break;
      default:
    }

    await hook.onAfterStep($);
    await reporter.onPassedStep(feature, scenario, step);
  }
}
