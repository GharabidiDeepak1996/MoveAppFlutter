import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermoviesapp/database/database.dart';
import 'package:fluttermoviesapp/database/entity.dart';
import 'package:fluttermoviesapp/network/api_call.dart';
import 'package:fluttermoviesapp/network/model/MoviesRespons.dart';
import 'package:fluttermoviesapp/screen/DetailScreen.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider.dart';
import '../utils.dart';

class Homelist extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeListState();
  }
}

class HomeListState extends State<Homelist> {
  int totalItem, totalPage, totalItemList, page = 1;
  ScrollController _scrollController = new ScrollController();

  List<String> _favoriteItemAdd = new List();

  List<Movie> moviesList = new List();
  List<Movie> serachList = new List();

  NotifyChange _notifyChange;

  @override
  void initState() {
    super.initState();

    serachList = moviesList;
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        List<String> count = prefs.getStringList("movieID");
        if (count.length > 0) {
          getAllMovieID();
        }
      });
    });
    //reach the bottom
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (page < totalPage && totalItemList < totalItem) {
          setState(() {
            page++;
          });
        }
      }
    });

    //reach the top
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.minScrollExtent) {
        if (page < totalPage && page > 1 && totalItemList < totalItem) {
          setState(() {
            page--;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:_movieUI(),
    );
  }
Widget _movieUI(){
  _notifyChange=Provider.of<NotifyChange>(context);
  String wordTying=_notifyChange.somthingSearch;
 bool _isPress=_notifyChange.isPress;
 if(_isPress){
   setState(() {
     if(wordTying.length<2){
       serachList.clear();
       serachList=moviesList;
     }else{
       serachList.clear();
       serachList = moviesList
           .where((item) => (item.title
           .toLowerCase()
           .contains(_notifyChange.somthingSearch)))
           .toList();
     }

  });
 }
  return Column(
      children: [
      /*  TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(15.0),
            hintText: 'Filter by movie name',
          ),
          onChanged: (string) {
            setState(() {
              setState(() {
                serachList = moviesList
                    .where((item) => (item.title
                    .toLowerCase()
                    .contains(string.toLowerCase())))
                    .toList();
              });
              if (string.isEmpty) {
                setState(() {
                  print('==yes empty==');
                  serachList.clear();
                  serachList = moviesList;
                });
              }
            });
          },
        ),*/


        Expanded(
          child: Scrollbar(child: _listFutureTasks(context)),
        ),
      ],
    );
}
  //receive all movie list through provider and retrofit
  _listFutureTasks(BuildContext context) {
    return FutureBuilder<MoviesResp>(
        //listen =false because of we calling out side tree ---->more info :- https://www.youtube.com/watch?v=QT2LFIe794I
        future: Provider.of<RestClient>(context, listen: false)
            .getPopularMovies(Glob.API_KEY, page),
        builder: (BuildContext context, AsyncSnapshot<MoviesResp> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Container(
                child: Center(
                  child: Text("Something wrond"),
                ),
              );
            }

            final tasks = snapshot.data.results;
            moviesList.clear();
            moviesList.addAll(tasks);
            totalPage = snapshot.data.totalPage;
            totalItem = snapshot.data.totalResult;
            totalItemList = tasks.length;
            // return _listTasks(context: context, tasks: tasks);
            return _listTasks(context: context);
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  // _listTasks({BuildContext context, List<Movie> tasks}) {
  _listTasks({BuildContext context}) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => NotifyChange(),
      child: GridView.builder(
          controller: _scrollController,
          itemCount: serachList.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(10.0),
              child: GridTile(
                child: Image.network(
                  Glob.URL + serachList[index].poster,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
                footer: Container(
                  color: Colors.black45,
                  child: ListTile(
                    leading: Text(
                      serachList[index].title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    onTap: () {
                      _detailScreen(context, index, serachList);
                    },
                  ),
                ),
                header: Container(
                    margin: EdgeInsets.only(left: 130.0, right: 10.0),
                    alignment: Alignment.topRight,
                    color: Colors.amberAccent,
                    child: Consumer<NotifyChange>(builder: (context, data, child) {
                      return Align(
                        alignment: Alignment.center,
                        child: IconButton(
                            icon: ((_favoriteItemAdd.length != 0 &&
                                    _favoriteItemAdd.contains(
                                        serachList[index].id.toString())))
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : Icon(
                                    Icons.favorite_border,
                                  ),
                            color: Colors.black,
                            alignment: Alignment.centerRight,
                            onPressed: () {
                              if (_favoriteItemAdd.length == 0 ||
                                  (!_favoriteItemAdd.contains(
                                      serachList[index].id.toString()))) {
                               _favoriteItemAdd.add(serachList[index].id.toString());
                                data.addNotifier();

                                addIntToSF();
                                onSubmit(
                                    serachList[index].title,
                                    serachList[index].poster,
                                    serachList[index].id);
                                Fluttertoast.showToast(
                                  msg: "Favorite Movie Added",
                                );
                              } else if (_favoriteItemAdd
                                  .contains(serachList[index].id.toString())) {
                                _favoriteItemAdd
                                    .remove(serachList[index].id.toString());

                                data.addNotifier();
                                addIntToSF();
                                deleteMovieID(serachList[index].id);
                                Fluttertoast.showToast(
                                    msg: "Favorite Movie Removed");
                              }
                            }),
                      );
                    })),
              ),
            );
          }),
    );
  }

  void _detailScreen(BuildContext context, int index, List<Movie> tasks) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => detailscreen(
                  title: tasks[index].title,
                  backgroundImage: tasks[index].backGround,
                  overView: tasks[index].overview,
                  popularity: tasks[index].popularity,
                  language: tasks[index].language,
                  vote: tasks[index].vote,
                  releaseDate: tasks[index].releaseDate,
                  poster: tasks[index].poster,
                )));
  }

  addIntToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('movieID', _favoriteItemAdd);
  }

  getAllMovieID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return _favoriteItemAdd = prefs.getStringList("movieID");
  }

  //fave
  Future<void> onSubmit(title, poster, id) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('movie_database.db').build();
    var noteData = MovieEntity(title, poster, id);
    database.movieDao.insertFavoriteMovie(noteData);
  }

  Future<void> deleteMovieID(id) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('movie_database.db').build();
    database.movieDao.deleteParticularItem(id);
  }
}
