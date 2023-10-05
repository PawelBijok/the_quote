import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class TimestampToDateTimeConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampToDateTimeConverter();

  @override
  DateTime fromJson(Timestamp json) {
    return DateTime.fromMicrosecondsSinceEpoch(json.microsecondsSinceEpoch);
  }

  @override
  Timestamp toJson(DateTime object) => Timestamp.fromDate(object);
}
