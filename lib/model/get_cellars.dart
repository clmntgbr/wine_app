import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Book bookFromJson(String str) => Book.fromJson(json.decode(str));

class Book {
  String context;
  String id;
  String type;
  List<dynamic> hydraMember;

  @override
  String toString() {
    return '{context: $context, id: $id, type: $type, hydraMember: $hydraMember}';
  }

  Book({
    required this.context,
    required this.id,
    required this.type,
    required this.hydraMember,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      context: json['@context'],
      id: json['@id'],
      type: json['@type'],
      hydraMember: json['hydra:member']
          .map((tagJson) => HydraMember.fromJson(tagJson))
          .toList(),
    );
  }
}

class HydraMember {
  String contextId;
  int id;
  String? name;
  bool isActive;

  HydraMember(this.contextId, this.id, this.name, this.isActive);

  factory HydraMember.fromJson(dynamic json) {
    return HydraMember(json['@id'], json['id'], json['name'], json['isActive']);
  }

  @override
  String toString() {
    return '{@id: $contextId, id: $id, name: $name}, isActive: $isActive}';
  }
}
