import 'package:flutter/material.dart';
import 'package:douban_demo/home/home.dart';
import 'package:douban_demo/group/group.dart';
import 'package:douban_demo/mall/mall.dart';
import 'package:douban_demo/profile/profile.dart';
import 'package:douban_demo/subject/subject.dart';

var _currentIndex = 0;
List<String> _titles = ["首页","书影音","小组","市集","我的"];
List<String> _icons = ["home","subject","group","mall","profile"];

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green
      ),
      home: AppHome(),
    );
  }
}

class AppHome extends StatefulWidget {
  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 16,
          unselectedFontSize: 14,
          currentIndex: _currentIndex,
          items: createBottomNavigation(),
          onTap: (index){
            setState(() {
              _currentIndex = index;
            });
          },
      ),
      body: AppBody(),
    );
  }
}

List<BottomNavigationBarItem> createBottomNavigation() {
  List<BottomNavigationBarItem> items = [];
  for (var title in _titles){
    var index = _titles.indexOf(title);
    BottomNavigationBarItem item = createItem(_icons[index], title);
    items.add(item);
  }
  return items;
}

BottomNavigationBarItem createItem(String iconName, String title) {
  return BottomNavigationBarItem(
      icon: Image.asset("assets/images/tabbar/$iconName.png", width: 30,),
      activeIcon: Image.asset("assets/images/tabbar/${iconName}_active.png", width: 30,),
      title: Text(title)
  );
}

class AppBody extends StatefulWidget {
  @override
  _AppBodyState createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _currentIndex,
      children: <Widget>[
        Home(),
        Subject(),
        Group(),
        Mall(),
        Profile()
      ],
    );
  }
}


