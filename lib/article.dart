class Article{
  final String title;
  final String snippet;
  final int index;
  final String urlToImage;
  final String url;
  
  Article({this.title, this.snippet, this.index, this.urlToImage, this.url});

  factory Article.fromJson(Map<String, dynamic> json){
    return Article(
        title: json["title"],
        snippet: json["snippet"],
        index: json["index"],
        urlToImage: json["urlToImage"],
        url: json["url"]
    );
  }

}