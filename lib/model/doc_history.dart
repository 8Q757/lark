class DocHistory {
  int id;
  int bookId;
  String title;
  String description;

  DocHistory({this.id, this.title, this.description});

  DocHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookId = json['bookId'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bookId'] = this.bookId;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }

  @override
  bool operator ==(other) {
    if (other is! DocHistory) {
      return false;
    }
    final DocHistory docHistory = other;
    return id == docHistory.id && bookId == docHistory.bookId;
  }
}
