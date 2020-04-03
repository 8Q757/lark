import 'book.dart';
import 'user.dart';

class DocDetail {
  int id;
  String slug;
  String title;
  int bookId;
  Book book;
  int userId;
  User creator;
  String format;
  String body;
  String bodyDraft;
  String bodyHtml;
  String bodyLake;
  String bodyDraftLake;
  int public;
  int status;
  int viewStatus;
  int readStatus;
  int likesCount;
  int commentsCount;
  String contentUpdatedAt;
  String deletedAt;
  String createdAt;
  String updatedAt;
  String publishedAt;
  String firstPublishedAt;
  int wordCount;
  String cover;
  String description;
  String customDescription;
  String sSerializer;

  DocDetail(
      {this.id,
      this.slug,
      this.title,
      this.bookId,
      this.book,
      this.userId,
      this.creator,
      this.format,
      this.body,
      this.bodyDraft,
      this.bodyHtml,
      this.bodyLake,
      this.bodyDraftLake,
      this.public,
      this.status,
      this.viewStatus,
      this.readStatus,
      this.likesCount,
      this.commentsCount,
      this.contentUpdatedAt,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.publishedAt,
      this.firstPublishedAt,
      this.wordCount,
      this.cover,
      this.description,
      this.customDescription,
      this.sSerializer});

  DocDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    bookId = json['book_id'];
    book = json['book'] != null ? new Book.fromJson(json['book']) : null;
    userId = json['user_id'];
    creator =
        json['creator'] != null ? new User.fromJson(json['creator']) : null;
    format = json['format'];
    body = json['body'];
    bodyDraft = json['body_draft'];
    bodyHtml = json['body_html'];
    bodyLake = json['body_lake'];
    bodyDraftLake = json['body_draft_lake'];
    public = json['public'];
    status = json['status'];
    viewStatus = json['view_status'];
    readStatus = json['read_status'];
    likesCount = json['likes_count'];
    commentsCount = json['comments_count'];
    contentUpdatedAt = json['content_updated_at'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    publishedAt = json['published_at'];
    firstPublishedAt = json['first_published_at'];
    wordCount = json['word_count'];
    cover = json['cover'];
    description = json['description'];
    customDescription = json['custom_description'];
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['title'] = this.title;
    data['book_id'] = this.bookId;
    if (this.book != null) {
      data['book'] = this.book.toJson();
    }
    data['user_id'] = this.userId;
    if (this.creator != null) {
      data['creator'] = this.creator.toJson();
    }
    data['format'] = this.format;
    data['body'] = this.body;
    data['body_draft'] = this.bodyDraft;
    data['body_html'] = this.bodyHtml;
    data['body_lake'] = this.bodyLake;
    data['body_draft_lake'] = this.bodyDraftLake;
    data['public'] = this.public;
    data['status'] = this.status;
    data['view_status'] = this.viewStatus;
    data['read_status'] = this.readStatus;
    data['likes_count'] = this.likesCount;
    data['comments_count'] = this.commentsCount;
    data['content_updated_at'] = this.contentUpdatedAt;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['published_at'] = this.publishedAt;
    data['first_published_at'] = this.firstPublishedAt;
    data['word_count'] = this.wordCount;
    data['cover'] = this.cover;
    data['description'] = this.description;
    data['custom_description'] = this.customDescription;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}
