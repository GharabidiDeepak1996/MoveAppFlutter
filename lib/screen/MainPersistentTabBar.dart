import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttermoviesapp/screen/DetailScreen.dart';
import 'package:fluttermoviesapp/screen/FavoriteMovie.dart';

import 'movielist.dart';


class MainPersistentTabBar extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return _MainPersistentTabBar();
  }
}
class _MainPersistentTabBar extends State<MainPersistentTabBar> {
  bool isSearching = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: (isSearching) ? TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      hintText: 'Search Movies',
                      hintStyle: TextStyle(color: Colors.white)),
                  onChanged: (string) {
                    HomeListState().searchBarList(string);
             },
                ) : Text("Movies App"),
          actions: <Widget>[
            (isSearching) ? IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                setState(() {
                  this.isSearching = false;
                });
              },
            )
                : IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  this.isSearching = true;
                });
              },
            )
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Movies",
              ),
              Tab(text: "Fav"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Homelist(),
            FavoMovie(),
          ],
        ),
      ),
    );
  }


}
