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
      'specializations': specs,
    };
  }

  Map<String, dynamic> toMap2() {
    return {
      'name': name,
      'fields': FieldValue.arrayUnion([]),
      'specializations': FieldValue.arrayUnion([]),
    };
  }

  factory University.fromMap(Map<String, dynamic> map) {
    return University(
      name: map['name'] ?? '',
      fields: List<String>.from(map['fields']),
      specs: List<Map<String, dynamic>>.from(map['specializations']),
    );
  }

  factory University.fromDocument(DocumentSnapshot doc) {
    return University(
      name: doc['name'] ?? '',
      fields: List<String>.from(doc['fields']),
      specs: List<Map<String, dynamic>>.from(doc['specializations']),
    );
  }

  String toJson() => json.encode(toMap());

  factory University.fromJson(String source) =>
      University.fromMap(json.decode(source));
}

class WithOutPrivateConstuctor {
  static get instance => WithOutPrivateConstuctor();
  static final instance2 = WithOutPrivateConstuctor();
  static String? field;

  int? returnInt() {
    return 1;
  }
}

class WithPrivateConstuctor {
  WithPrivateConstuctor._();

  static get instance => WithPrivateConstuctor._();
  static final instance2 = WithPrivateConstuctor._();
  static String? field;

  int? returnInt() {
    return 1;
  }
}
