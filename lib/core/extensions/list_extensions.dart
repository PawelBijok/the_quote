extension ListExtensions on Iterable<String> {
  bool containsPart(String element) {
    for (final e in this) {
      if (element.contains(e)) return true;
    }
    return false;
  }
}
