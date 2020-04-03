import 'package:lark/model/user.dart';

class Book {
  int id;
  String type;
  String slug;
  String name;
  int userId;
  String description;
  int creatorId;
  int public;
  int itemsCount;
  int likesCount;
  int watchesCount;
  String contentUpdatedAt;
  String updatedAt;
  String createdAt;
  String namespace;
  User user;
  String sSerializer;

  Book(
      {this.id,
      this.type,
      this.slug,
      this.name,
      this.userId,
      this.description,
      this.creatorId,
      this.public,
      this.itemsCount,
      this.likesCount,
      this.watchesCount,
      this.contentUpdatedAt,
      this.updatedAt,
      this.createdAt,
      this.namespace,
      this.user,
      this.sSerializer});

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    slug = json['slug'];
    name = json['name'];
    userId = json['user_id'];
    description = json['description'];
    creatorId = json['creator_id'];
    public = json['public'];
    itemsCount = json['items_count'];
    likesCount = json['likes_count'];
    watchesCount = json['watches_count'];
    contentUpdatedAt = json['content_updated_at'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    namespace = json['namespace'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['slug'] = this.slug;
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['description'] = this.description;
    data['creator_id'] = this.creatorId;
    data['public'] = this.public;
    data['items_count'] = this.itemsCount;
    data['likes_count'] = this.likesCount;
    data['watches_count'] = this.watchesCount;
    data['content_updated_at'] = this.contentUpdatedAt;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['namespace'] = this.namespace;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['_serializer'] = this.sSerializer;
    return data;
  }
}
