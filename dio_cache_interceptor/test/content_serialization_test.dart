import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/src/util/content_serialization.dart';
import 'package:test/test.dart';

void main() {
  test('Serialize bytes with utf8 codec', () async {
    final content = 'test'.codeUnits;

    final serializedContent = await serializeContent(
      ResponseType.bytes,
      content,
      utf8,
    );
    final deserializedContent = await deserializeContent(
      ResponseType.bytes,
      serializedContent,
      utf8,
    );
    expect(deserializedContent, equals(content));
  });

  test('Serialize bytes with latin1 codec', () async {
    final content = 'test'.codeUnits;

    final serializedContent = await serializeContent(
      ResponseType.bytes,
      content,
      latin1,
    );
    final deserializedContent = await deserializeContent(
      ResponseType.bytes,
      serializedContent,
      latin1,
    );
    expect(deserializedContent, equals(content));
  });

  test('Unsupported stream', () async {
    Stream<List<int>> content() async* {
      yield 'test'.codeUnits;
    }

    expect(
        () async => await serializeContent(
              ResponseType.stream,
              content(),
              utf8,
            ),
        throwsUnsupportedError);
    expect(
        () async => await deserializeContent(
              ResponseType.stream,
              <int>[],
              utf8,
            ),
        throwsUnsupportedError);
  });

  test('Serialize plain', () async {
    final content = 'test';

    final serializedContent = await serializeContent(
      ResponseType.plain,
      content,
      utf8,
    );
    final deserializedContent = await deserializeContent(
      ResponseType.plain,
      serializedContent,
      utf8,
    );
    expect(deserializedContent, equals(content));
  });

  test('Serialize json', () async {
    final content = {'test': 'value'};

    final serializedContent = await serializeContent(
      ResponseType.json,
      content,
      utf8,
    );
    final deserializedContent = await deserializeContent(
      ResponseType.json,
      serializedContent,
      utf8,
    );
    expect(deserializedContent, equals(content));
  });

  test('Serialize null', () async {
    final serializedContent = await serializeContent(
      ResponseType.json,
      null,
      utf8,
    );
    final deserializedContent = await deserializeContent(
      ResponseType.json,
      serializedContent,
      utf8,
    );

    expect(deserializedContent, isNull);
  });
}
