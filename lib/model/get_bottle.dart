import 'dart:convert';

Bottle bottleFromJson(String str) => Bottle.fromJson(json.decode(str));

class Bottle {
  String context;
  String id;
  String type;

  @override
  String toString() {
    return '{context: $context, id: $id, type: $type}';
  }

  Bottle({
    required this.context,
    required this.id,
    required this.type,
  });

  factory Bottle.fromJson(Map<String, dynamic> json) {
    return Bottle(
      context: json['@context'],
      id: json['@id'],
      type: json['@type'],
    );
  }
}
