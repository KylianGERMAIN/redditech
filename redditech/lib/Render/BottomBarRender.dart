import 'package:flutter/material.dart';
import '../Request/GetSubreddit.dart';
import 'ProfileRender.dart';

class MyBottomBar extends StatefulWidget {
  MyBottomBar(
      {Key key, @required this.accessToken, @required this.refreshToken})
      : super(key: key);

  final String accessToken, refreshToken;

  @override
  State<MyBottomBar> createState() => BottomBar();
}

class BottomBar extends State<MyBottomBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    List<Widget> _widgetOptions = <Widget>[
      Scroll(accessToken: widget.accessToken, url:"https://oauth.reddit.com/new/"),
      Scroll1(widget.accessToken, "https://oauth.reddit.com/r/popular/"),
      Scroll2(widget.accessToken, "https://oauth.reddit.com/r/all/"),
      ProfileView(accessToken: widget.accessToken, refreshToken: widget.refreshToken)
    ];

      @override
  void initState() {
    super.initState();
  }

    void _onItemTapped(int index) async {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: new Theme(
    data: Theme.of(context).copyWith(
        canvasColor: Colors.grey[900],
        primaryColor: Colors.red,
        textTheme: Theme
            .of(context)
            .textTheme
            .copyWith(caption: new TextStyle(color: Colors.yellow))),
            child:
      BottomNavigationBar(
        backgroundColor: Colors.red[900],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'New',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Popular',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.all_out),
            label: 'All',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.portrait),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[500],
        onTap: _onItemTapped,
      ),
    ));
  }
}