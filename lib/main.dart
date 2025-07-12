import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(App());
}


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'GoGarden',
        home: HomePage(),
      ),
    );
  }
}


class AppState extends ChangeNotifier {

}


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFFBF6E9),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 80),
            Image.asset(
              "assets/logo.png",
              width: 400,
              height: 400
            ),
            const Text(
              "Stronger Gardens for a Better Planet",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  letterSpacing: 3
              )
            ),
            SizedBox(height: 50),
            SizedBox(
              width: 350,
              height: 40,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF48A23F)
                ),
                child: Text(
                    "SIGN UP",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: "Bubblebody Neue",
                    )
                )
              ),
            ),
            SizedBox(height: 45),
            SizedBox(
              width: 350,
              height: 40,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF019A6E)
                  ),
                  child: Text(
                      "LOG IN",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: "Bubblebody Neue",
                      )
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}

