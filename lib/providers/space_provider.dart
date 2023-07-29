import 'dart:convert';

import 'package:bwa_cozy/models/space_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SpaceProvider extends ChangeNotifier {
  var url = Uri.parse('https://bwa-cozy-api.vercel.app/recommended-spaces');

  getRecommendedSpace() async {
    var result = await http.get(url);

    // Melihat Status Code
    print(result.statusCode);
    debugPrint(result.body);

    if (result.statusCode == 200) {
      List data = jsonDecode(result.body);
      List<SpaceModel> spaces =
          data.map((item) => SpaceModel.fromJson(item)).toList();
      return spaces;
    } else {
      return <SpaceModel>[];
    }
  }
}
