import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class detailscreen extends StatelessWidget {
  final String title, backgroundImage, overView, language, releaseDate, poster;
  final double popularity, vote;

  detailscreen(
      {@required this.title,
      this.backgroundImage,
      this.overView,
      this.popularity,
      this.vote,
      this.language,
      this.releaseDate,
      this.poster});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 240.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(title),
              background: _expandedImage(),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
                decoration: BoxDecoration(color: Colors.black87),
                child:  _posterImage(),

          ),)
        ],
      ),
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
