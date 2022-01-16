import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // INstance of auth service class
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = "";
  String password = "";

  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: Text('Sign up to Brew Crew'),
          actions: [
            FlatButton.icon(
                onPressed: () {
                  widget.toggleView();
                },
                icon: Icon(Icons.person),
                label: Text("Sign In"))
          ],
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) => {
                      // here when value changes we get it in val
                      setState(() => email = val)
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    validator: (val) => val!.length < 6
                        ? 'Enter a password 6+ chars long'
                        : null,
                    onChanged: (val) => {
                      // here when value changes we get it in val
                      setState(() => password = val)
                    },
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    onPressed: () async {
                      // form key helps us to validate form
                      // validate runs the function in validator.
                      // and hence helps in validation
                      if (_formKey.currentState!.validate()) {
                        dynamic result = await _auth
                            .registerWithEmailAndPassword(email, password);

                        if (result == null) {
                          setState(() => error = "Please supply a valid email");
                        }
                        // and if we have the result then it goes through the stream and home page listens to the auth changes and we get home page
                      }
                    },
                    color: Colors.pink[400],
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                    child: Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  )
                ],
              ),
            )));
  }
}
