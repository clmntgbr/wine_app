import 'dart:convert';
import 'dart:ffi';

Bottles bottlesFromJson(String str) => Bottles.fromJson(json.decode(str));

class Bottles {
  String context;
  String id;
  String type;
  List<dynamic> hydraMember;
  int totalItems;

  @override
  String toString() {
    return '{context: $context, id: $id, type: $type, totalItems: $totalItems, hydraMember: $hydraMember}';
  }

  Bottles({
    required this.context,
    required this.id,
    required this.type,
    required this.hydraMember,
    required this.totalItems,
  });

  factory Bottles.fromJson(Map<String, dynamic> json) {
    return Bottles(
      context: json['@context'],
      id: json['@id'],
      type: json['@type'],
      hydraMember: json['hydra:member']
          .map((tagJson) => HydraMember.fromJson(tagJson))
          .toList(),
      totalItems: json['hydra:totalItems'],
    );
  }
}

class HydraMember {
  String contextId;
  int id;
  String? position;
  String? alertAt;
  bool isLiked;
  String wineName;
  String wineAppellationName;
  String wineDomainName;
  String wineRegionName;
  String wineCountryName;
  String capacityName;

  HydraMember(
      this.contextId,
      this.id,
      this.position,
      this.alertAt,
      this.isLiked,
      this.wineName,
      this.wineAppellationName,
      this.wineDomainName,
      this.wineRegionName,
      this.wineCountryName,
      this.capacityName);

  factory HydraMember.fromJson(dynamic json) {
    return HydraMember(
        json['@id'],
        json['id'],
        json['position'],
        json['alertAt'],
        json['isLiked'],
        json['wine']['name'],
        json['wine']['appellation']['name'],
        json['wine']['domain']['name'],
        json['wine']['region']['name'],
        json['wine']['country']['name'],
        json['capacity']['name']);
  }

  @override
  String toString() {
    return '{@id: $contextId, id: $id, wineName: $wineName, position: $position, alertAt: $alertAt, isLiked: $isLiked, wineDomainName: $wineDomainName, wineAppellationName: $wineAppellationName, wineRegionName: $wineRegionName, wineCountryName: $wineCountryName, capacityName: $capacityName}';
  }
}
