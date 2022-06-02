import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'gits_cubit.dart';

mixin GitsStatePage<T extends StatefulWidget, C extends GitsCubit> on State<T> {
  late C cubit;

  C setCubit();
  Widget buildWidget(BuildContext context);

  @override
  void initState() {
    super.initState();
    cubit = setCubit();
    cubit.initState(context);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => cubit.initAfterFirstLayout(context),
    );
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => cubit),
        ...cubit.blocProviders(context),
      ],
      child: Builder(
        builder: (context) {
          if (cubit.blocListeners(context).isEmpty) {
            return buildWidget(context);
          }
          return MultiBlocListener(
            listeners: cubit.blocListeners(context),
            child: buildWidget(context),
          );
        },
      ),
    );
  }
}
