import 'package:flutter/material.dart';
import 'package:factfulnews/drawer.dart';
import 'package:http/http.dart' as http;
import 'package:factfulnews/article.dart';
import 'package:factfulnews/articleViewer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:async';
import 'dart:convert';

void main() => runApp(MyApp());

//TODO: This entire function, it's what joins the frontend to the backend
Future<List<Article>> fetchArticles() async{
  final response = await http.get("https://factfulnews.herokuapp.com/all");//("http://10.13.73.136:5000/all");

  if(response.statusCode == 200) {
    List articles = json.decode(response.body);
    return articles.map((json) => new Article.fromJson(json)).toList();
  }
  else{
    throw Exception("Failed to load articles from backend http request!");
  }
  /*
  List<Article> articles = new List<Article>();
  articles.add(new Article(snippet: "Description", urlToImage: "https://sunnynagam.github.io/img/profile.jpg", index: 1, title: "An article1"));
  articles.add(new Article(snippet: "Description", urlToImage: "https://sunnynagam.github.io/img/profile.jpg", index: 2, title: "An article2"));
  articles.add(new Article(snippet: "In a shocking turn of events the judge of the infamous Nelson vs Road case sentenced himself to 10 years in solitary confinement when the defendant said \"No you.\"", urlToImage: "https://sunnynagam.github.io/img/profile.jpg", index: 3, title: "Judge to Serve 10 Years in Prison"));
  articles.add(new Article(snippet: "Description", urlToImage: "https://sunnynagam.github.io/img/profile.jpg", index: 4, title: "An article4"));
  articles.add(new Article(snippet: "Description", urlToImage: "https://sunnynagam.github.io/img/profile.jpg", index: 5, title: "An article5"));
  articles.add(new Article(snippet: "Description", urlToImage: "https://sunnynagam.github.io/img/profile.jpg", index: 6, title: "An article6"));
  articles.add(new Article(snippet: "Description", urlToImage: "https://sunnynagam.github.io/img/profile.jpg", index: 7, title: "An article7"));
  return articles;
  */
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FactfulNews',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(title: 'FactfulNews'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var listArticles;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState(){
    super.initState();
    refreshListArticles();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<List<Article>>(
            future: listArticles,
            builder: (context, snapshot){
              if(snapshot.hasError){
                print("Error: ${snapshot.error}");
                return Text('Error: ${snapshot.error}');
              }
              else if(snapshot.hasData){
                print("Snap has data");
                List<Article> articles = snapshot.data;
                print(articles[0].snippet);

                return new ListView(
                  children: articles.map((article)=> GestureDetector(
                    onTap: (){
                      // TODO: launch the article here
                      //FocusScope.of(context).requestFocus(FocusNode());
                      //_launchURL(article.index);

                      // Pop context on
                      final response = http.get("https://factfulnews.herokuapp.com/all/article?id=${article.index}");
                      response.then((response){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleView(response.body)),);
                      });

                    },
                    child: Card(
                        elevation: 1.0,
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5.0),
                              width: 100,
                              height: 140,
                              child: article.urlToImage==null?Text("Image Url Is Null"):Image.network(article.urlToImage),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(padding: EdgeInsets.only(top: 5)),
                                    Text(article.title, style: Theme.of(context).textTheme.title,),
                                    //Divider(color: Colors.black54,),
                                    Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                                    Text(
                                      article.snippet==null?"":article.snippet,
                                      style: Theme.of(context).textTheme.body1,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                    ),
                                    Padding(padding: EdgeInsets.only(bottom: 4)),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                    ),
                  )).toList(),
                );
              }

              return CircularProgressIndicator();
            },
          ),
      ),

    );
  }

  Future<Null> refreshListArticles(){
    refreshKey.currentState?.show(atTop: false);

    setState((){
      listArticles = fetchArticles();
    });

    return null;
  }

  _launchURL(int index) async {
    final response = await http.get("https://factfulnews.herokuapp.com/all/article?id=${index}");
    String url = response.body;
    if (await canLaunch(url)) {
      //await launch(url);
      Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx)  =>
            WebviewScaffold(
              initialChild: Center(child: CircularProgressIndicator(),),
              url: url,
              appBar: AppBar(title: Text(url)),
            ),
        ),
      );
    } else {
      throw 'Could not launch $url';
    }
  }

}

