import 'package:http/http.dart';

class HttpService {
  static final baseUrl = 'https://api.dictionaryapi.dev/api/';

  static Future<Response> getRequest(endPoint) async {
    Response response;

    final url = Uri.parse('$baseUrl$endPoint');
    try {
      response = await get(url);
      return response;
    } on Exception catch (e) {
      throw e;
    }
  }
}
