import 'book.dart';
import 'user.dart';

class Doc {
  int id;
  int spaceId;
  String type;
  String subType;
  String title;
  String titleDraft;
  String tag;
  String slug;
  int userId;
  int bookId;
  int lastEditorId;
  String cover;
  String description;
  String customDescription;
  String format;
  int status;
  int readStatus;
  int viewStatus;
  int public;
  int draftVersion;
  int commentsCount;
  int likesCount;
  String contentUpdatedAt;
  String createdAt;
  String updatedAt;
  String publishedAt;
  String firstPublishedAt;
  int wordCount;
  String selectedAt;
  String pinnedAt;
  Book book;
  User user;
  User lastEditor;
  String share;
  bool isPreimum;
  String sSerializer;

  Doc(
      {this.id,
      this.spaceId,
      this.type,
      this.subType,
      this.title,
      this.titleDraft,
      this.tag,
      this.slug,
      this.userId,
      this.bookId,
      this.lastEditorId,
      this.cover,
      this.description,
      this.customDescription,
      this.format,
      this.status,
      this.readStatus,
      this.viewStatus,
      this.public,
      this.draftVersion,
      this.commentsCount,
      this.likesCount,
      this.contentUpdatedAt,
      this.createdAt,
      this.updatedAt,
      this.publishedAt,
      this.firstPublishedAt,
      this.wordCount,
      this.selectedAt,
      this.pinnedAt,
      this.book,
      this.user,
      this.lastEditor,
      this.share,
      this.isPreimum,
      this.sSerializer});

  Doc.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    spaceId = json['space_id'];
    type = json['type'];
    subType = json['sub_type'];
    title = json['title'];
    titleDraft = json['title_draft'];
    tag = json['tag'];
    slug = json['slug'];
    userId = json['user_id'];
    bookId = json['book_id'];
    lastEditorId = json['last_editor_id'];
    cover = json['cover'];
    description = json['description'];
    customDescription = json['custom_description'];
    format = json['format'];
    status = json['status'];
    readStatus = json['read_status'];
    viewStatus = json['view_status'];
    public = json['public'];
    draftVersion = json['draft_version'];
    commentsCount = json['comments_count'];
    likesCount = json['likes_count'];
    contentUpdatedAt = json['content_updated_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    publishedAt = json['published_at'];
    firstPublishedAt = json['first_published_at'];
    wordCount = json['word_count'];
    selectedAt = json['selected_at'];
    pinnedAt = json['pinned_at'];
    book = json['book'] != null ? new Book.fromJson(json['book']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    lastEditor = json['lastEditor'] != null
        ? new User.fromJson(json['lastEditor'])
        : null;
    share = json['share'];
    isPreimum = json['isPreimum'];
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['space_id'] = this.spaceId;
    data['type'] = this.type;
    data['sub_type'] = this.subType;
    data['title'] = this.title;
    data['title_draft'] = this.titleDraft;
    data['tag'] = this.tag;
    data['slug'] = this.slug;
    data['user_id'] = this.userId;
    data['book_id'] = this.bookId;
    data['last_editor_id'] = this.lastEditorId;
    data['cover'] = this.cover;
    data['description'] = this.description;
    data['custom_description'] = this.customDescription;
    data['format'] = this.format;
    data['status'] = this.status;
    data['read_status'] = this.readStatus;
    data['view_status'] = this.viewStatus;
    data['public'] = this.public;
    data['draft_version'] = this.draftVersion;
    data['comments_count'] = this.commentsCount;
    data['likes_count'] = this.likesCount;
    data['content_updated_at'] = this.contentUpdatedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['published_at'] = this.publishedAt;
    data['first_published_at'] = this.firstPublishedAt;
    data['word_count'] = this.wordCount;
    data['selected_at'] = this.selectedAt;
    data['pinned_at'] = this.pinnedAt;
    if (this.book != null) {
      data['book'] = this.book.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.user != null) {
      data['last_editor'] = this.user.toJson();
    }
    data['share'] = this.share;
    data['isPreimum'] = this.isPreimum;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}
