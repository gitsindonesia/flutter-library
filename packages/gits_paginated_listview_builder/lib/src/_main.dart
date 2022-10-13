import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gits_paginated_listview_builder/src/cubit/_paginated_controller.dart';

// ignore: must_be_immutable
class GitsPaginatedListViewBuilder<T> extends StatelessWidget {
  GitsPaginatedListViewBuilder(
      {super.key,
      required this.controller,
      required this.itemBuilder,
      this.initPageNumber,
      this.isLoading,
      this.endListLoadingWidget,
      this.initLoadingWidget,
      this.onHitThreshold,
      this.threshold,
      this.scrollDirection = Axis.vertical,
      this.reverse = false,
      this.primary,
      this.physics,
      this.scrollBehavior,
      this.shrinkWrap = false,
      this.anchor = 0.0,
      this.cacheExtent,
      this.semanticChildCount,
      this.dragStartBehavior = DragStartBehavior.start,
      this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
      this.restorationId,
      this.clipBehavior = Clip.hardEdge,
      this.addAutomaticKeepAlives = true,
      this.addRepaintBoundaries = true,
      this.addSemanticIndexes = true,
      this.findChildIndexCallback,
      this.onScrolling});

  /// [controller] is controller so you can addNewdata reset data and any other operation
  final PaginatedController<T>? controller;

  /// [initPageNumber] is default page count by default it set to 1
  final int? initPageNumber;

  /// [itemBuilder] is function that return widget that will be call as much as the length of pagination data
  final Widget Function(BuildContext context, int index, T currentData)
      itemBuilder;

  /// [onHitThreshold] will be call when ever the scrolling position hit the [threshold]
  ///  make sure you check if it isLoading or call your function to get or fetch new data
  final void Function(BuildContext context, int current)? onHitThreshold;

  /// [onScrolling] will be call whenever the user scroll the list
  final void Function(
          BuildContext context, int current, ScrollController controller)?
      onScrolling;

  /// determine is now loading the data or not
  /// if true the loading widget will show
  /// if pagination list is empty the [initLoadingWidget] will show otherwise [endListLoadingWidget]
  final bool? isLoading;

  /// loading widget that will show when the pagination list is not empty
  /// the loading will show in the end of pagination list
  final Widget? endListLoadingWidget;

  /// loading widget that will show when the pagination list is empty
  final Widget? initLoadingWidget;

  /// [threshold] is percentage of size of the pagintation list
  /// you can specify it from [0% - 100%] by default it set to 80%
  int? threshold;
  final Axis scrollDirection;
  final bool reverse;
  final bool? primary;
  final ScrollPhysics? physics;
  final ScrollBehavior? scrollBehavior;
  final bool shrinkWrap;
  final double anchor;
  final double? cacheExtent;
  final int? semanticChildCount;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final Clip clipBehavior;
  ChildIndexGetter? findChildIndexCallback;
  int? itemCount;
  bool addAutomaticKeepAlives;
  bool addRepaintBoundaries;
  bool addSemanticIndexes;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value:
          controller ?? PaginatedController<T>(initPageNumber: initPageNumber),
      child: _Main(
        semanticChildCount: semanticChildCount,
        scrollDirection: scrollDirection,
        reverse: reverse,
        restorationId: restorationId,
        shrinkWrap: shrinkWrap,
        primary: primary,
        physics: physics,
        keyboardDismissBehavior: keyboardDismissBehavior,
        findChildIndexCallback: findChildIndexCallback,
        dragStartBehavior: dragStartBehavior,
        clipBehavior: clipBehavior,
        cacheExtent: cacheExtent,
        addSemanticIndexes: addSemanticIndexes,
        addRepaintBoundaries: addRepaintBoundaries,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        itemBuilder: itemBuilder,
        isLoading: isLoading,
        initLoadingWidget: initLoadingWidget,
        endListLoadingWidget: endListLoadingWidget,
        onHitThreshold: onHitThreshold,
        threshold: threshold,
        onScrolling: onScrolling,
      ),
    );
  }
}

