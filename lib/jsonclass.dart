class Json {
  final int id;
  final int version;
  final String json_data;

  Json(this.id, this.version, this.json_data) {}

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'version': version,
      'json_data': json_data,
    };
  }

// Implement toString to make it easier to see information about
// each book.
  @override
  String toString() {
    return '{id:$id,version:$version, json_data: $json_data}';
  }
}
