import 'package:douban_demo/home/home_model.dart';
import 'package:douban_demo/service/http_config.dart';
import 'package:douban_demo/service/http_request.dart';


class HomeRequest {
  static Future<List<MovieItem>> requestMovieList(int start) async {
    // 1.构建URL
    final movieURL = "/movie/top250?start=$start&count=${HomeConfig.movieCount}&apikey=0df993c66c0c636e29ecbb5344252a4a";

    // 2.发送网络请求获取结果
    final result = await HttpRequest.request(movieURL);
    final subjects = result["subjects"];

    // 3.将Map转成Model
    List<MovieItem> movies = [];
    for (var sub in subjects) {
      print(sub);
      movies.add(MovieItem.fromMap(sub));
    }

    return movies;
  }
}
