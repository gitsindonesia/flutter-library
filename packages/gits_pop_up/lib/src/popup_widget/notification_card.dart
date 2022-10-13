import 'package:flutter/material.dart';



import '../gits_pop_up_cons.dart';
import '../index_painters.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    Key? key,
    required this.title,
    this.subtitle,
    this.leadingWidget,
    this.actionWidget,
    this.onTap,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.onLongPress,
    this.margin,
    this.contentPadding,
    required this.cancelFunction,
    this.elevation,
    this.showAction = true,
  }) : super(key: key);

  final String title;
  final String? subtitle;
  final Widget? leadingWidget;
  final Widget? actionWidget;
  final GestureTapCallback? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;
  final GestureLongPressCallback? onLongPress;
  final double? margin;
  final double? contentPadding;
  final Function cancelFunction;
  final double? elevation;
  final bool showAction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Card(
        color: backgroundColor ?? whiteColorCons,
        elevation: elevation ?? 0,
        margin: EdgeInsets.all(margin ?? 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    contentPadding ?? 14,
                    contentPadding ?? 14,
                    showAction == false ? contentPadding ?? 14 : 0,
                    contentPadding ?? 14),
                child: Row(
                  children: [
                    if (leadingWidget != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 14),
                        child: leadingWidget,
                      ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              color: textColor ?? blackColorCons,
                              fontSize: titleFontSizeCons,
                              fontWeight: FontWeight.bold),
                        ),
                        if (subtitle != null)
                          const SizedBox(
                            height: 4,
                          ),
                        if (subtitle != null)
                          Text(
                            subtitle!,
                            style: TextStyle(
                              color: textColor ?? blackColorCons,
                              fontSize: subtitleFontSizeCons,
                            ),
                          ),
                      ],
                    )),
                  ],
                ),
              ),
            ),
            if (showAction)
              actionWidget ??
                  InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: () => cancelFunction.call(),
                    child: Padding(
                      padding: EdgeInsets.all(contentPadding ?? 14),
                      child: CustomPaint(
                          painter: IconClosePainter(
                              iconColor: textColor ?? blackColorCons),
                          size: const Size(18, 18)),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
