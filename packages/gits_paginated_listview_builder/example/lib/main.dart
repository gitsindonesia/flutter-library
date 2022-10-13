import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:gits_paginated_listview_builder/gits_paginated_listview_builder.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final paginatedController = PaginatedController<int>();
  @override
  void initState() {
    getNewData();
    super.initState();
  }

  final List<int> data = List.generate(10, (index) => index + 1);
  bool isLoading = false;
  bool isShowButton = false;
  void getNewData() async {
    isLoading = true;
    setState(() {});
    await Future.delayed(const Duration(seconds: 1));
    paginatedController.addData(data);
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Gits Paginated ListView Builder'),
          ),
          floatingActionButton: isShowButton == false
              ? null
              : FloatingActionButton(
                  onPressed: () {
                    paginatedController.scrollController.animateTo(0,
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeIn);
                  },
                  child: const Icon(Icons.keyboard_arrow_up),
                ),
          body: RefreshIndicator(
            onRefresh: () async {
              paginatedController.reset();
              getNewData();
            },
            child: GitsPaginatedListViewBuilder<int>(
              threshold: 80,
              controller: paginatedController,
              isLoading: isLoading,
              onHitThreshold: (context, current) {
                if (isLoading == false) {
                  log(current.toString());
                  getNewData();
                }
              },
              onScrolling: (context, current, controller) {
                if (controller.position.pixels > 50) {
                  if (isShowButton == false) {
                    isShowButton = true;
                    setState(() {});
                  }
                } else {
                  if (isShowButton == true) {
                    isShowButton = false;
                    setState(() {});
                  }
                }
                log(controller.position.pixels.toString());
              },
              itemBuilder: (context, index, currentData) => Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                    color: Colors.orange,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(index.toString()),
                    )),
              ),
            ),
          )),
    );
  }
}
