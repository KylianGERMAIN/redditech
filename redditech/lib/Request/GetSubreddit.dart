import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../Render/PostTlRender.dart';
import 'dart:convert';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';

class Scroll1 extends StatelessWidget {
  Scroll1(this.accessToken, this.url);

  final String accessToken, url;
  @override
  Widget build(BuildContext context) {
    return Center(child: Scroll(accessToken: accessToken, url: url));
  }
}

class Scroll2 extends StatelessWidget {
  Scroll2(this.accessToken, this.url);

  final String accessToken, url;
  @override
  Widget build(BuildContext context) {
    return Center(child: Scroll(accessToken: accessToken, url: url));
  }
}

class Scroll extends StatefulWidget {
  Scroll({Key key, @required this.accessToken, @required this.url})
      : super(key: key);

  final String accessToken, url;

  ScrollState createState() => new ScrollState();
}

class ScrollState extends State<Scroll> {
  final ScrollController _scrollController = ScrollController();
  List<String> _data = [];
  List<String> _dataName = [];
  List<String> _dataUp = [];
  List<String> _dataCom = [];
  List<String> names = [];
  List<String> subtxt = [];
  List<String> subup = [];
  List<String> subcom = [];
  bool loading = false;
  bool allLoaded = false;
  String accessToken = "";
  String after = "";

  mockFretch(int nb) async {
    if (allLoaded) return;
    setState(() {
      loading = true;
    });
    await Future.delayed(Duration(milliseconds: 500));
    if (!mounted) return;
    List<String> newData =
        subtxt.length >= 100 ? [] : List.generate(nb, (index) => subtxt[index]);
    List<String> newDataName =
        names.length >= 100 ? [] : List.generate(nb, (index) => names[index]);
    List<String> newDataUp =
        subup.length >= 100 ? [] : List.generate(nb, (index) => subup[index]);
    List<String> newDataCom =
        subcom.length >= 100 ? [] : List.generate(nb, (index) => subcom[index]);
    if (newData.isNotEmpty) {
      _data.addAll(newData);
      _dataName.addAll(newDataName);
      _dataUp.addAll(newDataUp);
      _dataCom.addAll(newDataCom);
    }
    setState(() {
      loading = false;
      allLoaded = newData.isEmpty;
    });
  }

  getSubreddit() async {
    final response = await Dio().get(
      widget.url,
      options: Options(headers: <String, dynamic>{
        'Authorization': 'Bearer $accessToken',
        'content-Type': 'application/x-www-form-urlencoded',
      }),
      queryParameters: {
        'limit': '30',
        'after': after,
      },
    );
    if (!mounted) return;
    Map<dynamic, dynamic> result = response.data;
    setState(() {
    names = [];
    subtxt = [];
    subup = [];
    subcom = [];
    });
    for (dynamic type in result['data']['children']) {
      names.add(type['data']['subreddit']);
      subtxt.add(type['data']['title'] + "\n" + type['data']['selftext']);
      subup.add(NumberFormat.compact().format(type['data']['ups']).toString());
      subcom.add(NumberFormat.compact()
          .format(type['data']['num_comments'])
          .toString());
    }
    setState(() {
      after = result['data']['children'][29]['data']['name'];
    });
    mockFretch(30);
  }

  @override
  void initState() {
    super.initState();
    accessToken = widget.accessToken;
    getSubreddit();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !loading) {
        getSubreddit();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: LayoutBuilder(builder: (context, constaints) {
          if (_data.isNotEmpty) {
            return ListView.separated(
                controller: _scrollController,
                itemBuilder: (context, index) {
                  return ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                      title: (_data[index] != "null")
                          ? PostView.PostViewRender(_data[index],
                              _dataName[index], _dataUp[index], _dataCom[index])
                          : SizedBox.shrink());
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    thickness: 5,
                    color: Colors.black,
                    height: 0,
                  );
                },
                itemCount: _data.length);
          } else {
            return Container(
                child: Center(
              child: CircularProgressIndicator(),
            ));
          }
        }));
  }
}
