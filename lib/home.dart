import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Center(
        child: Column(
          children: [
            Text("This is your account's home page"),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/lock');
                },
                child: Text("Return to lock"),
            ),
          ],
        ),
      ),
    );
  }
}
