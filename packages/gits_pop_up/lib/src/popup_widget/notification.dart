import 'package:flutter/material.dart';

class NotificationPopup extends StatefulWidget {
  const NotificationPopup({
    Key? key,
    required this.child,
    this.slideOffFunc,
    this.dismissDirections,
  }) : super(key: key);

  final Widget child;

  final Function? slideOffFunc;

  final List<DismissDirection>? dismissDirections;

  @override
  State<NotificationPopup> createState() => _NotificationPopupState();
}

class _NotificationPopupState extends State<NotificationPopup> {
  Future<bool> confirmDismiss(DismissDirection direction) async {
    widget.slideOffFunc?.call();
    return true;
  }

  Key key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    Widget child = widget.child;

    if (widget.slideOffFunc != null &&
        widget.dismissDirections != null &&
        widget.dismissDirections!.isNotEmpty) {
      for (var direction in widget.dismissDirections!) {
        child = Dismissible(
          direction: direction,
          key: key,
          confirmDismiss: confirmDismiss,
          child: child,
        );
      }
    }

    return child;
  }
}
