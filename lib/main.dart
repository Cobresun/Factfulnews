import 'package:flutter/material.dart';
import 'package:factfulnews/drawer.dart';
import 'package:factfulnews/article.dart';
import 'dart:async';
import 'dart:convert';

void main() => runApp(MyApp());

//TODO: This entire function, it's what joins the frontend to the backend
Future<List<Article>> fetchArticles(BuildContext context) async{    //TODO: remove oontext
  print("hi lol");
  /*
  String jsonStr = await DefaultAssetBundle.of(context).loadString("all.json");
  print(jsonStr);
  List articles = json.decode(jsonStr)["articles"];
  return articles.map((json) => new Article.fromJson(json)).toList();
  */
  List<Article> articles = new List<Article>();
  articles.add(new Article(sourceName: "cnn.com", sourceId: "23jf94", content: "Content.", publishDate: "2019-01-22T21:56:00Z", description: "Description", author: "Steve", imgSrc: "https://sunnynagam.github.io/img/profile.jpg", url: "https://sunnynagam.github.io/", title: "An article1"));
  articles.add(new Article(sourceName: "cnn.com", sourceId: "23jf94", content: "Content.", publishDate: "2019-01-22T21:56:00Z", description: "Description", author: "Steve", imgSrc: "https://sunnynagam.github.io/img/profile.jpg", url: "https://sunnynagam.github.io/", title: "An article2"));
  articles.add(new Article(sourceName: "cnn.com", sourceId: "23jf94", content: "Content.", publishDate: "2019-01-22T21:56:00Z", description: "Description", author: "Steve", imgSrc: "https://sunnynagam.github.io/img/profile.jpg", url: "https://sunnynagam.github.io/", title: "An article3"));
  articles.add(new Article(sourceName: "cnn.com", sourceId: "23jf94", content: "Content.", publishDate: "2019-01-22T21:56:00Z", description: "Description", author: "Steve", imgSrc: "https://sunnynagam.github.io/img/profile.jpg", url: "https://sunnynagam.github.io/", title: "An article4"));
  return articles;
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
        primarySwatch: Colors.blue,
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
        child: RefreshIndicator(
          key: refreshKey,
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
                print(articles[0].title);

                return new ListView(
                  children: articles.map((article)=> GestureDetector(
                    onTap: (){
                      // TODO: launch the article here
                    },
                    child: Card(
                      elevation: 1.0,
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2.0),
                            width: 100,
                            height: 140,
                            child: Image.network(article.imgSrc),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(padding: EdgeInsets.symmetric(vertical:3)),
                                Text(article.title, style: Theme.of(context).textTheme.title,),
                                Text(article.publishDate, style: Theme.of(context).textTheme.body1,),
                                Padding(padding: EdgeInsets.symmetric(vertical: 8),),
                                Text(article.description, style: Theme.of(context).textTheme.body2,),
                              ],
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
          onRefresh: refreshListArticles,
        ),
      ),

      drawer: drawer,       // This is the hamburger menu on the right, it's defined in it's own file
    );
  }

  Future<Null> refreshListArticles(){
    refreshKey.currentState?.show(atTop: false);

    setState((){
      listArticles = fetchArticles(context);
    });

    return null;
  }
}

