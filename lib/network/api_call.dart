
//https://sitebulb.com/hints/internal/query-string-contains-a-question-mark/
//  https://www.androidhive.info/2016/05/android-working-with-retrofit-http-library/
//https://api.themoviedb.org/3/movie/popular?api_key=d4e5eaaee1c42ff0d65c9bca90ec6e4a
//https://api.themoviedb.org/3/movie/popular?api_key=d4e5eaaee1c42ff0d65c9bca90ec6e4a&language=en-US&page=1
//https://developers.themoviedb.org/3/movies/get-now-playing

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';

import 'model/MoviesRespons.dart';
part 'api_call.g.dart';

//https://sitebulb.com/hints/internal/query-string-contains-a-question-mark/
//  https://www.androidhive.info/2016/05/android-working-with-retrofit-http-library/
//https://api.themoviedb.org/3/movie/popular?api_key=d4e5eaaee1c42ff0d65c9bca90ec6e4a
//https://api.themoviedb.org/3/movie/popular?api_key=d4e5eaaee1c42ff0d65c9bca90ec6e4a&language=en-US&page=1
//https://developers.themoviedb.org/3/movies/get-now-playing
//https://medium.com/globant-mobile-studio-india/easy-way-to-implement-rest-api-calls-in-flutter-9859d1ab5396#:~:text=Retrofit%20implementation%20in%20Flutter,yaml%20file.
@RestApi(baseUrl: "https://api.themoviedb.org/3")
//this method calling form main.dart
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  static RestClient create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return RestClient(dio);
  }

  @GET("/movie/popular")
  Future<MoviesResp> getPopularMovies(@Query("api_key") String apiKey,
                                      @Query('page')int pageNo);
}

