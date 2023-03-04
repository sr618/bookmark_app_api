import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Screen3 extends StatelessWidget {
  const Screen3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(95),

            child: AppBar(
              backgroundColor: Colors.deepPurple,

              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    // Add share button press event handling code here
                  },
                ),
              ],
              title: Text('App Title'),
            ),

        )
        ,
        body: Column(
          children: [
            Expanded(
                child: Row(
              children: [
                Expanded(child: Icon(Icons.h_mobiledata_rounded)),
                Expanded(
                  child: Text("Title"),
                  flex: 10,
                )
              ],
            )),
            Expanded(

                child: TextField(

              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(50),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            )),
            Expanded(
                child: Row(
              children: [
                Expanded(
                  child: Icon(Icons.link_outlined),
                ),
                Expanded(
                  child: Text("URL"),
                  flex: 10,
                )
              ],
            )), Expanded(
                child: TextField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            )),
            Expanded(
                child: Row(
              children: [
                Expanded(
                  child: Icon(Icons.note),
                ),
                Expanded(
                  child: Text("Description"),
                  flex: 10,
                )
              ],
            )),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                maxLines: 500,
                minLines: 16,
              ),
              flex: 9,
            ),
            Expanded(
                child: Row(
              children: [
                Expanded(
                    child: InkWell(
                  splashColor: Colors.blue,
                  onTap: () {
                    // Add tap event handling code here
                  },
                  child: Container(
                    width: 200.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ),
                  ),
                )
                    // child:
                    ),
                Expanded(
                    child: InkWell(
                  splashColor: Colors.blue,
                  onTap: () {
                    // Add tap event handling code here
                  },
                  child: Container(
                    width: 200.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ),
                  ),
                )
                    // child:
                    )
              ],
            ))
          ],
        ));
  }
}
