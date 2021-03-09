import 'package:http/http.dart' as http;

class Endpoint {
  var key = "token " + "b20d5fd1a80acac" + ":" + "f9f8f8ad45c8462";

  final String url = "http://192.168.43.58:8000/api/method/postal_hub.postal_hub.doctype.postal_post.postal_post.insert_data";

  Future<void> addimage(byte, caption) async {
    // final http.Response data = await http.post(
    //     url +
    //         "postal_hub.postal_hub.doctype.postal_post.postal_post.insert_data",
    //     headers: {'Authorization': key.toString()},
    //     body: {"base64": byte, "text": caption,'cmd':'uploadfile','doctype':'Postal Post','docname':'8ac897a525',"fieldname":"image.jpg","filedata":byte,'is_private': '1',
    //     'from_form': '1',});
    print("object");
      var headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': key.toString()
      };
      var request = http.Request(
          'POST', Uri.parse(url));
      request.bodyFields = {
        // 'cmd': 'uploadfile',
        // 'doctype': 'Postal Post',
        // 'docname': "8ac897a525",
        // 'filename': "image_picker957268607.jpg",
        // 'filedata': byte.toString(),
        // 'is_private': '1',
        // 'from_form': '1',
      };
      request.headers.addAll(headers);

      var response = await request.send();
      print(response.statusCode);
    // print(data.statusCode);
  }
}
