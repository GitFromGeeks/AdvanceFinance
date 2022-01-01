import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        // scrollDirection:Axis.vertical,
        child: Center(
          child: Container(
            child: Column(
              children: [
                Image(
                  image: AssetImage("af.png"),
                ),
                Card(
                  color: Colors.white,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "ADMIN",
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.bold),
                        ),
                        _password(),
                        _loginButton(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final snackBar =
      SnackBar(content: Text("Invalid !", style: TextStyle(color: Colors.red)));

  Widget _password() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        controller: passwordController,
        keyboardType: TextInputType.number,
        obscureText: true,
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color: Color(0xff2470c7),
            ),
            labelText: "Password"),
      ),
    );
  }

  Widget _loginButton(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 1.4 * ((MediaQuery.of(context).size.height) / 25),
          width: 5 * ((MediaQuery.of(context).size.width) / 15),
          margin: EdgeInsets.only(top: 10, bottom: 20),
          child: ElevatedButton(
            child: Text(
              "LOGIN",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 50,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed("/home");
            },
          ),
        )
      ],
    );
  }
}
