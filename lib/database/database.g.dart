// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? join(await sqflite.getDatabasesPath(), name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MovieDao _movieDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    return sqflite.openDatabase(
      path,
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Movie` (`Id` INTEGER PRIMARY KEY AUTOINCREMENT, `MovieID` INTEGER, `Title` TEXT, `Poster` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
  }

  @override
  MovieDao get movieDao {
    return _movieDaoInstance ??= _$MovieDao(database, changeListener);
  }
}

class _$MovieDao extends MovieDao {
  _$MovieDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _movieEntityInsertionAdapter = InsertionAdapter(
            database,
            'Movie',
            (MovieEntity item) => <String, dynamic>{
                  'Id': item.id,
                  'MovieID': item.movieID,
                  'Title': item.title,
                  'Poster': item.poster
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _movieMapper = (Map<String, dynamic> row) => MovieEntity(
      row['Title'] as String,
      row['Poster'] as String,
      row['MovieID'] as int,
      row['Id'] as int);

  final InsertionAdapter<MovieEntity> _movieEntityInsertionAdapter;

  @override
  Future<List<MovieEntity>> findAllMovies() async {
    return _queryAdapter.queryList('SELECT * FROM Movie', mapper: _movieMapper);
  }

  @override
  Future<void> deleteParticularItem(int userId) async {
    await _queryAdapter.queryNoReturn('DELETE FROM Movie WHERE MovieID = ?',
        arguments: <dynamic>[userId]);
  }

  @override
  Future<void> insertFavoriteMovie(MovieEntity movie) async {
    await _movieEntityInsertionAdapter.insert(
        movie, sqflite.ConflictAlgorithm.abort);
  }
}
