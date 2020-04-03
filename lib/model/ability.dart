class Ability {
  bool update;
  bool destroy;
  bool create;
  bool read;
  Ability groupUser;
  Ability repo;
  Ability doc;

  Ability({this.update, this.destroy, this.create, this.read});

  Ability.fromJson(Map<String, dynamic> json) {
    update = json['update'];
    destroy = json['destroy'];
    create = json['create'];
    read = json['read'];
    groupUser = json['group_user'] != null
        ? new Ability.fromJson(json['group_user'])
        : null;
    repo = json['repo'] != null ? new Ability.fromJson(json['repo']) : null;
    doc = json['doc'] != null ? new Ability.fromJson(json['doc']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['update'] = this.update;
    data['destroy'] = this.destroy;
    data['create'] = this.create;
    data['read'] = this.read;
    if (this.groupUser != null) {
      data['group_user'] = this.groupUser.toJson();
    }
    if (this.repo != null) {
      data['repo'] = this.repo.toJson();
    }
    if (this.doc != null) {
      data['doc'] = this.doc.toJson();
    }
    return data;
  }
}
