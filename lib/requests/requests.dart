import 'dart:convert';

import 'package:concon/models/search.dart';
import 'package:concon/models/suggestion.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://bdnaash.com/home';
Map<String, String> headers = {
  "Accept": "application/json, text/javascript, */*; q=0.01",
  "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
  "X-Requested-With": "XMLHttpRequest",
};
Future<SuggestionDataModel?> getSuggestions(String query) async {
  if (query.trim() == '') return null;
  try {
    Uri uri = Uri.parse('$baseUrl/searchSuggestions');
    var response =
        await http.post(uri, headers: headers, body: {"query": query});
    if (response.statusCode == 200) {
      return SuggestionDataModel.fromJson(jsonDecode(response.body));
    }
    return null;
  } catch (e) {
    return null;
  }
}

Future<SearchModel?> getBrandStatus(String query, String type) async {
  if (query.trim() == '') return null;
  try {
    Uri uri = Uri.parse('$baseUrl/search');
    var response = await http
        .post(uri, headers: headers, body: {"query": query, "type": type});
    if (response.statusCode == 200) {
      return SearchModel.fromJson(jsonDecode(response.body));
    }
    return null;
  } catch (e) {
    return null;
  }
}
