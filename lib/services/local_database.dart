import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:siatab/models/mata_air.dart';
import 'package:siatab/models/sumur.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  final String dbName = 'siatab.db';
  final int dbVersion = 1;

  // Table names
  final String tableMataAir = 'mata_air';
  final String tableSumur = 'sumur';

  // Common columns
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnLatitude = 'latitude';
  final String columnLongitude = 'longitude';
  final String columnManfaatJiwa = 'manfaat_jiwa';
  final String columnManfaatLuasDaerah = 'manfaat_luas_daerah';
  final String columnOperasi = 'operasi';
  final String columnKodeIntegrasi = 'kode_integrasi';
  final String columnNamaBalai = 'nama_balai';
  final String columnNamaWs = 'nama_ws';
  final String columnNamaDas = 'nama_das';
  final String columnKota = 'kota';
  final String columnProvinsi = 'provinsi';
  final String columnKecamatan = 'kecamatan';
  final String columnKelurahan = 'kelurahan';

  // Sumur specific columns
  final String columnFungsiSumur = 'fungsi_sumur';
  final String columnDebit = 'debit';
  final String columnKondisiSumur = 'kondisi_sumur';

  Database? _database;

  Future<Database?> database() async {
    if (_database != null) return _database;
    _database = await initDb();
    return _database;
  }

  initDb() async {
    Directory documentDir = await getApplicationDocumentsDirectory();
    String path = join(documentDir.path, dbName);
    return await openDatabase(
      path,
      version: dbVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableMataAir (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT NOT NULL,
            $columnLatitude REAL NOT NULL,
            $columnLongitude REAL NOT NULL,
            $columnManfaatJiwa TEXT NOT NULL,
            $columnManfaatLuasDaerah TEXT NOT NULL,
            $columnOperasi TEXT NOT NULL,
            $columnKodeIntegrasi TEXT NOT NULL,
            $columnNamaBalai TEXT NOT NULL,
            $columnNamaWs TEXT NOT NULL,
            $columnNamaDas TEXT NOT NULL,
            $columnKota TEXT NOT NULL,
            $columnProvinsi TEXT NOT NULL, 
            $columnKecamatan TEXT NOT NULL,
            $columnKelurahan TEXT NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE $tableSumur (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT NOT NULL,
            $columnLatitude REAL NOT NULL,
            $columnLongitude REAL NOT NULL,
            $columnManfaatJiwa TEXT NOT NULL,
            $columnManfaatLuasDaerah TEXT,
            $columnOperasi TEXT NOT NULL,
            $columnFungsiSumur TEXT NOT NULL,
            $columnDebit REAL NOT NULL,
            $columnKondisiSumur TEXT NOT NULL,
            $columnKodeIntegrasi TEXT NOT NULL,
            $columnNamaBalai TEXT NOT NULL,
            $columnNamaWs TEXT NOT NULL,
            $columnNamaDas TEXT NOT NULL,
            $columnKota TEXT NOT NULL,
            $columnProvinsi TEXT NOT NULL, 
            $columnKecamatan TEXT NOT NULL,
            $columnKelurahan TEXT NOT NULL
          )
        ''');
      },
      onUpgrade: _onUpgrade,
    );
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {}
  }

  // MataAir CRUD operations
  Future<int> insertMataAir(MataAir mataAir) async {
    Database? db = await database();
    return await db!.insert(tableMataAir, {
      columnName: mataAir.nama,
      columnLatitude: mataAir.koordinat.latitude,
      columnLongitude: mataAir.koordinat.longitude,
      columnManfaatJiwa: mataAir.manfaatJiwa,
      columnOperasi: mataAir.operasi,
      columnManfaatLuasDaerah: mataAir.manfaatLuasDaerah,
      columnKodeIntegrasi: mataAir.kodeIntegrasi,
      columnNamaBalai: mataAir.namaBalai,
      columnNamaWs: mataAir.namaWs,
      columnNamaDas: mataAir.namaDas,
      columnKota: mataAir.kota,
      columnProvinsi: mataAir.provinsi,
      columnKecamatan: mataAir.kecamatan,
      columnKelurahan: mataAir.kelurahan,
    });
  }

  Future<List<MataAir>> getMataAir() async {
    Database? db = await database();
    var result = await db!.query(tableMataAir);
    return result.map((json) => MataAir.fromJson(json)).toList();
  }

  Future<int> updateMataAir(MataAir mataAir) async {
    Database? db = await database();
    return await db!.update(
      tableMataAir,
      {
        columnName: mataAir.nama,
        columnLatitude: mataAir.koordinat.latitude,
        columnLongitude: mataAir.koordinat.longitude,
        columnManfaatJiwa: mataAir.manfaatJiwa,
        columnOperasi: mataAir.operasi,
        columnManfaatLuasDaerah: mataAir.manfaatLuasDaerah,
        columnKodeIntegrasi: mataAir.kodeIntegrasi,
        columnNamaBalai: mataAir.namaBalai,
        columnNamaWs: mataAir.namaWs,
        columnNamaDas: mataAir.namaDas,
        columnKota: mataAir.kota,
        columnProvinsi: mataAir.provinsi,
        columnKecamatan: mataAir.kecamatan,
        columnKelurahan: mataAir.kelurahan,
      },
      where: '$columnId = ?',
      whereArgs: [mataAir.id],
    );
  }

  Future<int> deleteMataAir(int id) async {
    Database? db = await database();
    return await db!.delete(
      tableMataAir,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Sumur CRUD operations
  Future<int> insertSumur(Sumur sumur) async {
    Database? db = await database();
    return await db!.insert(tableSumur, {
      columnName: sumur.nama,
      columnLatitude: sumur.koordinat.latitude,
      columnLongitude: sumur.koordinat.longitude,
      columnManfaatJiwa: sumur.manfaatJiwa,
      columnManfaatLuasDaerah: sumur.manfaatLuasDaerah,
      columnOperasi: sumur.operasi,
      columnFungsiSumur: sumur.fungsiSumur,
      columnDebit: sumur.debit,
      columnKondisiSumur: sumur.kondisiSumur,
      columnKodeIntegrasi: sumur.kodeIntegrasi,
      columnNamaBalai: sumur.namaBalai,
      columnNamaWs: sumur.namaWs,
      columnNamaDas: sumur.namaDas,
      columnKota: sumur.kota,
      columnProvinsi: sumur.provinsi,
      columnKecamatan: sumur.kecamatan,
      columnKelurahan: sumur.kelurahan,
    });
  }

  Future<int> updateSumur(Sumur sumur) async {
    Database? db = await database();
    return await db!.update(
      tableSumur,
      {
        columnName: sumur.nama,
        columnLatitude: sumur.koordinat.latitude,
        columnLongitude: sumur.koordinat.longitude,
        columnManfaatJiwa: sumur.manfaatJiwa,
        columnManfaatLuasDaerah: sumur.manfaatLuasDaerah,
        columnOperasi: sumur.operasi,
        columnFungsiSumur: sumur.fungsiSumur,
        columnDebit: sumur.debit,
        columnKondisiSumur: sumur.kondisiSumur,
        columnKodeIntegrasi: sumur.kodeIntegrasi,
        columnNamaBalai: sumur.namaBalai,
        columnNamaWs: sumur.namaWs,
        columnNamaDas: sumur.namaDas,
        columnKota: sumur.kota,
        columnProvinsi: sumur.provinsi,
        columnKecamatan: sumur.kecamatan,
        columnKelurahan: sumur.kelurahan,
      },
      where: '$columnId = ?',
      whereArgs: [sumur.id],
    );
  }

  Future<List<Sumur>> getSumur() async {
    Database? db = await database();
    var result = await db!.query(tableSumur);
    print('ini po sumur $result');
    return result.map((json) => Sumur.fromJson(json)).toList();
  }

  Future<int> deleteSumur(int id) async {
    Database? db = await database();
    return await db!.delete(
      tableSumur,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
