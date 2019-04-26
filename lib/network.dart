import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Networking {
  final String url = "https://picsum.photos/v2/list?limit=5";
  List<LoremObject> data;

  Future<List<LoremObject>> getJSONData() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    // print(response.body);

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      var dataConvertedToJSON = json.decode(response.body) as List;
      return dataConvertedToJSON
          .map((value) => LoremObject.fromJson(value))
          .toList();

      // print(data);
      // return "Successfull";
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
}

//{"id":"0","author":"Alejandro Escamilla","width":5616,"height":3744,"url":"https://unsplash.com/photos/yC-Yzbqy7PY","download_url":"https://picsum.photos/id/0/5616/3744"}
class LoremObject {
  final String id;
  final String author;
  final String url;
  final String downloadUrl;
  final int width;
  final int height;

  LoremObject(
      {this.id,
      this.author,
      this.url,
      this.downloadUrl,
      this.width,
      this.height});

  factory LoremObject.fromJson(Map<String, dynamic> json) {
    return LoremObject(
      author: json['author'],
      id: json['id'],
      width: json['width'],
      height: json['height'],
      url: json['url'],
      downloadUrl: json['download_url'],
    );
  }
}
