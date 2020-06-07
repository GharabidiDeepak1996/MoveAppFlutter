
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermoviesapp/database/database.dart';
import 'package:fluttermoviesapp/database/entity.dart';
import 'package:fluttermoviesapp/utils.dart';

//https://api.flutter.dev/flutter/dart-async/Future-class.html
List<MovieEntity>  mlist;
int count=0;
class FavoMovie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _favoriteMovie();
  }
}


  _favoriteMovie() {
    fetchAllFavoMovies();
    return GridView.builder(
        itemCount: count,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.all(10.0),
            child: GridTile(
              child: Image.network(
                Glob.URL + mlist[index].poster,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
              footer: Container(
                color: Colors.black45,
                child: ListTile(
                  leading: Text(
                    mlist[index].title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          );
        });
  }

 fetchAllFavoMovies() async {
  final database = await $FloorAppDatabase.databaseBuilder('movie_database.db').build();
  Future<List> successor=database.movieDao.findAllMovies();
  successor.then((value) {
    mlist=value;
    count=mlist.length;
  });
}


/*
var future = $FloorAppDatabase.databaseBuilder('movie_database.db').build();
Future<List> successor = future.then((value) {
  // Invoked when the future is completed with a value.
  return value.movieDao.findAllMovies();
});
Future<List> list = successor;
list.then((value) {
favMovie = value;
count = favMovie.length;
});*/
