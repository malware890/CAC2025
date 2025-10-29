import 'package:flutter/material.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String? _errorMessage;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

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
            const SizedBox(height: 55),
            SizedBox(
              width: 350,
              height: 90,
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: const TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 17,
                    fontFamily: 'Bubblebody Neue',
                  ),
                  hintText: 'Create your username',
                  hintStyle: const TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 17,
                    fontFamily: 'Bubblebody Neue',
                  ),
                  filled: true,
                  fillColor: const Color(0x8048A23F),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(color: Color(0x8090ee90)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(color: Color(0xFF48A23F), width: 2.0),
                  ),
                ),
                style: const TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 20,
                  fontFamily: 'Bubblebody Neue',
                ),
              ),
            ),
            SizedBox(
              width: 350,
              height: 90,
              child: TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 17,
                    fontFamily: 'Bubblebody Neue',
                  ),
                  hintText: 'Create your password',
                  hintStyle: const TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 17,
                    fontFamily: 'Bubblebody Neue',
                  ),
                  filled: true,
                  fillColor: const Color(0x800196AE),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(color: Color(0x8040E0D0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(color: Color(0xFF0196AE), width: 2.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                keyboardType: TextInputType.visiblePassword,
                style: const TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 20,
                  fontFamily: 'Bubblebody Neue',
                ),
              ),
            ),
            SizedBox(
              width: 350,
              height: 80,
              child: TextField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: const TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 17,
                    fontFamily: 'Bubblebody Neue',
                  ),
                  hintText: 'Confirm Your Password',
                  hintStyle: const TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 17,
                    fontFamily: 'Bubblebody Neue',
                  ),
                  filled: true,
                  fillColor: const Color(0x800196AE),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(color: Color(0x8040E0D0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(color: Color(0xFF0196AE), width: 2.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
                keyboardType: TextInputType.visiblePassword,
                style: const TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 20,
                  fontFamily: 'Bubblebody Neue',
                ),
              ),
            ),
            SizedBox(
              width: 200,
              height: 20,
              child: Center(
                child: Text(
                  _errorMessage ?? '',
                  style: const TextStyle(
                    color: Color(0xFFFF0000),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5
            ),
            SizedBox(
              width: 200,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _errorMessage = null;
                    var pswd = _passwordController.text;
                    var user = _usernameController.text;
                    var conf = _confirmPasswordController.text;

                    if (pswd.isEmpty || user.isEmpty || conf.isEmpty) {
                      _errorMessage = "Please enter all fields!";
                    }
                    else if (pswd != conf) {
                      _errorMessage = 'Passwords do not match!';
                    }
                    else if (user.length > 11) {
                      _errorMessage = 'Username is too long!';
                    }
                    else {
                      Navigator.pushNamed(
                        context,
                        '/home',
                      );
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF019A6E),
                ),
                child: const Text(
                  'SIGN UP',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
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




class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool _obscureText = true;
  String? _errorMessage;
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

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
            SizedBox(height: 55),
            SizedBox(
              width: 350,
              height: 100,
              child: TextField(
                controller: _userController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 17,
                    fontFamily: 'Bubblebody Neue',
                  ),
                  hintText: 'Enter your username',
                  hintStyle: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 17,
                    fontFamily: 'Bubblebody Neue',
                  ),
                  filled: true,
                  fillColor: Color(0x8048A23F),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(color: Color(0x8090ee90)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(color: Color(0xFF48A23F), width: 2.0),
                  ),
                ),
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 20,
                  fontFamily: 'Bubblebody Neue',
                )
              ),
            ),
            SizedBox(
              width: 350,
              height: 100,
              child: TextField(
                controller: _passController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 17,
                    fontFamily: 'Bubblebody Neue',
                  ),
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 17,
                    fontFamily: 'Bubblebody Neue',
                  ),
                  filled: true,
                  fillColor: Color(0x800196AE),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(color: Color(0x8040E0D0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(color: Color(0xFF0196AE), width: 2.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                obscureText: _obscureText,
                keyboardType: TextInputType.visiblePassword,
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 20,
                  fontFamily: 'Bubblebody Neue',
                ),
              ),
            ),
            SizedBox(
              width: 200,
              height: 20,
              child: Center(
                child: Text(
                  _errorMessage ?? '',
                  style: const TextStyle(
                    color: Color(0xFFFF0000),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            SizedBox(
                height: 5
            ),
            SizedBox(
              width: 200,
              height: 40,
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _errorMessage = null;
                      var pswd = _passController.text;
                      var user = _userController.text;

                      if (pswd.isEmpty || user.isEmpty) {
                        _errorMessage = "Please enter all fields!";
                      }
                      else if (user != "GoGarden" && pswd != "CAC2025") {
                        _errorMessage = 'Incorrect Credentials!'; // TODO DATABASE
                      } else {
                        Navigator.pushNamed(
                          context,
                          '/home',
                        );
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF019A6E)
                  ),
                  child: Text(
                      'LOG IN',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
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