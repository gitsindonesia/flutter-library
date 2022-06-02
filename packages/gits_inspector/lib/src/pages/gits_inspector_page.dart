import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gits_base/gits_base.dart';
import 'package:gits_inspector/src/cubit/gits_inspector_cubit.dart';
import 'package:gits_inspector/src/widgets/item_inspector.dart';
import 'package:gits_inspector/src/widgets/theme_inspector.dart';

class GitsInspectorPage extends StatefulWidget {
  const GitsInspectorPage({Key? key}) : super(key: key);

  @override
  State<GitsInspectorPage> createState() => _GitsInspectorPageState();
}

class _GitsInspectorPageState extends State<GitsInspectorPage>
    with GitsStatePage<GitsInspectorPage, GitsInspectorCubit> {
  @override
  GitsInspectorCubit setCubit() => GitsInspectorCubit();

  @override
  Widget buildWidget(BuildContext context) {
    final list = context
        .select((GitsInspectorCubit element) => element.state.inspectors);
    final isSearchMode = context
        .select((GitsInspectorCubit element) => element.state.isSearchMode);

    return ThemeInspector(
      child: Scaffold(
        appBar: AppBar(
          title: isSearchMode
              ? TextField(onChanged: cubit.onSearchChanged, autofocus: true)
              : const Text('Gits Inspector'),
          actions: [
            IconButton(
              onPressed: cubit.onChangeToSearch,
              icon: Icon(isSearchMode ? Icons.close : Icons.search),
            ),
            IconButton(
              onPressed: cubit.deleteAll,
              icon: const Icon(Icons.delete),
            )
          ],
        ),
        body: ListView.separated(
          itemBuilder: (context, index) => ItemInspector(item: list[index]),
          separatorBuilder: (_, __) =>
              Container(height: 1, color: Colors.grey[800]),
          itemCount: list.length,
        ),
      ),
    );
  }
}
