import 'package:lark/model/user.dart';

class BookDetail {
  int id;
  String type;
  String slug;
  String name;
  int userId;
  String description;
  String toc;
  String tocYml;
  int creatorId;
  int public;
  int itemsCount;
  int likesCount;
  int watchesCount;
  String pinnedAt;
  String archivedAt;
  String namespace;
  User user;
  String createdAt;
  String updatedAt;
  String sSerializer;

  BookDetail(
      {this.id,
      this.type,
      this.slug,
      this.name,
      this.userId,
      this.description,
      this.toc,
      this.tocYml,
      this.creatorId,
      this.public,
      this.itemsCount,
      this.likesCount,
      this.watchesCount,
      this.pinnedAt,
      this.archivedAt,
      this.namespace,
      this.user,
      this.createdAt,
      this.updatedAt,
      this.sSerializer});

  BookDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    slug = json['slug'];
    name = json['name'];
    userId = json['user_id'];
    description = json['description'];
    toc = json['toc'];
    tocYml = json['toc_yml'];
    creatorId = json['creator_id'];
    public = json['public'];
    itemsCount = json['items_count'];
    likesCount = json['likes_count'];
    watchesCount = json['watches_count'];
    pinnedAt = json['pinned_at'];
    archivedAt = json['archived_at'];
    namespace = json['namespace'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['toc'] = this.toc;
    data['toc_yml'] = this.tocYml;
    data['creator_id'] = this.creatorId;
    data['public'] = this.public;
    data['items_count'] = this.itemsCount;
    data['likes_count'] = this.likesCount;
    data['watches_count'] = this.watchesCount;
    data['pinned_at'] = this.pinnedAt;
    data['archived_at'] = this.archivedAt;
    data['namespace'] = this.namespace;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}
