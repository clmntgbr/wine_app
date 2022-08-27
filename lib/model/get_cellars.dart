import 'dart:convert';

Cellars cellarsFromJson(String str) => Cellars.fromJson(json.decode(str));

class Cellars {
  String context;
  String id;
  String type;
  List<dynamic> hydraMember;

  @override
  String toString() {
    return '{context: $context, id: $id, type: $type, hydraMember: $hydraMember}';
  }

  Cellars({
    required this.context,
    required this.id,
    required this.type,
    required this.hydraMember,
  });

  factory Cellars.fromJson(Map<String, dynamic> json) {
    return Cellars(
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
  String name;
  bool isActive;
  int row;
  int column;
  int bottlesInCellar;

  HydraMember(this.contextId, this.id, this.name, this.isActive, this.row,
      this.column, this.bottlesInCellar);

  factory HydraMember.fromJson(dynamic json) {
    return HydraMember(json['@id'], json['id'], json['name'], json['isActive'],
        json['row'], json['clmn'], json['bottlesInCellar']);
  }

  @override
  String toString() {
    return '{@id: $contextId, id: $id, name: $name, isActive: $isActive, row: $row, column: $column, bottlesInCellar: $bottlesInCellar}';
  }
}
