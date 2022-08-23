import 'dart:convert';

GetCellars getCellarsFromJson(String str) =>
    GetCellars.fromJson(json.decode(str));

String getCellarsToJson(GetCellars data) => json.encode(data.toJson());

class GetCellars {
  GetCellars({
    required this.context,
    required this.id,
    required this.type,
    required this.hydraMember,
    required this.hydraTotalItems,
  });

  String context;
  String id;
  String type;
  List<HydraMember> hydraMember;
  int hydraTotalItems;

  factory GetCellars.fromJson(Map<String, dynamic> json) => GetCellars(
        context: json["@context"],
        id: json["@id"],
        type: json["@type"],
        hydraMember: List<HydraMember>.from(
            json["hydra:member"].map((x) => HydraMember.fromJson(x))),
        hydraTotalItems: json["hydra:totalItems"],
      );

  Map<String, dynamic> toJson() => {
        "@context": context,
        "@id": id,
        "@type": type,
        "hydra:member": List<dynamic>.from(hydraMember.map((x) => x.toJson())),
        "hydra:totalItems": hydraTotalItems,
      };
}

class HydraMember {
  HydraMember({
    required this.id,
    required this.type,
    required this.hydraMemberId,
    required this.name,
    required this.isActive,
  });

  String id;
  String type;
  int hydraMemberId;
  String name;
  bool isActive;

  factory HydraMember.fromJson(Map<String, dynamic> json) => HydraMember(
        id: json["@id"],
        type: json["@type"],
        hydraMemberId: json["id"],
        name: json["name"] == null ? null : json["name"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "@id": id,
        "@type": type,
        "id": hydraMemberId,
        "name": name == null ? null : name,
        "isActive": isActive,
      };
}
