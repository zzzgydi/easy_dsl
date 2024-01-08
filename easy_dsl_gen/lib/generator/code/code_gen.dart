class CodeConstrutor {
  final String name;
  final map = <String, String>{};

  CodeConstrutor(this.name);

  void add(String key, String? value) {
    if (value != null) map[key] = value;
  }

  bool hasFields() {
    return map.isNotEmpty;
  }

  /// must return a value
  String generate() {
    final field = map.entries.map((e) => "${e.key}: ${e.value}").join(",");
    return "$name($field)";
  }

  /// return null if there is no value
  String? maybeGenerate() {
    if (map.isEmpty) return null;
    return generate();
  }
}
