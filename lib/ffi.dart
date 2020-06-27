/// bindings for `librustic`

import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart' as ffi;

part 'ffi.g.dart';

// THIS ADDED BY ME, dart-bingen has to integrate with `allo-isolate`

/// C function `store_dart_post_cobject`.
Pointer store_dart_post_cobject(
    Pointer<NativeFunction<Int8 Function(Int64, Pointer<Dart_CObject>)>> ptr) {
  return _store_dart_post_cobject(ptr);
}

final _store_dart_post_cobject = _dl
    .lookupFunction<_store_dart_post_cobject_C, _store_dart_post_cobject_Dart>(
  'store_dart_post_cobject',
);

typedef _store_dart_post_cobject_C = Pointer Function(
    Pointer<NativeFunction<Int8 Function(Int64, Pointer<Dart_CObject>)>>);
typedef _store_dart_post_cobject_Dart = Pointer Function(
    Pointer<NativeFunction<Int8 Function(Int64, Pointer<Dart_CObject>)>>);
