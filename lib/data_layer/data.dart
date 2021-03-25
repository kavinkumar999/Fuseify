import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;

class Endpoint {
  // var keye = Process.data.url;
   

  Future<void> uploaddata(String byte, String imagename, String doc) async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': FlutterConfig.get("key")
    };
    var request = http.Request(
        'POST', Uri.parse(FlutterConfig.get("url") + ".insert_data"));
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
    final http.Response post = await http.get(FlutterConfig.get("url"),
        headers: {'Authorization': FlutterConfig.get("key")});
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
      print("///////////////////////////////////");
      // FlutterConfig.loadEnvVariables("emi");
      FlutterConfig.get("emi");
      String eemi = FlutterConfig.get("emi");
      print(eemi);
      print(env["emi"]);
    print(FlutterConfig.get("emi"));
    print(FlutterConfig.get("url"));
    print(FlutterConfig.get("KEY"));
    print(FlutterConfig.get("emi"));

    final http.Response data = await http
        .post(FlutterConfig.get("url") + ".created_doc", headers: {
      'Authorization': FlutterConfig.get("key")
    }, body: {
      "caption": caption,
      "facebook": fb,
      "insta": insta,
      "tweet": tweet
    });
    print("enter");
    print(FlutterConfig.get("url"));
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
          FlutterConfig.get("url") + ".data_to_field",
          headers: {'Authorization': FlutterConfig.get("key")},
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
