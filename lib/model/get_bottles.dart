import 'dart:convert';

Bottles bottlesFromJson(String str) => Bottles.fromJson(json.decode(str));

class Bottles {
  String context;
  String id;
  String type;
  List<dynamic> hydraMember;

  @override
  String toString() {
    return '{context: $context, id: $id, type: $type, hydraMember: $hydraMember}';
  }

  Bottles({
    required this.context,
    required this.id,
    required this.type,
    required this.hydraMember,
  });

  factory Bottles.fromJson(Map<String, dynamic> json) {
    return Bottles(
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
  String formatName;
  String? position;
  String? alertAt;

  HydraMember(
      this.contextId, this.id, this.formatName, this.position, this.alertAt);

  factory HydraMember.fromJson(dynamic json) {
    return HydraMember(json['@id'], json['id'], json['formatName'],
        json['position'], json['alertAt']);
  }

  @override
  String toString() {
    return '{@id: $contextId, id: $id, formatName: $formatName, position: $position, alertAt: $alertAt}';
  }
}
