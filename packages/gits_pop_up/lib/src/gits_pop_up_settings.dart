import 'package:flutter/material.dart';

import 'gits_pop_up_cons.dart';

class GitsPopUpSettings {
  // Color Constants
  final Color? whiteColor;
  final Color? blackColor;
  final Color? successColor;
  final Color? infoColor;
  final Color? dangerColor;
  final Color? warningColor;
  final Color? successBackgroundColor;
  final Color? infoBackgroundColor;
  final Color? dangerBackgroundColor;
  final Color? warningBackgroundColor;
  // Font Size
  final double? titleFontSize;
  final double? subtitleFontSize;

  GitsPopUpSettings(
      {this.blackColor,
      this.whiteColor,
      this.successColor = const Color(0xFF15A049),
      this.infoColor,
      this.dangerColor,
      this.warningColor,
      this.successBackgroundColor,
      this.infoBackgroundColor,
      this.dangerBackgroundColor,
      this.warningBackgroundColor,
      this.titleFontSize,
      this.subtitleFontSize}) {
    // Set color
    if (blackColor != null) {
      blackColorCons = blackColor!;
    }
    if (whiteColor != null) {
      whiteColorCons = whiteColor!;
    }
    if (successColor != null) {
      successColorCons = successColor!;
    }
    if (infoColor != null) {
      infoColorCons = infoColor!;
    }
    if (dangerColor != null) {
      dangerColorCons = dangerColor!;
    }
    if (warningColor != null) {
      warningColorCons = warningColor!;
    }
    if (successBackgroundColor != null) {
      successBackgroundColorCons = successBackgroundColor!;
    }
    if (infoBackgroundColor != null) {
      infoBackgroundColorCons = infoBackgroundColor!;
    }
    if (dangerBackgroundColor != null) {
      dangerBackgroundColorCons = dangerBackgroundColor!;
    }
    if (warningBackgroundColor != null) {
      warningBackgroundColorCons = warningBackgroundColor!;
    }

    // Set font size
    if (titleFontSize != null) {
      titleFontSizeCons = titleFontSize!;
    }
    if (subtitleFontSize != null) {
      subtitleFontSizeCons = subtitleFontSize!;
    }
  }
}
