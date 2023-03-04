import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
//random number generator

  late String _username;
  late String _password;
  late String _email;
  late DateTime _dob;
  late String _avatar ;

@override
  void initState() {
    // TODO: implement initState

  }
int random () {
  var asd = Random();
  var asd2 = asd.nextInt(100);
 return asd2;
}
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

print(_avatar);

      // Send signup request to PHP file
      var response = await http.post(
        'https://flutterdb.42web.io/signup.php' as Uri,
        body: {
          'username': _username,
          'password': _password,
          'email': _email,
          'dob': _dob.toString(),
          'avatar': _avatar,
        },
      );

      // Display result of signup attempt
      var data = json.decode(response.body);
      if (data['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Signup successful!')));

      } else {ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Signup failed.')));

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      appBar: AppBar(title: Text('Signup')),
      body: SingleChildScrollView(

        child: Form(
            key: _formKey,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(

                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage('https://api.multiavatar.com/$random().svg'),

                      )


                      ,SizedBox(height: 16.0),
      TextFormField(
        decoration: InputDecoration(labelText: 'Username'),
        onSaved: (val) => _username = val!,
        validator: (val) => val!.isEmpty ? 'Username is required' : null,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Password'),
        obscureText: true,
        onSaved: (val) => _password = val!,
        validator: (val) => val!.isEmpty ? 'Password is required' : null,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Email'),
        keyboardType: TextInputType.emailAddress,
        onSaved: (val) => _email = val!,
        validator: (val) => val!.isEmpty ? 'Email is required' : null,
      ),
      TextFormField(
          decoration: InputDecoration(labelText: 'Date of Birth'),
          keyboardType: TextInputType.datetime,
          onSaved: (val) => _dob
      ),
          TextFormField(
                  decoration: InputDecoration(labelText: 'Date of Birth'),
                  keyboardType: TextInputType.datetime,
                  onSaved: (val) => _dob = DateTime.parse(val!),
                  validator: (val) => val!.isEmpty ? 'Date of Birth is required' : null,
                ),
                SizedBox(height: 16.0),
              ElevatedButton(onPressed: _submitForm, child: Text('Signup')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
