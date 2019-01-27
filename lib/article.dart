class Article{
  final String title;
  final String author;
  final String description;

  final String url;
  final String imgSrc;
  final String publishDate;   // TODO: make this a DateTime not a String

  final String content;

  final String sourceId;
  final String sourceName;
  
  Article({this.title, this.author, this.description, this.url, this.imgSrc, this.publishDate, this.content, this.sourceId, this.sourceName});

  factory Article.fromJson(Map<String, dynamic> json){
    return Article(
      title: json["title"],
      author: json["author"],
      description: json["description"],
      url: json["url"],
      imgSrc: json["urlToImage"],
      publishDate: json["publishedAt"],
      content: json["content"],
      sourceId: json["source"]["id"],
      sourceName: json["source"]["name"]
    );
  }

}