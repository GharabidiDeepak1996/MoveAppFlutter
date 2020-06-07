

import 'package:path/path.dart';
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao.dart';
import 'entity.dart';

part 'database.g.dart';

@Database(version: 1, entities: [MovieEntity])
abstract class AppDatabase extends FloorDatabase {
 MovieDao get movieDao;

}