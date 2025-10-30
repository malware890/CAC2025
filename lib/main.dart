import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'signlog.dart';
import 'home.dart';
import 'presentation/add_plant_screen/addPlantScreen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'GoGarden',
            initialRoute: '/lock',
            routes: {
              '/lock': (context) => LockPage(),
              '/signup': (context) => SignUpPage(),
              '/login': (context) => LogInPage(),
              '/home': (context) => HomePage(),
              '/add-plant-screen': (context) => AddPlantScreen(),
            },
          );
        },
      ),
    );
  }
}

class AppState extends ChangeNotifier {}

class LockPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF6E9),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 80),
            Image.asset(
              'assets/logo.png',
              width: 400,
              height: 400,
            ),
            const SizedBox(height: 15),
            const Text(
              'Stronger Gardens for a Better Planet',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 100),
            SizedBox(
              width: 350,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF48A23F),
                ),
                child: const Text(
                  'SIGN UP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Bubblebody Neue',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 350,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF019A6E),
                ),
                child: const Text(
                  'LOG IN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Bubblebody Neue',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}