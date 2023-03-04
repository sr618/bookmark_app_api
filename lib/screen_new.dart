import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = kToolbarHeight + 40;
    final containerHeight = (screenHeight / 2) - (appBarHeight / 2);

    return Container(
      height: containerHeight,
      child: AppBar(
        leading: Image.network('https://lh6.googleusercontent.com/TEe5jUF-pT3sZlrQoLZrWNm6OgZcz-IonKiPJ5nUlzgLLjvKf3E_zARBd3zaFHgMTyM=w2400',height: 90,),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  final Size preferredSize = Size.fromHeight(kToolbarHeight + 40);
}
