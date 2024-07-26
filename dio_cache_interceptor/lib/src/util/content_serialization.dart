import 'dart:async';
import 'dart:convert' show Codec, jsonDecode, jsonEncode;

import 'package:dio/dio.dart';

Future<List<int>?> serializeContent(
  ResponseType type,
  dynamic content,
  Codec codec,
) async {
  if (content == null) {
    return null;
  }

  switch (type) {
    case ResponseType.bytes:
      return content;
    case ResponseType.plain:
      return codec.encode(content);
    case ResponseType.json:
      return codec.encode(jsonEncode(content));
    default:
      throw UnsupportedError('Response type not supported : $type.');
  }
}

dynamic deserializeContent(
  ResponseType type,
  List<int>? content,
  Codec codec,
) {
  switch (type) {
    case ResponseType.bytes:
      return content;
    case ResponseType.plain:
      return (content != null) ? codec.decode(content) : null;
    case ResponseType.json:
      return (content != null) ? jsonDecode(codec.decode(content)) : null;
    default:
      throw UnsupportedError('Response type not supported : $type.');
  }
}
