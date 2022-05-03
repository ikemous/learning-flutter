import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.red,
                foregroundImage: AssetImage("images/050-mouse.png"),
              ),
              const Text(
                "Ike Barranco",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  height: 1.25,
                  fontSize: 50,
                  fontFamily: "Oleo",
                ),
              ),
              const Text(
                "Web Developer",
                style: TextStyle(
                  color: Colors.white,
                  height: 1.25,
                  fontSize: 25,
                  fontFamily: "Oleo",
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  maxWidth: 300.0,
                ),
                child: Divider(
                  color: Colors.black,
                ),
              ),
              Container(
                color: Colors.white,
              ),
              Container(
                constraints: BoxConstraints(maxWidth: 600.0),
                margin: EdgeInsets.fromLTRB(10.0, 15.0, 25.0, 10.0),
                padding: EdgeInsets.all(20.0),
                color: Colors.white,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 15.0),
                        child: Icon(
                          Icons.phone,
                          semanticLabel: "Phone Icon",
                        ),
                      ),
                      const Text(
                        "+1 555 555 5555",
                      ),
                    ]),
              ),
              Container(
                constraints: BoxConstraints(maxWidth: 600.0),
                margin: EdgeInsets.fromLTRB(10.0, 1.0, 25.0, 10.0),
                padding: EdgeInsets.all(20.0),
                color: Colors.white,
                child: Row(children: [
                  Container(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Icon(
                      Icons.email,
                      semanticLabel: "Email Icon",
                    ),
                  ),
                  const Text("example@email.com"),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
