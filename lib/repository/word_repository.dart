import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:my_dict/model/response_model.dart';
import 'package:my_dict/service/http_service.dart';

class WordRepository {
  Future<dynamic> getWord(String word) async {
    Response response = await HttpService.getRequest('v2/entries/en_US/$word');

    try {
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);

        var decoded = ResponseModel.fromJson(json.first);

        return decoded;
      }
    } catch (e) {
      //TODO: testar se identifica queda de internet.
      throw e.toString();
    }

    return null;
  }
}
