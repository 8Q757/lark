class Result {
  bool flag;
  String code;
  String msg;
  String data;

  Result({this.flag, this.code, this.msg, this.data});

  Result.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    code = json['code'];
    msg = json['msg'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flag'] = this.flag;
    data['code'] = this.code;
    data['msg'] = this.msg;
    data['data'] = this.data;
    return data;
  }
}
