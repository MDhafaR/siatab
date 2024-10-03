import 'package:siatab/models/koordinat.dart';

class MataAir {
  int? id;
  String nama;
  String kodeIntegrasi;
  String manfaatJiwa;
  String manfaatLuasDaerah;
  String operasi;
  String namaBalai;
  String namaWs;
  String namaDas;
  String kota;
  String provinsi;
  String kecamatan;
  String kelurahan;
  Koordinat koordinat;

  MataAir({
    this.id,
    required this.nama,
    required this.kodeIntegrasi,
    required this.manfaatJiwa,
    required this.manfaatLuasDaerah,
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

  factory MataAir.fromJson(Map<String, dynamic> json) {
    return MataAir(
      id: json['id'],
      nama: json['name'],
      koordinat: Koordinat.fromJson(json),
      manfaatJiwa: json['manfaat_jiwa'],
      manfaatLuasDaerah: json['manfaat_luas_daerah'],
      operasi: json['operasi'],
      kodeIntegrasi: json['kode_integrasi'],
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
    return 'MataAir(id: $id, nama: $nama, kodeIntegrasi: $kodeIntegrasi, manfaatJiwa: $manfaatJiwa, manfaatLuasDaerah: $manfaatLuasDaerah, operasi: $operasi, namaBalai: $namaBalai, namaWs: $namaWs, namaDas: $namaDas, kota: $kota, provinsi: $provinsi, kecamatan: $kecamatan, kelurahan: $kelurahan, koordinat: $koordinat)';
  }
}
