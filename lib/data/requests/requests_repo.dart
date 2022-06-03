import 'dart:convert';
import 'package:dd_flickr_test/base/app_constants.dart';
import 'package:dd_flickr_test/data/models/unsplash_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class RequestsRepo {
  Future<List<UnsplashResults>> getPhotoCollectionList(
      int page, int perPage) async {
    List<UnsplashResults> _listMap = [];
    String url = AppConstants.unsplashApiLink + 'page=$page&per_page=$perPage';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      var _results = UnsplashModel.fromJson(data).results;
      if (_results != null) {
        for (int i = 0; i < _results.length; i++) {
          _listMap.add(_results[i]);
        }
      }
    }
    return _listMap;
  }
}
