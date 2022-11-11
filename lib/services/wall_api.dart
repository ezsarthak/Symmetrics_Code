import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/wall_model.dart';

class WallApi {
  static Future<List<WallModel>> getPhotos() async {
    const wallUrl = 'https://raw.githubusercontent.com/sarcasmic128/json/main/main.json';
    final response = await http.get(Uri.parse(wallUrl));
    // debugPrint("URL: ${Uri.encodeFull(wallUrl)}");


    if (response.statusCode == 200) {
      debugPrint('Response Code : ${response.statusCode}');
      // debugPrint('Wall Data: $data');
      final List wallsList = json.decode(response.body);
      return wallsList.map((json) => WallModel.fromJson(json)).toList();
    } else {
      debugPrint('Response Code : ${response.statusCode}');
      throw Exception('Failed to load data');
    }
  }
}

