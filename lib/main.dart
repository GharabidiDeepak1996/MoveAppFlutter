import 'package:flutter/material.dart';
import 'package:fluttermoviesapp/screen/MainPersistentTabBar.dart';
import 'package:fluttermoviesapp/utils.dart';
import 'package:provider/provider.dart';
import 'network/api_call.dart';
import 'screen/movielist.dart';

void main() => runApp(MyApp()
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //we create instance of retrofit.
    return Provider<RestClient>(
        create: (context) => RestClient.create(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'demo movie',
          home: MainPersistentTabBar(),
          theme: ThemeData(
              primaryColor: Colors.green,
              accentColor: Colors.greenAccent
          ),
        )
    );
  }
}
