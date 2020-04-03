class User {
  int id;
  String type;
  String login;
  String name;
  String description;
  String avatarUrl;
  int booksCount;
  int publicBooksCount;
  int followersCount;
  int followingCount;
  String createdAt;
  String updatedAt;
  String sSerializer;

  User(
      {this.id,
      this.type,
      this.login,
      this.name,
      this.description,
      this.avatarUrl,
      this.booksCount,
      this.publicBooksCount,
      this.followersCount,
      this.followingCount,
      this.createdAt,
      this.updatedAt,
      this.sSerializer});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    login = json['login'];
    name = json['name'];
    description = json['description'];
    avatarUrl = json['avatar_url'];
    booksCount = json['books_count'];
    publicBooksCount = json['public_books_count'];
    followersCount = json['followers_count'];
    followingCount = json['following_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['login'] = this.login;
    data['name'] = this.name;
    data['description'] = this.description;
    data['avatar_url'] = this.avatarUrl;
    data['books_count'] = this.booksCount;
    data['public_books_count'] = this.publicBooksCount;
    data['followers_count'] = this.followersCount;
    data['following_count'] = this.followingCount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}
