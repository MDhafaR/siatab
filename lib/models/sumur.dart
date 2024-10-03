import 'package:siatab/models/koordinat.dart';

class Sumur {
  int? id;
  String nama;
  String kodeIntegrasi;
  String manfaatJiwa;
  String manfaatLuasDaerah;
  double debit;
  String kondisiSumur;
  String fungsiSumur;
  String operasi;
  String namaBalai;
  String namaWs;
  String namaDas;
  String kota;
  String provinsi;
  String kecamatan;
  String kelurahan;
  Koordinat koordinat;

  Sumur({
    this.id,
    required this.nama,
    required this.kodeIntegrasi,
    required this.manfaatJiwa,
    required this.manfaatLuasDaerah,
    required this.debit,
    required this.kondisiSumur,
    required this.fungsiSumur,
    required this.operasi,
    required this.namaBalai,
    required this.namaWs,
    required this.namaDas,
    required this.kota,
    required this.provinsi,
    required this.kecamatan,
    required this.kelurahan,
    required this.koordinat,
  });

  factory Sumur.fromJson(Map<String, dynamic> json) {
    return Sumur(
      id: json['id'],
      nama: json['name'],
      koordinat: Koordinat.fromJson(json),
      manfaatJiwa: json['manfaat_jiwa'],
      manfaatLuasDaerah: json['manfaat_luas_daerah'],
      operasi: json['operasi'],
      debit: json['debit'].toDouble(),
      kondisiSumur: json['kondisi_sumur'],
      kodeIntegrasi: json['kode_integrasi'],
      fungsiSumur: json['fungsi_sumur'],
      namaBalai: json['nama_balai'],
      namaWs: json['nama_ws'],
      namaDas: json['nama_das'],
      kota: json['kota'],
      provinsi: json['provinsi'],
      kecamatan: json['kecamatan'],
      kelurahan: json['kelurahan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': nama,
      'kode_integrasi': kodeIntegrasi,
      'manfaat_jiwa': manfaatJiwa,
      'manfaat_luas_daerah': manfaatLuasDaerah,
      'debit': debit,
      'kondisi_sumur': kondisiSumur,
      'fungsi_sumur': fungsiSumur,
      'operasi': operasi,
      'nama_balai': namaBalai,
      'nama_ws': namaWs,
      'nama_das': namaDas,
      'kota': kota,
      'provinsi': provinsi,
      'kecamatan': kecamatan,
      'kelurahan': kelurahan,
      ...koordinat.toJson(),
    };
  }

  @override
  String toString() {
    return 'Sumur{id: $id, nama: $nama, kodeIntegrasi: $kodeIntegrasi, manfaatJiwa: $manfaatJiwa, manfaatLuasDaerah: $manfaatLuasDaerah, debit: $debit, kondisiSumur: $kondisiSumur, fungsiSumur: $fungsiSumur, operasi: $operasi, namaBalai: $namaBalai, namaWs: $namaWs, namaDas: $namaDas, kota: $kota, provinsi: $provinsi, kecamatan: $kecamatan, kelurahan: $kelurahan, koordinat: $koordinat}';
  }
}
