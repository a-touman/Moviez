import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  String hostName;
  String apiPath;
  Map<String, String>? query;
  Map<String, String> headers;

  NetworkHelper(
      {required this.hostName,
      required this.apiPath,
      this.query,
      required this.headers});

  Future getData() async {
    var uri = query != null
        ? Uri.https(hostName, apiPath, query)
        : Uri.https(hostName, apiPath);

    final http.Response response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      String data = response.body;

      print(" ");
      // print(data);

      var decodedData = jsonDecode(data);

      return decodedData;
    } else {
      print(response.statusCode);
    }
  }
} //end of class