// ignore: must_be_immutable
class _Main<T> extends StatefulWidget {
  _Main(
      {Key? key,
      required this.itemBuilder,
      this.threshold,
      this.onHitThreshold,
      this.isLoading,
      this.endListLoadingWidget,
      this.initLoadingWidget,
      this.scrollDirection = Axis.vertical,
      this.reverse = false,
      this.primary,
      this.physics,
      this.scrollBehavior,
      this.shrinkWrap = false,
      this.anchor = 0.0,
      this.cacheExtent,
      this.semanticChildCount,
      this.dragStartBehavior = DragStartBehavior.start,
      this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
      this.restorationId,
      this.clipBehavior = Clip.hardEdge,
      this.addAutomaticKeepAlives = true,
      this.addRepaintBoundaries = true,
      this.addSemanticIndexes = true,
      this.findChildIndexCallback,
      this.onScrolling})
      : super(key: key);
  final Widget Function(BuildContext context, int index, T currentData)
      itemBuilder;
  final void Function(BuildContext context, int current)? onHitThreshold;
  final void Function(
          BuildContext context, int current, ScrollController controller)?
      onScrolling;
  final bool? isLoading;
  final Widget? endListLoadingWidget;
  final Widget? initLoadingWidget;
  int? threshold;
  final Axis scrollDirection;
  final bool reverse;
  final bool? primary;
  final ScrollPhysics? physics;
  final ScrollBehavior? scrollBehavior;
  final bool shrinkWrap;
  final double anchor;
  final double? cacheExtent;
  final int? semanticChildCount;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final Clip clipBehavior;
  ChildIndexGetter? findChildIndexCallback;
  int? itemCount;
  bool addAutomaticKeepAlives;
  bool addRepaintBoundaries;
  bool addSemanticIndexes;
  @override
  State<_Main<T>> createState() => _MainState<T>();
}

class _MainState<T> extends State<_Main<T>> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<PaginatedController<T>>();
    // ignore: invalid_use_of_protected_member
    if (!cubit.scrollController.hasListeners) {
      log("___________initializing pagintation listener___________");
      cubit.scrollController.addListener(() async {
        if (widget.onScrolling != null) {
          widget.onScrolling!(context, cubit.current, cubit.scrollController);
        }
        final threshold =
            (cubit.scrollController.position.maxScrollExtent / 100) *
                (widget.threshold ?? 80);
        if (cubit.scrollController.position.pixels >= threshold &&
            widget.isLoading == false &&
            widget.onHitThreshold != null) {
          if (widget.reverse) {
            if (widget.scrollDirection == Axis.horizontal) {
              if (cubit.scrollController.position.axisDirection !=
                  AxisDirection.left) {
                return;
              }
            } else {
              if (cubit.scrollController.position.axisDirection !=
                  AxisDirection.up) {
                return;
              }
            }
          } else {
            if (widget.scrollDirection == Axis.horizontal) {
              if (cubit.scrollController.position.axisDirection !=
                  AxisDirection.right) {
                return;
              }
            } else {
              if (cubit.scrollController.position.axisDirection !=
                  AxisDirection.down) {
                return;
              }
            }
          }
          if (cubit.scrollController.position.axisDirection ==
              AxisDirection.down) {}
          widget.onHitThreshold!(context, cubit.current);
        }
      });
    }
    return widget.isLoading == true && cubit.paginateData.isEmpty
        ? widget.initLoadingWidget ??
            const Center(
              child: CircularProgressIndicator(),
            )
        : ListView.builder(
            semanticChildCount: widget.semanticChildCount,
            scrollDirection: widget.scrollDirection,
            reverse: widget.reverse,
            restorationId: widget.restorationId,
            shrinkWrap: widget.shrinkWrap,
            primary: widget.primary,
            physics: widget.physics,
            keyboardDismissBehavior: widget.keyboardDismissBehavior,
            findChildIndexCallback: widget.findChildIndexCallback,
            dragStartBehavior: widget.dragStartBehavior,
            clipBehavior: widget.clipBehavior,
            cacheExtent: widget.cacheExtent,
            addSemanticIndexes: widget.addSemanticIndexes,
            addRepaintBoundaries: widget.addRepaintBoundaries,
            addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
            controller: cubit.scrollController,
            itemCount: cubit.paginateData.isEmpty
                ? cubit.paginateData.length
                : cubit.paginateData.length + 1,
            itemBuilder: (context, index) {
              if (cubit.paginateData.isNotEmpty &&
                  index == cubit.paginateData.length) {
                if (widget.isLoading == true) {
                  return widget.endListLoadingWidget ??
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                }
                return const SizedBox();
              }
              return widget.itemBuilder(
                  context, index, cubit.paginateData[index]);
            },
          );
  }
}
