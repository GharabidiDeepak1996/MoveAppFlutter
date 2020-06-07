// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MoviesRespons.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoviesResp _$MoviesRespFromJson(Map<String, dynamic> json) {
  return MoviesResp(
    json['page'] as int,
    json['total_results'] as int,
    json['total_pages'] as int,
  )..results = (json['results'] as List)
      ?.map((e) => e == null ? null : Movie.fromJson(e as Map<String, dynamic>))
      ?.toList();
}

Map<String, dynamic> _$MoviesRespToJson(MoviesResp instance) =>
    <String, dynamic>{
      'page': instance.page,
      'total_results': instance.totalResult,
      'total_pages': instance.totalPage,
      'results': instance.results,
    };

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return Movie(
    (json['popularity'] as num)?.toDouble(),
    json['id'] as int,
    json['poster_path'] as String,
    json['backdrop_path'] as String,
    json['original_language'] as String,
    json['original_title'] as String,
    (json['vote_average'] as num)?.toDouble(),
    json['overview'] as String,
    json['release_date'] as String,
  );
}

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'popularity': instance.popularity,
      'id': instance.id,
      'poster_path': instance.poster,
      'backdrop_path': instance.backGround,
      'original_language': instance.language,
      'original_title': instance.title,
      'vote_average': instance.vote,
      'overview': instance.overview,
      'release_date': instance.releaseDate,
    };
