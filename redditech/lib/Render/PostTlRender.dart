import 'package:flutter/material.dart';

class PostView {
  static button(String _databtn, Icon icon) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.grey[900],
        elevation: 0.0,
      ),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_databtn),
          SizedBox(width: 1.0),
          icon,
        ],
      ),
    );
  }

  static titleAvatar(String nameSub, String linkImg) {
    return Container(
      margin: new EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          Text(nameSub,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black,
              ))
        ],
      ),
    );
  }

  static content(String data) {
    return Container(
      margin: new EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          SizedBox(height: 10.0),
          Column(
              children: [
                Text(data,
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                SizedBox(height: 10.0),
              ]
            )
        ],
      )
    );
  }

  static barButton(String dataUp, String dataCom) {
    return Container(
      margin: new EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50, width: 100,
              child: button(dataUp, const Icon(Icons.arrow_upward, size: 30.0))),
          SizedBox(width: 5.0),
          SizedBox(height: 50,width: 100,
              child: button(dataCom, const Icon(Icons.comment_bank_sharp, size: 30.0))),
        ],
      )
    );
  }

  static PostViewRender(String data, String dataName, String Up, String Com) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            titleAvatar(dataName, "https://source.unsplash.com/50x50/?portrait"),
            content(data),
            barButton(Up, Com)
          ],
        ));
  }
}
