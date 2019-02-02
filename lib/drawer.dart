import 'package:flutter/material.dart';

Drawer drawer = new Drawer(
  child: ListView(
    children: <Widget>[
      ListTile(
        title: Text("Page 1"),
        onTap: () => {
          // Switch pages here
        },
      ),
      ListTile(
        title: Text("Page 2"),
      ),
      Align(
        alignment: AlignmentDirectional.bottomCenter,
        child: Container(
          //alignment: AlignmentDirectional.center,
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text("Powered By NewsAPI.org"),
        ),
      )
    ],
  ),
);