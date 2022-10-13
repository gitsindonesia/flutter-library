import 'package:flutter/material.dart';

export 'animation.dart';
export 'notification.dart';
export 'loading.dart';
export 'text_toast.dart';

class ProxyInitState extends StatefulWidget {
  const ProxyInitState({
    Key? key,
    required this.child,
    required this.initStateCallback,
  }) : super(key: key);
  final Widget child;
  final VoidCallback initStateCallback;
  @override
  State<ProxyInitState> createState() => _ProxyInitStateState();
}

class _ProxyInitStateState extends State<ProxyInitState> {
  @override
  void initState() {
    widget.initStateCallback();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class ProxyDispose extends StatefulWidget {
  const ProxyDispose({
    Key? key,
    required this.child,
    required this.disposeCallback,
  }) : super(key: key);
  final Widget child;
  final VoidCallback disposeCallback;
  @override
  State<ProxyDispose> createState() => _ProxyDisposeState();
}

class _ProxyDisposeState extends State<ProxyDispose> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    widget.disposeCallback();
    super.dispose();
  }
}
