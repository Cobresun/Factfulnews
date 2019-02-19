import 'package:flutter/material.dart';
import 'package:flutter_html_view/flutter_html_view.dart';
import 'package:http/http.dart' as http;

class ArticleView extends StatefulWidget {
  final String mainText;
  final String articleTitle;

  ArticleView(this.articleTitle, this.mainText);

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
    return Scaffold(
      body: Center(
            child: new HtmlView(data: widget.mainText),
      ),
      appBar: AppBar(
        title: Text(widget.articleTitle),
      ),

    );
  }
}