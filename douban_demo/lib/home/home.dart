import 'package:flutter/material.dart';

import 'package:douban_demo/service/home_request.dart';
import 'home_movie_item.dart';
import 'home_model.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: HomeContent(),
    );
  }
}

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {

  final List<MovieItem> movies = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 发送网络请求
    HomeRequest.requestMovieList(0).then((res){
      setState(() {
        movies.addAll(res);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          return HomeMovieItem(movies[index]);
        }
    );
  }
}




