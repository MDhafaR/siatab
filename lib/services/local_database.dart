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
  final String columnManfaatIrigasi = 'manfaat_irigasi';
  final String columnOperasi = 'operasi';

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
            $columnOperasi TEXT NOT NULL,
            $columnManfaatIrigasi TEXT NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE $tableSumur (
            $columnId TEXT PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnLatitude REAL NOT NULL,
            $columnLongitude REAL NOT NULL,
            $columnManfaatJiwa TEXT NOT NULL,
            $columnManfaatIrigasi TEXT NOT NULL,
            $columnOperasi TEXT NOT NULL,
            $columnFungsiSumur TEXT NOT NULL,
            $columnDebit REAL NOT NULL,
            $columnKondisiSumur TEXT NOT NULL
          )
        ''');
      },
    );
  }

  // MataAir CRUD operations
  Future<int> insertMataAir(MataAir mataAir) async {
    Database? db = await database();
    return await db!.insert(tableMataAir, {
      columnName: mataAir.name,
      columnLatitude: mataAir.koordinat.latitude,
      columnLongitude: mataAir.koordinat.longitude,
      columnManfaatJiwa: mataAir.manfaatJiwa,
      columnOperasi: mataAir.operasi,
      columnManfaatIrigasi: mataAir.manfaatIrigasi,
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
        columnName: mataAir.name,
        columnLatitude: mataAir.koordinat.latitude,
        columnLongitude: mataAir.koordinat.longitude,
        columnManfaatJiwa: mataAir.manfaatJiwa,
        columnOperasi: mataAir.operasi,
        columnManfaatIrigasi: mataAir.manfaatIrigasi,
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
      columnId: sumur.id,
      columnName: sumur.name,
      columnLatitude: sumur.koordinat.latitude,
      columnLongitude: sumur.koordinat.longitude,
      columnManfaatJiwa: sumur.manfaatJiwa,
      columnManfaatIrigasi: sumur.manfaatIrigasi,
      columnOperasi: sumur.operasi,
      columnFungsiSumur: sumur.fungsiSumur,
      columnDebit: sumur.debit,
      columnKondisiSumur: sumur.kondisiSumur,
    });
  }

  Future<List<Sumur>> getSumur() async {
    Database? db = await database();
    var result = await db!.query(tableSumur);
    return result.map((json) => Sumur.fromJson(json)).toList();
  }

  Future<int> updateSumur(Sumur sumur) async {
    Database? db = await database();
    return await db!.update(
      tableSumur,
      {
        columnName: sumur.name,
        columnLatitude: sumur.koordinat.latitude,
        columnLongitude: sumur.koordinat.longitude,
        columnManfaatJiwa: sumur.manfaatJiwa,
        columnManfaatIrigasi: sumur.manfaatIrigasi,
        columnOperasi: sumur.operasi,
        columnFungsiSumur: sumur.fungsiSumur,
        columnDebit: sumur.debit,
        columnKondisiSumur: sumur.kondisiSumur,
      },
      where: '$columnId = ?',
      whereArgs: [sumur.id],
    );
  }

  Future<int> deleteSumur(String id) async {
    Database? db = await database();
    return await db!.delete(
      tableSumur,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}