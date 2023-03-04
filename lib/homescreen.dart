import 'dart:ffi' as ffi; // Use a prefix when importing dart:ffi
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bookmark_app/cat.dart';
import 'package:bookmark_app/screen3.dart';
import 'package:bookmark_app/screen_new.dart';

class Homescreen extends StatefulWidget {
  Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    print("hello");
    var top = 0.0;
    var left = 0.0;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(250.0),
        child: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          elevation: 0.0,
          leading: Container(
            margin: EdgeInsets.all(10.0),
            child: Image.network(
              'https://lh6.googleusercontent.com/TEe5jUF-pT3sZlrQoLZrWNm6OgZcz-IonKiPJ5nUlzgLLjvKf3E_zARBd3zaFHgMTyM=w2400',
              fit: BoxFit.contain,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_sharp,
                color: Colors.white,
                size: 30.0,
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Hello,',
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                ),
              ),
              Text(
                'Welcome User',
                style: TextStyle(
                  fontSize: 50.0,
                  color: Colors.white,
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                      spreadRadius: 1.0,
                      offset: Offset(0.0, 2.0),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search",
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(Icons.delete),
                Icon(Icons.edit_calendar),
                Icon(Icons.sort),
              ],
            ),
          ),
          Expanded(
            flex: 20,
            child: Container(
                //   margin: EdgeInsets.only(top: 390),
                child: FutureBuilder<http.Response>(
                    future: fetchData(), // replace with your own future
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        var data = jsonDecode(snapshot.data!.body);
                        return GridView.count(
                            crossAxisCount: 2,
                            children: List.generate(data.length, (index) {
                              return Container(
                                padding: EdgeInsets.all(8),
                                child: Spinner(
                                  id: int.parse(data[index]['id']),
                                  img: data[index]['image_url'],
                                  title: data[index]['title'],
                                ),
                              );
                            }));
                      }
                    })),
          )
        ],
      ),
    );
  }

  Widget Spinner({required img, required title, required int id}) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  RectangleAvatarList(name: id, title: title)),
        );
      },
      child: Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: Color(0xff5af4a5),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(img),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<http.Response> fetchData() {
    print("fetching data");
    return http
        .get(Uri.parse('https://63f84b7f1dc21d5465bc6418.mockapi.io/images'));
    print("fetched data");
  }
}
