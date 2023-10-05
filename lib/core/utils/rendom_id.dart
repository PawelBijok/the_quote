import 'package:uuid/uuid.dart';

String get randomId {
  final uuid = const Uuid();
  return uuid.v1();
}
