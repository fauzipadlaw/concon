class SearchModel {
  bool? status;
  String? msg;
  Search? data;
  String? html;
  String? statusClass;
  String? type;
  String? postSearch;
  String? requestCounters;

  SearchModel(
      {status,
      msg,
      data,
      html,
      statusClass,
      type,
      postSearch,
      requestCounters});

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? Search.fromJson(json['data']) : null;
    html = json['html'];
    statusClass = json['statusClass'];
    type = json['type'];
    postSearch = json['post_data'];
    requestCounters = json['request_counters'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['html'] = html;
    data['statusClass'] = statusClass;
    data['type'] = type;
    data['post_data'] = postSearch;
    data['request_counters'] = requestCounters;
    return data;
  }
}

class Search {
  String? id;
  String? title;
  String? description;
  String? isProIsrael;
  String? isActive;
  String? totalHits;
  String? proHits;
  String? isUserSuggested;
  String? feedbackSource;

  Search({
    id,
    title,
    description,
    isProIsrael,
    isActive,
    totalHits,
    proHits,
    isUserSuggested,
    feedbackSource,
  });

  Search.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    title = json['title']?.toString();
    description = json['description']?.toString();
    isProIsrael = json['is_pro_israel']?.toString();
    isActive = json['is_active']?.toString();
    totalHits = json['total_hits']?.toString();
    proHits = json['pro_hits']?.toString();
    isUserSuggested = json['is_user_suggested']?.toString();
    feedbackSource = json['feedback_source']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['is_pro_israel'] = isProIsrael;
    data['is_active'] = isActive;
    data['total_hits'] = totalHits;
    data['pro_hits'] = proHits;
    data['is_user_suggested'] = isUserSuggested;
    data['feedback_source'] = feedbackSource;
    return data;
  }
}
