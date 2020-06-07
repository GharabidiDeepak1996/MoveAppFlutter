

import 'package:floor/floor.dart';
import 'package:fluttermoviesapp/network/model/MoviesRespons.dart';

import 'entity.dart';

@dao
abstract class MovieDao {

  @insert
  Future<void> insertFavoriteMovie(MovieEntity movie);

  @Query('SELECT * FROM Movie')
  Future<List<MovieEntity>> findAllMovies();

  @Query('DELETE FROM Movie WHERE MovieID = :userId"')
  Future<void> deleteParticularItem(int userId); // query without returning an entity
}