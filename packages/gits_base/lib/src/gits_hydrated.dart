import 'dart:convert';

import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../gits_base.dart';

mixin GitsHydrated<T> on GitsCubit<T> {
  String get _keyStorage => T.hashCode.toString();
  final _storage = const FlutterSecureStorage();

  @override
  void initState(BuildContext context) {
    super.initState(context);
    stream.listen((event) async {
      await _storage.write(key: _keyStorage, value: json.encode(toMap()));
    });
  }

  @override
  void initAfterFirstLayout(BuildContext context) async {
    super.initAfterFirstLayout(context);
    final cache = await _storage.read(key: _keyStorage);
    if (cache != null) {
      final state = fromMap(json.decode(cache));
      emit(state);
      loadedHydrated(state);
    }
  }

  Future<void> clearHydrated() => _storage.delete(key: _keyStorage);

  void loadedHydrated(T state) {}

  Map<String, dynamic> toMap();
  T fromMap(Map<String, dynamic> map);
}
