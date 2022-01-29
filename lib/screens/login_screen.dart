import 'package:flutter/material.dart';
import 'package:fotogram/helpers/authorization.dart';
import 'package:fotogram/layouts/mobile_layout.dart';
import 'package:fotogram/layouts/responsive_layout.dart';
import 'package:fotogram/layouts/web_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void userLogin() async {
    setState(() {
      _isLoading = true;
    });
    String result = await Authorization().signIn(
        email: _emailController.text, password: _passwordController.text);
    if (result == "success") {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              webLayout: WebLayout(),
              mobileLayout: MobileLayout(),
            ),
          ),
          (route) => false);

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: const Center(
        child: Text('User not logged in!'),
      ),
    );
  }
}
