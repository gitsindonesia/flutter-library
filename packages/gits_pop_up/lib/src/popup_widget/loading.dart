import 'package:flutter/material.dart';

import '../gits_pop_up_cons.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
    this.loadingTitle,
  }) : super(key: key);

  final String? loadingTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
          color: whiteColorCons, borderRadius: BorderRadius.circular(8)),
      child: AspectRatio(
        aspectRatio: 1,
        child: loadingTitle != null
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: CircularProgressIndicator(
                        backgroundColor: const Color(0xFFF2F2F2),
                        strokeWidth: 5,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    Text(loadingTitle ?? "",
                        style: TextStyle(
                            color: blackColorCons,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              )
            : Center(
                child: SizedBox(
                  height: 45,
                  width: 45,
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                    backgroundColor: const Color(0xFFF2F2F2),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
