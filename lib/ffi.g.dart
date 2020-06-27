/// bindings for `librustic`

part of 'ffi.dart';

// ignore_for_file: unused_import, camel_case_types, non_constant_identifier_names
final DynamicLibrary _dl = _open();
DynamicLibrary _open() {
  if (Platform.isAndroid) return DynamicLibrary.open('librustic_dart.so');
  if (Platform.isIOS) return DynamicLibrary.executable();
  throw UnsupportedError('This platform is not supported.');
}

/// C function `last_error_length`.
int last_error_length() {
  return _last_error_length();
}
final _last_error_length_Dart _last_error_length = _dl.lookupFunction<_last_error_length_C, _last_error_length_Dart>('last_error_length');
typedef _last_error_length_C = Int32 Function();
typedef _last_error_length_Dart = int Function();

/// C function `error_message_utf8`.
int error_message_utf8(
  Pointer<ffi.Utf8> buf,
  int length,
) {
  return _error_message_utf8(buf, length);
}
final _error_message_utf8_Dart _error_message_utf8 = _dl.lookupFunction<_error_message_utf8_C, _error_message_utf8_Dart>('error_message_utf8');
typedef _error_message_utf8_C = Int32 Function(
  Pointer<ffi.Utf8> buf,
  Int32 length,
);
typedef _error_message_utf8_Dart = int Function(
  Pointer<ffi.Utf8> buf,
  int length,
);

/// C function `get_album`.
int get_album(
  int port,
  Pointer<ffi.Utf8> base_url,
  Pointer<ffi.Utf8> cursor,
) {
  return _get_album(port, base_url, cursor);
}
final _get_album_Dart _get_album = _dl.lookupFunction<_get_album_C, _get_album_Dart>('get_album');
typedef _get_album_C = Int32 Function(
  Int64 port,
  Pointer<ffi.Utf8> base_url,
  Pointer<ffi.Utf8> cursor,
);
typedef _get_album_Dart = int Function(
  int port,
  Pointer<ffi.Utf8> base_url,
  Pointer<ffi.Utf8> cursor,
);
