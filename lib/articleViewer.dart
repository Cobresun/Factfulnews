import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ArticleView extends StatefulWidget {
  final String mainText;

  ArticleView(this.mainText);

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView>{
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // "Unmount" the controllers:
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String text = widget.mainText;

    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 5),),
              Text(text),
            ],
          ),

        )

    );
  }
}