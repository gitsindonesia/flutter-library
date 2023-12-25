import 'package:flutter/material.dart';
import 'package:gits_inspector/gits_inspector.dart';
import 'package:gits_inspector/src/extensions/inspector_extensions.dart';
import 'package:gits_inspector/src/widgets/overview_section.dart';
import 'package:gits_inspector/src/widgets/request_section.dart';
import 'package:gits_inspector/src/widgets/response_section.dart';
import 'package:gits_inspector/src/widgets/theme_inspector.dart';
import 'package:share_plus/share_plus.dart';

/// The page will display detail gits inspector.
class GitsInspectorDetailPage extends StatelessWidget {
  /// Constructor of [GitsInspectorDetailPage] with required [inspector].
  const GitsInspectorDetailPage({
    super.key,
    required this.inspector,
  });

  final Inspector inspector;

  /// Function to navigate [GitsInspectorDetailPage] with given [context] and [inspector].
  static void navigate(BuildContext context, Inspector inspector) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) =>
            GitsInspectorDetailPage(inspector: inspector),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ThemeInspector(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(inspector.pathWithQuery, maxLines: 2),
            actions: [
              IconButton(
                onPressed: () async {
                  final box = context.findRenderObject() as RenderBox?;
                  final rect = box != null
                      ? box.localToGlobal(Offset.zero) & box.size
                      : null;
                  await Share.share(
                    inspector.toMessageShare(),
                    sharePositionOrigin: rect,
                  );
                },
                icon: const Icon(Icons.share),
              ),
            ],
            bottom: const TabBar(
              tabs: [
                Tab(text: 'OVERVIEW'),
                Tab(text: 'REQUEST'),
                Tab(text: 'RESPONSE'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              OverviewSection(inspector: inspector),
              RequestSection(inspector: inspector),
              ResponseSection(inspector: inspector),
            ],
          ),
        ),
      ),
    );
  }
}
