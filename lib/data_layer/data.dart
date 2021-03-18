import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class Endpoint {
  // var keye = Process.data.url;


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
  Future<List<dynamic> > facebookpost() async {
    final http.Response post = await http.get(url,headers: {'Authorization': key.toString()});
    if(post.statusCode == 200){
      return jsonDecode(post.body)["message"];

    }
    else{
      print("error");
      return [];
    }
  }

  Future<String> create_record(String caption, bool fb , bool insta, bool tweet) async{
   
      final http.Response data = await http.post(
        url +".created_doc",
        headers: {'Authorization': key.toString()},
        body: {"caption":caption,"facebook":fb,"insta":insta,"tweet":tweet});
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
