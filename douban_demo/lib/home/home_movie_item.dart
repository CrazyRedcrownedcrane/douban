import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:douban_demo/home/home_model.dart';
import 'package:douban_demo/utils/log.dart';
import 'package:douban_demo/widgets/star_rating.dart';
import 'package:douban_demo/widgets/dashed_line.dart';

class HomeMovieItem extends StatefulWidget {
  final MovieItem movie;

  HomeMovieItem(this.movie);

  @override
  _HomeMovieItemState createState() => _HomeMovieItemState();
}

class _HomeMovieItemState extends State<HomeMovieItem> {
  TapGestureRecognizer _tapGestureRecognizer = new TapGestureRecognizer();

  bool _toggle = false;
  @override
  void dispose() {
    //用到GestureRecognizer的话一定要调用其dispose方法释放资源
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 260,
      decoration: BoxDecoration(
          border:
          Border(
              bottom: BorderSide(
                  width: 8,
                  color: Color(0xffcccccc)
              )
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          getRank(),
          SizedBox(
            height: 8,
          ),
          buildContent(),
          SizedBox(
            height: 8,
          ),
          buildFooter(),
        ],
      ),
    );
  }

  Widget buildContent() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          getRankMovieIcon(),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: IntrinsicHeight(
              child: Row(
                children: <Widget>[
                  getContentInfo(),
                  SizedBox(
                    width: 8,
                  ),
                  buildContentLine(),
                  SizedBox(
                    width: 8,
                  ),
                  buildContentWish()
                ],
              ),
            ),
          ),
        ],
      );
  }

  Widget getRank() {
    final num ranking = 1;
    return Container(
      width: 60,
      height: 20,
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.all(new Radius.circular(3.0)),
        color: Colors.orangeAccent,
      ),
      child: Text("No.${widget.movie.rank}",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize:16,
            color: Colors.white
        ),
      ),
    );
  }

  Widget getRankMovieIcon() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(widget.movie.imageURL, height: 150),
    );
  }

  Widget getContentInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          getContentInnerTitle(),
          SizedBox(
            height: 8,
          ),
          getContentInfoRate(),
          SizedBox(
            height: 8,
          ),
          getContentInfoDesc()
        ],
      ),
    );
  }

  Widget getContentInnerTitle() {
    return RichText(
        text: TextSpan(
          children: [
            WidgetSpan(
                child: Icon(
                  Icons.play_circle_outline,
                  color: Colors.yellow,
                  size: 30,
                ),
                alignment: PlaceholderAlignment.middle
            ),
            TextSpan(
              children: [
                TextSpan(
                  text: widget.movie.title,
                  style: TextStyle(fontSize: 18, color: _toggle ? Color(0xff333333) : Colors.red),
                  recognizer: _tapGestureRecognizer
                  ..onTap = () {
                    setState(() {
                      _toggle = !_toggle;
                    });
                  },
                ),
                TextSpan(
                  text: "(${widget.movie.playDate})",
                  style: TextStyle(color: Colors.grey, fontSize: 16)
                )
              ],
            ),
          ],
        )
    );
  }

  Widget getContentInfoRate() {
    return Row(
      children: <Widget>[
        HYStarRating(
          rating: widget.movie.rating,
          size: 20,
        ),
        SizedBox(
          width: 6,
        ),
        Text(
          "${widget.movie.rating}",
          style: TextStyle(fontSize: 16),
        )
      ],
    );
  }

  Widget getContentInfoDesc() {
    // 1.字符串拼接
    final genresString = widget.movie.genres.join(" ");
    final directorString = widget.movie.director.name;
    List<Actor> casts = widget.movie.casts;
    final actorString = widget.movie.casts.map((item) => item.name).join(" ");

    return Text(
      "$genresString / $directorString / $actorString",
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 16),
    );
  }

  Widget buildContentLine() {
    return Container(
//      height: 100,
      child: HYDashedLine(
        axis: Axis.vertical,
        dashedWidth: .4,
        dashedHeight: 6,
        count: 10,
        color: Colors.pink,
      ),
    );
  }

  Widget buildContentWish() {
    return Container(
//      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("assets/images/home/wish.png"),
          Text(
            "想看",
            style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 235, 170, 60)
            ),
          )
        ],
      ),
    );
  }

  Widget buildFooter() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xfff2f2f2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        widget.movie.originalTitle,
        style: TextStyle(fontSize: 20, color: Color(0xff666666)),
      ),
    );
  }
}

