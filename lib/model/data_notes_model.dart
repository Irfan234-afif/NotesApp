// To parse this JSON data, do
//
//     final DataNotesModel = DataNotesModelFromJson(jsonString);

import 'dart:convert';

DataNotesModel DataNotesModelFromJson(String str) =>
    DataNotesModel.fromJson(json.decode(str));

String DataNotesModelToJson(DataNotesModel data) => json.encode(data.toJson());

class DataNotesModel {
  List<DataNote>? dataNotes;

  DataNotesModel({
    this.dataNotes,
  });

  factory DataNotesModel.fromJson(Map<String, dynamic> json) => DataNotesModel(
        dataNotes: json["dataNotes"] == null
            ? []
            : List<DataNote>.from(
                json["dataNotes"]!.map((x) => DataNote.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dataNotes": dataNotes == null
            ? []
            : List<dynamic>.from(dataNotes!.map((x) => x.toJson())),
      };
}

class DataNote {
  String? title;
  DateTime? created;
  String? content;
  DateTime? lastModified;
  bool isSelected;

  DataNote({
    this.title,
    this.created,
    this.content,
    this.lastModified,
    this.isSelected = false,
  });

  factory DataNote.fromJson(Map<String, dynamic> json) => DataNote(
        created: json["created"],
        content: json["content"],
        lastModified: json["lastModified"],
      );

  Map<String, dynamic> toJson() => {
        "created": created,
        "content": content,
        "lastModified": lastModified,
      };
}
