import 'dart:convert';

import 'package:http/http.dart' as http;

class Endpoint {
  var key = "token " + "1d2c48f45385e2e" + ":" + "a6e278617a87b81";

  final String url = "http://10.0.2.2:8002/api/method/postal_hub.postal_hub.doctype.postal_post.postal_post";

  Future<void> uploaddata(String byte,String imagename,String doc) async {
    
      var headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': key.toString()
      };
      var request = http.Request(
          'POST', Uri.parse(url+".insert_data"));
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
    // print(data.statusCode);
  }

  Future<String> create_record(String caption) async{
   
      final http.Response data = await http.post(
        url +".created_doc",
        headers: {'Authorization': key.toString()},
        body: {"caption":caption});
      print(data.statusCode);
      print(jsonDecode(data.body)["message"]);
      if (data.statusCode == 200 ){
        return jsonDecode(data.body)["message"];
      }
      else{
        return "error";
      }
      

    

  }
  Future<String> update_to_field(String doc,String image_name) async{
    try {
      final http.Response data = await http.post(
        url +
            ".data_to_field",
        headers: {'Authorization': key.toString()},
        body: {"doc": doc ,"image": image_name});
      if (data.statusCode == 200 ){
        return jsonDecode(data.body)["message"];
      }
      else{
        return "error";
      }
      
    } catch (e) {
      return "error";
    }

    

  }
  
}
