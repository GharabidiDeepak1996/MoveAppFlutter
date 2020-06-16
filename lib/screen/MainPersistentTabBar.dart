import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttermoviesapp/provider.dart';
import 'package:fluttermoviesapp/screen/FavoriteMovie.dart';
import 'package:provider/provider.dart';

import 'movielist.dart';


// ignore: must_be_immutable
class MainPersistentTabBar extends StatelessWidget {
  bool isSearching = false;
  NotifyChange _notifySesrchButtonPress;

  @override
  Widget build(BuildContext context) {
    _notifySesrchButtonPress=Provider.of<NotifyChange>(context);
    isSearching=_notifySesrchButtonPress.isPress;

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
              var timerInfo = Provider.of<NotifyChange>( context, listen: false);
              timerInfo.searchNotifier(string);
            },
          ) : Text("Movies App"),
          actions: <Widget>[
            (isSearching) ? IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                var timerInfo = Provider.of<NotifyChange>( context, listen: false);
                timerInfo.isPressSearchButton(false);
              },
            )
                : IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                var timerInfo = Provider.of<NotifyChange>( context, listen: false);
                timerInfo.isPressSearchButton(true);
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
