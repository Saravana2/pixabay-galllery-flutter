import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'model/ImageResponse.dart';
const API_KEY = "YOUR_API_TOKEN";
const BASE_URL = "https://pixabay.com/api/";
const KEY = "key="+API_KEY;
const TYPE_PHOTO = "&image_type=photo";
const PAGE_NUMBER = "&page=";

enum LoadMoreStatus { LOADING, STABLE, END }

class APIHelper{
  int pageCount = 1;

  Future<ImageResponse> fetchImages(String queryText) async {
    String queryParams = KEY;
    if (queryText != null && queryText != "") {
      queryParams = queryParams + "&q=" + queryText;
    }
    queryParams = queryParams + TYPE_PHOTO + PAGE_NUMBER + pageCount.toString();

    String url = BASE_URL + "?" + queryParams;
    print(url);
    http.Response response = await http.get(url);
    return compute(parseImages, response.body);
  }

}

ImageResponse parseImages(String responseBody) {
  final Map imageMap = JsonCodec().decode(responseBody);
  print(imageMap);
  ImageResponse imageResponse = ImageResponse.fromJson(imageMap);
  if (imageResponse == null) {
    throw new FormatException("Server not connected");
  }
  return imageResponse;
}