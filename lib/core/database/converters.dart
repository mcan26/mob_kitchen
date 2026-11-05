import 'dart:convert';

import 'package:drift/drift.dart';

/// `List<String>` ↔ JSON metin sütunu (etiketler, altın kurallar, kaynak tarif başlıkları).
class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> fromSql(String fromDb) =>
      (jsonDecode(fromDb) as List).cast<String>().toList(growable: false);

  @override
  String toSql(List<String> value) => jsonEncode(value);
}
