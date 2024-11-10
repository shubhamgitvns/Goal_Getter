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
    return 'Json{id:$id,version:$version, json_data: $json_data}';
  }
}

// class Person {
//   final String name;
//   final String mobile;
//
//   Person({required this.name, required this.mobile}) {}
//
//   factory Person.fromJson(Map<String, dynamic> json) {
//     return Person(
//       name: json['name'],
//       mobile: json['mobile'],
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'mobile': mobile,
//     };
//   }
//
//   @override
//   String toString() {
//     return 'Json{name:$name, mobile: $mobile}';
//   }
// }