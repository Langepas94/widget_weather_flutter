import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class FetchHelper {
  final String url;
  FetchHelper(this.url);

  Future<dynamic> getData() async {
    var urlik = Uri.https(url);
    Response response = await get(urlik);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}