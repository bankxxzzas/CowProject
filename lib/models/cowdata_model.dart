import 'dart:convert';

class CowDataModel {
  final String ageString;
  final String dateChoose;
  final String dateChooseNew;
  final String gendle;
  final String idCode;
  final String pathImage;
  final String type;
  final String uidRecord;
  CowDataModel({
    required this.ageString,
    required this.dateChoose,
    required this.dateChooseNew,
    required this.gendle,
    required this.idCode,
    required this.pathImage,
    required this.type,
    required this.uidRecord,
  });

  CowDataModel copyWith({
    String? ageString,
    String? dateChoose,
    String? dateChooseNew,
    String? gendle,
    String? idCode,
    String? pathImage,
    String? type,
    String? uidRecord,
  }) {
    return CowDataModel(
      ageString: ageString ?? this.ageString,
      dateChoose: dateChoose ?? this.dateChoose,
      dateChooseNew: dateChooseNew ?? this.dateChooseNew,
      gendle: gendle ?? this.gendle,
      idCode: idCode ?? this.idCode,
      pathImage: pathImage ?? this.pathImage,
      type: type ?? this.type,
      uidRecord: uidRecord ?? this.uidRecord,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ageString': ageString,
      'dateChoose': dateChoose,
      'dateChooseNew': dateChooseNew,
      'gendle': gendle,
      'idCode': idCode,
      'pathImage': pathImage,
      'type': type,
      'uidRecord': uidRecord,
    };
  }

  factory CowDataModel.fromMap(Map<String, dynamic> map) {
    return CowDataModel(
      ageString: map['ageString'],
      dateChoose: map['dateChoose'],
      dateChooseNew: map['dateChooseNew'],
      gendle: map['gendle'],
      idCode: map['idCode'],
      pathImage: map['pathImage'],
      type: map['type'],
      uidRecord: map['uidRecord'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CowDataModel.fromJson(String source) => CowDataModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CowDataModel(ageString: $ageString, dateChoose: $dateChoose, dateChooseNew: $dateChooseNew, gendle: $gendle, idCode: $idCode, pathImage: $pathImage, type: $type, uidRecord: $uidRecord)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CowDataModel &&
      other.ageString == ageString &&
      other.dateChoose == dateChoose &&
      other.dateChooseNew == dateChooseNew &&
      other.gendle == gendle &&
      other.idCode == idCode &&
      other.pathImage == pathImage &&
      other.type == type &&
      other.uidRecord == uidRecord;
  }

  @override
  int get hashCode {
    return ageString.hashCode ^
      dateChoose.hashCode ^
      dateChooseNew.hashCode ^
      gendle.hashCode ^
      idCode.hashCode ^
      pathImage.hashCode ^
      type.hashCode ^
      uidRecord.hashCode;
  }
}
