import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:bookmark_app/screen3.dart';

import 'package:http/http.dart' as http;

class RectangleAvatarList extends StatelessWidget {
  //retrive data from last screen
  final int name;
  final String title;

  RectangleAvatarList({Key? key, required this.name, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150.0),
          child: AppBar(
            backgroundColor: Colors.deepPurple,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.notifications),
                color: Colors.white,
                onPressed: () {},
              ),
            ],
            title: Text(
              title.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Container(
                  color: Colors.grey[156],
                  margin: EdgeInsets.only(bottom: 25),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      border: InputBorder.none,
                      hintText: 'Search...',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: FutureBuilder<http.Response>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              var xd = jsonDecode(snapshot.data!.body);
              print(xd.toString());
              var data = xd["subcategories"];
              print(data.toString());
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  print(index.toString());
//return Text(data[index].toString());
                  return asda(context,
                      title: data[index]['category'],
                      subtitle: data[index]['subtitle'],
                      image: data[index]['image_url']);
                },
              );
            }
          },
        ));
  }

  Widget asda(context, {required title, required subtitle, required image}) {
    return Card(
      margin: EdgeInsets.all(19),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: ListTile(
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                image: NetworkImage(image.toString()),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          title: Text(title.toString()),
          subtitle: Text(subtitle.toString()),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Screen3();
            }));
          }),
    );
  }

  Future<http.Response> fetchData() {
    print("fetching data");
    return http.get(Uri.parse(
        'https://63f84b7f1dc21d5465bc6418.mockapi.io/images/${name}'));
    print("fetched data");
  }
}
