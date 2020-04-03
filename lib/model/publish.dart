class Publish {
  String title;
  String slug;
  int public;
  String format;
  String body;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['public'] = this.public;
    data['format'] = this.format;
    data['body'] = this.body;
    return data;
  }
}
