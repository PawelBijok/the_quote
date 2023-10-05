abstract class Jsonable<T> {
  T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson(T data);
}
