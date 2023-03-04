import 'package:flutter/material.dart';
import 'testap.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data'),
      ),
      body: Container(
        child: FutureBuilder<List<Data>>(
          //future: DataModel().fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
            //    itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
              //      title: Text(snapshot.data[index].name),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
