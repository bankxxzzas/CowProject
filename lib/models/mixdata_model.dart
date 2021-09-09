import 'dart:convert';

class MixDataModel {
  final String dateMix;
  MixDataModel({
    required this.dateMix,
  });

  MixDataModel copyWith({
    String? dateMix,
  }) {
    return MixDataModel(
      dateMix: dateMix ?? this.dateMix,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dateMix': dateMix,
    };
  }

  factory MixDataModel.fromMap(Map<String, dynamic> map) {
    return MixDataModel(
      dateMix: map['dateMix'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MixDataModel.fromJson(String source) => MixDataModel.fromMap(json.decode(source));

  @override
  String toString() => 'MixDataModel(dateMix: $dateMix)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MixDataModel &&
      other.dateMix == dateMix;
  }

  @override
  int get hashCode => dateMix.hashCode;

  static void add(MixDataModel models) {}
}
