import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:redditech/user.ini';
import 'dart:convert';
import '../Render/BottomBarRender.dart';
import 'package:dio/dio.dart';

class LoginToken extends StatefulWidget {
  LoginToken({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginToken createState() => _LoginToken();
}

class _LoginToken extends State<LoginToken> {
  void postCode(code) async {
    final id = base64.encode(utf8.encode(client_id + ':'));
    final response = await Dio().post(
        'https://www.reddit.com/api/v1/access_token',
        options: Options(headers: <String, dynamic>{
          'authorization': 'Basic $id',
          'content-type': "application/x-www-form-urlencoded"
        }),
        data: 'grant_type=authorization_code&code=$code&redirect_uri=$redirect_url');
     Navigator.push(context, MaterialPageRoute(builder: (context) => MyBottomBar(accessToken:response.data['access_token'], refreshToken:response.data['refresh_token'])),
    );
  }
  
  Widget build(BuildContext context) {
    return Container(
    child: 
       WebView(
        initialUrl: 'https://www.reddit.com/api/v1/authorize.compact?client_id=$client_id&response_type=code&state=test&redirect_uri=$redirect_url&duration=permanent&scope=identity,edit,flair,history,modconfig,modflair,modlog,modposts,modwiki,mysubreddits,privatemessages,read,report,save,submit,subscribe,vote,wikiedit,wikiread',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          controller = controller;
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith("http://localhost")) {
            var pos = request.url.lastIndexOf('=');
            var code = (pos != -1)
                ? request.url.substring(pos + 1, request.url.length - 2)
                : request.url;
            postCode(code);
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      )
    );
  }
}