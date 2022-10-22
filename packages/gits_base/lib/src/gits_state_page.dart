import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'gits_cubit.dart';

/// A [GitsStatePage] is mixin class on [State] purpose
/// to make clean state management combine with [GitsCubit]
mixin GitsStatePage<T extends StatefulWidget, C extends GitsCubit> on State<T> {
  /// The cubit where cubit extends [GitsCubit]
  late C cubit = setCubit();

  /// Set the cubit must be set in declare mixin [GitsStatePage]
  C setCubit();

  /// Describes the part of the user interface represented by this widget,
  /// replace [build] for create interface.
  ///
  /// ```dart
  /// @override
  /// Widget buildWidget(BuildContext context) {
  ///   return Scaffold(
  ///     appBar: AppBar(title: Text(context.s.login)),
  ///     body: ListView(
  ///       padding: const EdgeInsets.all(16),
  ///       children: [
  ///         ThirdLoginButton(
  ///           onFacebookPressed: cubit.onLoginWithFacebookPressed,
  ///           onGooglePressed: cubit.onLoginWithGooglePressed,
  ///           onApplePressed: cubit.onLoginWithApplePressed,
  ///         ),
  ///         const GitsSpacing.vertical36(),
  ///         const DividerOr(),
  ///         const GitsSpacing.vertical36(),
  ///         const LoginWithEmail(),
  ///         const GitsSpacing.vertical32(),
  ///         const NewRegister(),
  ///       ],
  ///     ),
  ///   );
  /// }
  /// ```
  ///
  Widget buildWidget(BuildContext context);

  /// Call [initState] for cubit and call [initAfterFirstLayout] after frame completed.
  @override
  void initState() {
    super.initState();
    cubit.initState(context);
    WidgetsBinding.instance.endOfFrame.then((_) {
      if (mounted) {
        cubit.initAfterFirstLayout(context);
        cubit.initArgument<T>(widget);
      }
    });
  }

  /// Close cubit for clear memory.
  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  /// Replace build [StatefulWidget] with [buildWidget]
  ///
  /// Create [MultiBlocProvider] for [Cubit] and [Bloc]
  /// after that create [MultiBlocListener] if is not empty list.
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
