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
  StreamController<Movie> controller = StreamController<Movie>.broadcast();

  List<String> favoriteItemAdd = new List();
  List<Movie> forSearch=new List();
var serachItem;

  @override
  void initState() {
    super.initState();

    getAllMovieID();
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
      body: Scrollbar(
        child: _listFutureTasks(context),
      ),
    );
  }

  //receive all movie list through provider and retrofit
  _listFutureTasks(BuildContext context) {
    return FutureBuilder<MoviesResp>(
      //listen =false because of we calling out side tree ---->more info :- https://www.youtube.com/watch?v=QT2LFIe794I
        future: Provider.of<RestClient>(context, listen: false).getPopularMovies(Glob.API_KEY, page),
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
            totalPage = snapshot.data.totalPage;
            totalItem = snapshot.data.totalResult;
            totalItemList = tasks.length;
            forSearch=tasks;
            return _listTasks(context: context, tasks: tasks);
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }



  _listTasks({BuildContext context, List<Movie> tasks}) {
    return GridView.builder(
        controller: _scrollController,
        itemCount: tasks.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.all(10.0),
            child: GridTile(
              child: Image.network(
                Glob.URL + tasks[index].poster,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
              footer: Container(
                color: Colors.black45,
                child: ListTile(
                  leading: Text(
                    tasks[index].title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  onTap: () {
                    _detailScreen(context, index, tasks);
                  },
                ),
              ),
              header: Container(
                margin: EdgeInsets.only(left: 150.0),
                color: Colors.amberAccent,
                child:
                 IconButton(
                    icon: (favoriteItemAdd.contains(tasks[index].id.toString())) ? Icon(Icons.favorite, color: Colors.red,) : Icon(Icons.favorite_border,),
                    color: Colors.black,
                    alignment: Alignment.centerRight,
                    onPressed: () {
                         print('kjdjfkds ksjdb-->${favoriteItemAdd.length}');
                      setState(() {
                        if((!favoriteItemAdd.contains(tasks[index].id.toString()))){
                          favoriteItemAdd.add(tasks[index].id.toString());
                           addIntToSF();
                           onSubmit(tasks[index].title,tasks[index].poster,tasks[index].id);
                           Fluttertoast.showToast(msg: "Favorite Movie Added",);
                        }else if(favoriteItemAdd.contains(tasks[index].id.toString())){
                          favoriteItemAdd.remove(tasks[index].id.toString());
                          addIntToSF();
                          deleteMovieID(tasks[index].id);
                          Fluttertoast.showToast(msg: "Favorite Movie Removed");
                        }
                      });
                    }),
              ),
            ),
          );

        });
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

  /*void _fliterMovie(value){
    setState(() {
      fliter = countries.where((country) => country.title.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }*/

  addIntToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('movieID', favoriteItemAdd);
  }

  getAllMovieID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    favoriteItemAdd = prefs.getStringList("movieID");
  }

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

  searchBarList(string){
    controller.add(string);
  }
}
