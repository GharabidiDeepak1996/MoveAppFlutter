import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class detailscreen extends StatelessWidget {
  final String title, backgroundImage, overView, language, releaseDate, poster;
  final double popularity, vote;

  detailscreen({@required this.title,
    this.backgroundImage,
    this.overView,
    this.popularity,
    this.vote,
    this.language,
    this.releaseDate,
    this.poster});

  @override
  Widget build(BuildContext context) {
    print('--------------hfbfhfh');
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            expandedHeight: 260.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(title),
              background: _expandedImage(),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: _posterImage(),
                    ),
                    _buildButtonColumn('Voting', vote.toString(),),
                    _buildButtonColumn('Language', language,),
                    _buildButtonColumn('ReleaseDate', releaseDate),
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Text(overView),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Column _buildButtonColumn(String label, String name) {
    return Column(

      children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),

        Container(
          child: Text(name, style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Colors.black

          ),),
        ),
      ],
    );
  }
  _expandedImage() {
    return Image.network(
      "https://image.tmdb.org/t/p/w500" + backgroundImage,
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
    );
  }

  _posterImage() {
    return Image.network(
      "https://image.tmdb.org/t/p/w500" + poster,
      scale: (4),
    );
  }
}
