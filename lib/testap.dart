import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Data {
  int id;
  String name;

  Data({required this.id, required this.name});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}

class DataModel with ChangeNotifier {
  List<Data> _data = [];

  List<Data> get data => _data;

  set data(List<Data> value) {
    _data = value;
    notifyListeners();
  }

  Future<void> fetchData() async {
    final response = await http.get("http://flutterdb.42web.io/getdata.php" as Uri);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      List<Data> fetchedData = (json.decode(response.body) as List).map((i) => Data.fromJson(i)).toList();
      data = fetchedData;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load data');
    }
  }
}
