import 'package:uuid/uuid.dart';

String get randomId {
  const uuid = Uuid();
  return uuid.v1();
}
