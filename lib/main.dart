import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'signlog.dart';
import 'home.dart';


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
        initialRoute: '/lock',
        routes: {
          '/lock': (context) => LockPage(),
          '/signup': (context) => SignUpPage(),
          '/login': (context) => LogInPage(),
          '/home': (context) => HomePage(),
        },
      ),
    );
  }
}


class AppState extends ChangeNotifier {

}


class LockPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFFBF6E9),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 80),
            Image.asset(
              'assets/logo.png',
              width: 400,
              height: 400
            ),
            SizedBox(height: 15),
            const Text(
              'Stronger Gardens for a Better Planet',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  letterSpacing: 3
              )
            ),
            SizedBox(height: 100),
            SizedBox(
              width: 350,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF48A23F)
                ),
                child: Text(
                    'SIGN UP',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Bubblebody Neue',
                    )
                )
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: 350,
              height: 40,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF019A6E)
                  ),
                  child: Text(
                      'LOG IN',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Bubblebody Neue',
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
