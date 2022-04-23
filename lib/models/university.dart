import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class University {
  String name;
  List<String> fields;
  List<Map<String, dynamic>> specs;
  University({
    required this.name,
    required this.fields,
    required this.specs,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'fields': fields,
      'specs': specs,
    };
  }

  factory University.fromMap(Map<String, dynamic> map) {
    return University(
      name: map['name'] ?? '',
      fields: List<String>.from(map['fields']),
      specs: List<Map<String, dynamic>>.from(map['specs']),
    );
  }

  factory University.fromDocument(DocumentSnapshot doc) {
    return University(
      name: doc['name'] ?? '',
      fields: List<String>.from(doc['fields']),
      specs: List<Map<String, dynamic>>.from(doc['specs']),
    );
  }

  String toJson() => json.encode(toMap());

  factory University.fromJson(String source) =>
      University.fromMap(json.decode(source));
}
