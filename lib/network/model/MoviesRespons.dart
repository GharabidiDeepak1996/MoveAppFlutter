import 'package:json_annotation/json_annotation.dart';

part 'MoviesRespons.g.dart';

@JsonSerializable()
class MoviesResp {
  int page;
  @JsonKey(name:'total_results')
  int totalResult;
  @JsonKey(name:'total_pages')
  int totalPage;
  List<Movie> results;


  MoviesResp(this.page, this.totalResult, this.totalPage);

  factory MoviesResp.fromJson(Map<String, dynamic> json) =>
      _$MoviesRespFromJson(json);

  Map<String, dynamic> toJson() => _$MoviesRespToJson(this);
}



@JsonSerializable()
class Movie {
   double popularity;
   int id;
   @JsonKey(name:'poster_path')
   String poster;
   @JsonKey(name:'backdrop_path')
   String backGround;
   @JsonKey(name:'original_language')
   String language;
   @JsonKey(name:'original_title')
   String title;
   @JsonKey(name:'vote_average')
   double vote;
   String overview;
   @JsonKey(name:'release_date')
   String releaseDate;


   Movie(this.popularity, this.id, this.poster, this.backGround,
       this.language, this.title, this.vote, this.overview, this.releaseDate);

   factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);
}

