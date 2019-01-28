class Article{
  final String title;
  final String snippet;
  final String id;
  final String urlToImage;
  
  Article({this.title, this.snippet, this.id, this.urlToImage});

  factory Article.fromJson(Map<String, dynamic> json){
    return Article(
        title: json["title"],
        snippet: json["snippet"],
        id: json["id"],
        urlToImage: json["urlToImage"]
    );
  }

}