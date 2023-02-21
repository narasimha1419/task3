import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

class dataProvider with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  Future<dynamic> getDetails() async {
    var request =
        http.Request('GET', Uri.parse('https://gorest.co.in/public/v2/users'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var json = await response.stream.bytesToString();
      localStorage.write("fetachDetails", jsonDecode(json));
      print(localStorage.read("fetachDetails"));
    } else {
      print(response.reasonPhrase);
    }
  }
}
