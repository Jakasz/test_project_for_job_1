import 'dart:convert';

Nodes nodesFromJson(String str) => Nodes.fromJson(json.decode(str));

String nodesToJson(Nodes data) => json.encode(data.toJson());

class Nodes {
  Nodes({
    required this.data,
  });

  final List<MainBody> data;

  factory Nodes.fromJson(Map<String, dynamic> json) => Nodes(
    data: List<MainBody>.from(json["data"].map((x) => MainBody.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class MainBody {
  MainBody({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  final String id;
  final List<String> field;
  final End start;
  final End end;

  factory MainBody.fromJson(Map<String, dynamic> json) => MainBody(
    id: json["id"],
    field: List<String>.from(json["field"].map((x) => x)),
    start: End.fromJson(json["start"]),
    end: End.fromJson(json["end"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "field": List<dynamic>.from(field.map((x) => x)),
    "start": start.toJson(),
    "end": end.toJson(),
  };
}

class End {
  End({
    required this.x,
    required this.y,
  });

  final int x;
  final int y;

  factory End.fromJson(Map<String, dynamic> json) => End(
    x: json["x"],
    y: json["y"],
  );

  Map<String, dynamic> toJson() => {
    "x": x,
    "y": y,
  };
}
