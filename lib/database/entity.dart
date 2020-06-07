

import 'package:floor/floor.dart';

@Entity(tableName: 'Movie')
class MovieEntity {

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'Id')
  final int id;

  @ColumnInfo(name: 'MovieID')
  final int movieID;

  @ColumnInfo(name: 'Title')
  final String title;

  @ColumnInfo(name: 'Poster')
  final String poster;

  MovieEntity(this.title, this.poster,this.movieID,[this.id]);
}