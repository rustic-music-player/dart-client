library dart_client;

import 'dart:async';
import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:isolate/ports.dart';

import 'ffi.dart' as native;

class AlbumModel {
  final String title;
  final String cursor;

  AlbumModel({this.title, this.cursor});
}

class RusticClient {
  final String url;

  RusticClient(this.url);

  static setup() {
    native.store_dart_post_cobject(NativeApi.postCObject);
  }

  Future<AlbumModel> getAlbum(String cursor) {
    var urlPointer = Utf8.toUtf8(this.url);
    var cursorPointer = Utf8.toUtf8(cursor);
    final completer = Completer<AlbumModel>();
    final sendPort = singleCompletePort(completer);
    final res = native.get_album(sendPort.nativePort, urlPointer, cursorPointer);
    if (res != 0) {
      _throwError();
    }
    return completer.future;
  }

  void _throwError() {
    final length = native.last_error_length();
    final Pointer<Utf8> message = allocate(count: length);
    native.error_message_utf8(message, length);
    final error = Utf8.fromUtf8(message);
    print(error);
    throw error;
  }
}
