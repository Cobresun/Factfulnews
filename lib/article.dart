class Article{
  final String title;
  final String snippet;
  final int index;
  final String urlToImage;
  
  Article({this.title, this.snippet, this.index, this.urlToImage});

  factory Article.fromJson(Map<String, dynamic> json){
    return Article(
        title: json["title"],
        snippet: json["snippet"],
        index: json["index"],
        urlToImage: json["urlToImage"]
    );
  }

}