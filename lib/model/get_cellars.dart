import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(jsonDecode(str));

class Welcome {
  @override
  String toString() {
    return '{id: $id, context: $context}';
  }

  Welcome({
    required this.context,
    required this.id,
    required this.type,
    required this.hydraTotalItems,
  });

  String context;
  String id;
  String type;
  int hydraTotalItems;

  factory Welcome.fromJson(dynamic json) => Welcome(
      context: 'qsdqsd', id: 'sdqsd', type: 'sdqsd', hydraTotalItems: 1);
}
