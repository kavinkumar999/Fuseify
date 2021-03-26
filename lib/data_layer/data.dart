import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;

class Endpoint {
  // var keye = Process.data.url;
  final String url = "http://10.0.2.2:8002/api/method/postal_hub.postal_hub.doctype.postal_post.postal_post";
  var key = "token 1d2c48f45385e2e:a6e278617a87b81";

  Future<void> uploaddata(String byte, String imagename, String doc) async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': key
    };
    var request = http.Request(
        'POST', Uri.parse(url + ".insert_data"));
    request.bodyFields = {
      'cmd': 'uploadfile',
      'doctype': 'Postal Post',
      'docname': doc,
      'filename': imagename,
      'filedata': byte.toString(),
      'is_private': '1',
      'from_form': '1',
    };
    request.headers.addAll(headers);

    var response = await request.send();
    print(response.statusCode);
  }

  Future<List<dynamic>> facebookpost() async {
    final http.Response post = await http.get(url,
        headers: {'Authorization': key});
    if (post.statusCode == 200) {
      return jsonDecode(post.body)["message"];
    } else {
      print("error");
      return [];
    }
  }

  // ignore: non_constant_identifier_names
  Future<String> create_record(
      String caption, bool fb, bool insta, bool tweet) async {

    final http.Response data = await http
        .post(url + ".created_doc", headers: {
      'Authorization': key
    }, body: {
      "caption": caption,
      "facebook": fb ? "1" : "0",
      "insta": insta ? "1" : "0",
      "tweet": tweet ? "1" : "0"
    });
    print(jsonDecode(data.body)["message"]);
    print(data.statusCode);
    if (data.statusCode == 200) {
      return jsonDecode(data.body)["message"];
    } else {
      return "error";
    }
  }

  // ignore: non_constant_identifier_names
  Future<String> update_to_field(String doc, String imageName) async {
    try {
      final http.Response data = await http.post(
          url + ".data_to_field",
          headers: {'Authorization': key},
          body: {"doc": doc, "image": imageName});
      if (data.statusCode == 200) {
        return jsonDecode(data.body)["message"];
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
}
