import 'package:siatab/models/koordinat.dart';

class MataAir {
  int? id;
  String name;
  Koordinat koordinat;
  String manfaatJiwa;
  String operasi;
  String manfaatIrigasi;

  MataAir({
    this.id,
    required this.name,
    required this.koordinat,
    required this.manfaatJiwa,
    required this.operasi,
    required this.manfaatIrigasi,
  });

  factory MataAir.fromJson(Map<String, dynamic> json) {
    return MataAir(
      id: json['id'],
      name: json['name'],
      koordinat: Koordinat.fromJson(json),
      manfaatJiwa: json['manfaat_jiwa'],
      operasi: json['operasi'],
      manfaatIrigasi: json['manfaat_irigasi'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      ...koordinat.toJson(),
      'manfaat_jiwa': manfaatJiwa,
      'operasi': operasi,
      'manfaat_irigasi': manfaatIrigasi,
    };
  }

  @override
  String toString() {
    return 'MataAir{id: $id, name: $name, koordinat: $koordinat, manfaatJiwa: $manfaatJiwa, operasi: $operasi, manfaatIrigasi: $manfaatIrigasi}';
  }
}