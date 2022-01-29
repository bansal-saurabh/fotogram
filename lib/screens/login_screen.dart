import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fotogram/helpers/authorization.dart';
import 'package:fotogram/layouts/mobile_layout.dart';
import 'package:fotogram/layouts/responsive_layout.dart';
import 'package:fotogram/layouts/web_layout.dart';
import 'package:fotogram/utils/variables.dart';

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
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            padding: MediaQuery.of(context).size.width > minScreenSize
                ? EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 3)
                : const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(),
                  flex: 2,
                ),
                SvgPicture.asset(
                  'assets/fotogram_icon.svg',
                  height: 192,
                ),
                SvgPicture.asset(
                  'assets/fotogram_logo.svg',
                ),
                const SizedBox(
                  height: 96,
                ),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                InkWell(
                  child: Container(
                    child: !_isLoading
                        ? const Text(
                            'Log in',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          )
                        : const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        color: Colors.purple),
                  ),
                  onTap: userLogin,
                ),
                const SizedBox(
                  height: 12,
                ),
                InkWell(
                  child: Container(
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        color: Colors.amber),
                  ),
                  onTap: userLogin,
                ),
                const SizedBox(
                  height: 48,
                ),
              ],
            ),
          ),
        ));
  }
}
