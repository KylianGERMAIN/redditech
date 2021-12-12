import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:ui';

class ProfileView extends StatefulWidget {
  ProfileView(
      {Key key, @required this.accessToken, @required this.refreshToken})
      : super(key: key);

  final String accessToken;
  final String refreshToken;

  @override
  ProfileViewState createState() => new ProfileViewState();
}

class ProfileViewState extends State<ProfileView> {
  String accessToken = "";
  String refreshToken = "";
  String name = "";
  String subscriber = "";
  String src = "";
  bool hidedowns;
  bool over_18;
  String lang = "";
  bool videoAutoplay;
  bool hideAds;
  bool enableFollowers;
  bool isSwitched = false;
  bool current = false;

  Widget _body = CircularProgressIndicator();

  @override
  getme() async {
    final response = await Dio().get(
      "https://oauth.reddit.com/api/v1/me",
      options: Options(headers: <String, dynamic>{
        'Authorization': 'Bearer $accessToken',
        'content-Type': 'application/x-www-form-urlencoded',
      }),
    );

    final responsePref = await Dio().get(
      "https://oauth.reddit.com/api/v1/me/prefs",
      options: Options(headers: <String, dynamic>{
        'Authorization': 'Bearer $accessToken',
        'content-Type': 'application/x-www-form-urlencoded',
      }),
    );

    Map<dynamic, dynamic> result = response.data;
    Map<String, dynamic> data = Map<String, dynamic>();
    for (dynamic type in result.keys) data[type.toString()] = result[type];

    Map<dynamic, dynamic> resultPref = responsePref.data;
    Map<String, dynamic> dataPref = Map<String, dynamic>();
    for (dynamic type in resultPref.keys)
      dataPref[type.toString()] = resultPref[type];

    setState(() {
      name = data['subreddit']['display_name'];
      subscriber = data['subreddit']['subscribers'].toString();
      src = data['subreddit']['icon_img'];
      hidedowns = dataPref['hide_downs'];
      over_18 = dataPref['over_18'];
      lang = dataPref['lang'];
      videoAutoplay = dataPref['video_autoplay'];
      enableFollowers = dataPref['enable_followers'];
      hideAds = dataPref['hide_ads'];
      current = true;
    });
  }

  @override
  void initState() {
    super.initState();
    accessToken = widget.accessToken;
    refreshToken = widget.refreshToken;
    getme();
  }

  static ProfileViewPicture(src) {
    return Container(
        child: ClipOval(
      child: Image.network(
        src,
        fit: BoxFit.fill,
        width: 256,
        height: 256,
      ),
    ));
  }

  // User's Pseudo
  static ProfileViewPseudo(name) {
    return Container(
        child: Center(
            child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            // Put the pseudo here
            "$name",
            style: TextStyle(
              color: Colors.grey[900],
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ))
      ],
    )));
  }

  // User's Status Online
  static ProfileViewStatusOnline() {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.values[0],
      children: [
        Container(
          decoration: ShapeDecoration(
              shape: Border.all(
                    color: Colors.white,
                    width: 8.0,
                  ) +
                  Border.all(
                    color: Colors.green,
                    width: 6.0,
                  )),
          child: const Text('Status : Online',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              )),
        )
      ],
    ));
  }

  // User's Description
  ProfileViewDescription() {
    return Container(
        child: Row(
      children: [
        SizedBox(width: 10.0),
        Text("Description :",
            style: TextStyle(
              color: Colors.grey[900],
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            )),
      ],
    ));
  }

  // User's Suscriber
  static ProfileViewSubscriber(subscriber) {
    return Container(
        child: Center(
            child: Row(
      children: [
        SizedBox(width: 15.0),
        Text("$subscriber Subscriber(s)",
            style: TextStyle(
              color: Colors.grey[900],
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ))
      ],
    )));
  }

  // User's Preference
  static ProfileViewPreference() {
    return Container(
        child: Row(
      children: [
        SizedBox(width: 10.0),
        Text("Preference :",
            style: TextStyle(
              color: Colors.grey[900],
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            )),
      ],
    ));
  }

  
  PreferenceOption(str) {
    return Container(
        child: Row(
      children: [
        SizedBox(width: 15.0),
        Text(str,
            style: TextStyle(
              color: Colors.grey[900],
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            )),
        Switch(
          value: isSwitched,
          onChanged: (bool value) {
            setState(() {
              isSwitched = value;
            });
          },
          activeTrackColor: Colors.lightGreenAccent,
          activeColor: Colors.green,
        ),
      ],
    ));
  }

  Widget build(BuildContext context) {
    return current == true ? Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
          children: [
            SizedBox(height: 70.0),
            ProfileViewPicture(src),
            SizedBox(height: 20.0),
            ProfileViewPseudo(name),
            SizedBox(height: 20.0),
            ProfileViewStatusOnline(),
            SizedBox(height: 30.0),
            ProfileViewDescription(),
            SizedBox(height: 15.0),
            ProfileViewSubscriber(subscriber),
            SizedBox(height: 30.0),
            ProfileViewPreference(),
            SizedBox(height: 15.0),
            Row(children: [
              PreferenceOption("Hide Downs : $hidedowns"),
              PreferenceOption("Over 18 : $over_18")
            ]),
            Row(children: [
              PreferenceOption("Language : $lang"),
              PreferenceOption("Video autoplay : $videoAutoplay"),
            ]),
            Row(children: [
              PreferenceOption("Hide ADS : $hideAds"),
              PreferenceOption("Enable Followers : $enableFollowers"),
            ]),
          ],
        ))) : _body;
  }
}
