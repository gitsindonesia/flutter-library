import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'popup_widget/popup_widget.dart';

void safeRun(void Function() callback) {
  final SchedulerBinding instance = SchedulerBinding.instance as dynamic;
  instance.addPostFrameCallback((_) {
    callback();
  });
  instance.ensureVisualUpdate();
}

class GitsPopUpSettings extends StatefulWidget {
  final Widget child;

  const GitsPopUpSettings({Key? key, required this.child}) : super(key: key);

  @override
  GitsPopUpSettingsState createState() => GitsPopUpSettingsState();
}

class _IndexWidget extends StatelessWidget {
  final Widget child;

  final int index;

  const _IndexWidget({Key? key, required this.child, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class GitsPopUpSettingsState extends State<GitsPopUpSettings> {
  final Map<String, Map<UniqueKey, _IndexWidget>> _map =
      <String, Map<UniqueKey, _IndexWidget>>{};

  final Set<UniqueKey> _pending = <UniqueKey>{};

  int _nextAddIndex = 0;

  List<_IndexWidget> get _children =>
      _map.values.fold<List<_IndexWidget>>(<_IndexWidget>[], (value, items) {
        return value..addAll(items.values);
      })
        ..sort((a, b) => a.index.compareTo(b.index));

  void insert(String groupKey, UniqueKey key, Widget widget) {
    safeRun(() {
      _map[groupKey] ??= {};
      final uniqueKey = UniqueKey();

      widget = ProxyInitState(
        initStateCallback: () {
          _pending.remove(key);
        },
        child: widget,
      );

      widget = ProxyDispose(
        child: widget,
        disposeCallback: () {
          _map[groupKey]?.remove(key);
        },
      );
      _map[groupKey]![key] = _IndexWidget(
        key: uniqueKey,
        index: ++_nextAddIndex,
        child: widget,
      );
      _pending.add(key);
      _update();
    });
  }

  void remove(String groupKey, UniqueKey key) {
    safeRun(() {
      if (_pending.contains(key)) {
        return remove(groupKey, key);
      } else {
        _map[groupKey]?.remove(key);
        _update();
      }
    });
  }

  void removeAll(String groupKey) {
    safeRun(() {
      if (_map[groupKey] == null) {
        return;
      }

      _map[groupKey]!.removeWhere((key, _) => !_pending.contains(key));
      _update();

      _map[groupKey]!.forEach((key, value) {
        return remove(groupKey, key);
      });
    });
  }

  void cleanAll() {
    safeRun(() {
      _map.forEach((groupKey, value) {
        value.removeWhere((key, _) => !_pending.contains(key));

        if (value.isNotEmpty) {
          value.forEach((key, value) {
            return remove(groupKey, key);
          });
        }
      });
      _update();
    });
  }

  void _update() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.child,
        ..._children,
      ],
    );
  }
}
