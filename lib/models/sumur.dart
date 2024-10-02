import 'package:siatab/models/koordinat.dart';

class Sumur {
  String? id;
  String name;
  Koordinat koordinat;
  String manfaatJiwa;
  String manfaatIrigasi;
  String operasi;
  String fungsiSumur;
  double debit;
  String kondisiSumur;

  Sumur({
    this.id,
    required this.name,
    required this.koordinat,
    required this.manfaatJiwa,
    required this.manfaatIrigasi,
    required this.operasi,
    required this.fungsiSumur,
    required this.debit,
    required this.kondisiSumur,
  });

  factory Sumur.fromJson(Map<String, dynamic> json) {
    return Sumur(
      id: json['id'],
      name: json['name'],
      koordinat: Koordinat.fromJson(json),
      manfaatJiwa: json['manfaat_jiwa'],
      manfaatIrigasi: json['manfaat_irigasi'],
      operasi: json['operasi'],
      fungsiSumur: json['fungsi_sumur'],
      debit: json['debit'],
      kondisiSumur: json['kondisi_sumur'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      ...koordinat.toJson(),
      'manfaat_jiwa': manfaatJiwa,
      'manfaat_irigasi': manfaatIrigasi,
      'operasi': operasi,
      'fungsi_sumur': fungsiSumur,
      'debit': debit,
      'kondisi_sumur': kondisiSumur,
    };
  }

  @override
  String toString() {
    return 'Sumur{id: $id, name: $name, koordinat: $koordinat, manfaatJiwa: $manfaatJiwa, manfaatIrigasi: $manfaatIrigasi}';
  }
}
