class SuggestionDataModel {
  bool? status;
  String? msg;
  List<SuggestionData>? data;
  String? html;

  SuggestionDataModel({status, msg, data, html});

  SuggestionDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <SuggestionData>[];
      json['data'].forEach((v) {
        data!.add(SuggestionData.fromJson(v));
      });
    }
    html = json['html'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = msg;
    data['data'] = this.data?.map((v) => v.toJson()).toList();
    data['html'] = html;
    return data;
  }
}

class SuggestionData {
  String? title;

  SuggestionData({title});

  SuggestionData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    return data;
  }
}
