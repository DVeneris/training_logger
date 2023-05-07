// import 'dart:async';
// import 'package:flutter/widgets.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:training_tracker/models/consts/constants.dart';
// import 'package:training_tracker/models/user.dart';

// class DatabaseRepository {
//   static final DatabaseRepository instance = DatabaseRepository._init();
//   DatabaseRepository._init();
//   Database? _database;
//   Future<Database> get database async {
//     if (_database != null) return _database!;

//     _database = await _initDB('training_logger.db');
//     return _database!;
//   }

//   Future<Database> _initDB(String dbFilePath) async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, dbFilePath);

//     return await openDatabase(path, version: 1, onCreate: _createDB);
//   }

//   Future _createDB(Database db, int version) async {
//     // await db.execute('''
//     //   create table ${UserConsts.tableName} (
//     //     ${UserConsts.id} integer primary key ,
//     //     ${UserConsts.userName} text not null,
//     //     ${UserConsts.firstName} text null,
//     //     ${UserConsts.lastName} text null,
//     //     ${UserConsts.email} text null,
//     //     ${UserConsts.createdDate} text not null,)
//     //   ''');
//     Batch batch = db.batch();
//     batch.execute('''
//       create table ${UserConsts.tableName} ( 
//         ${UserConsts.id} integer primary key , 
//         ${UserConsts.userName} text not null, 
//         ${UserConsts.firstName} text null,
//         ${UserConsts.lastName} text null,
//         ${UserConsts.email} text null,
//         ${UserConsts.createdDate} text not null)
//       ''');
//     batch.execute('''
//       create table ${MediaItemConstants.tableName} ( 
//         ${MediaItemConstants.id} integer primary key, 
//         ${MediaItemConstants.name} text not null,
//         ${MediaItemConstants.url} text not null)
//       ''');
//     batch.execute('''
//         alter table ${UserConsts.tableName} add column ${UserConsts.mediaItemId} text references ${MediaItemConstants.tableName}(${MediaItemConstants.id})on delete set null on update cascade
//       ''');
//     batch.execute('''
//         alter table ${MediaItemConstants.tableName} add column ${MediaItemConstants.userId} text references ${UserConsts.tableName}(${UserConsts.id})
//       ''');
//     List<dynamic> results = await batch.commit();
//   }

//   Future<void> insert({required User userModel}) async {
//     try {
//       final db = await database;
//       db.insert(UserConsts.tableName, userModel.toMap());
//     } catch (e) {
//       print(e.toString());
//     }
//   }
// }
