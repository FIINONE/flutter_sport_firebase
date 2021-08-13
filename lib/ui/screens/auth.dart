import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sport_firebase/model/user.dart';
import 'package:flutter_sport_firebase/data/services/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  static const Icon _emaiIcon = Icon(Icons.email);
  static const Icon _passwordIcon = Icon(Icons.lock);

  static const String _emailHintText = 'Enter Email';
  static const String _passwordHintText = 'Enter password';

  late final TapGestureRecognizer _tapGestureRecognizer;

  final AuthServise _authServise = AuthServise();

  bool showLogin = true;

  Widget _logo() {
    return const Padding(
      padding: EdgeInsets.only(top: 100.0),
      child: Center(
        child: Text(
          'ACTIVE LIFE',
          style: TextStyle(
              color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 50),
        ),
      ),
    );
  }

  Widget _textField({
    required Icon icon,
    required String hintText,
    required TextEditingController controller,
    bool obscure = false,
  }) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        prefixIcon: IconTheme(
          data: const IconThemeData(color: Colors.white),
          child: icon,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white30),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.white),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.white54),
        ),
      ),
    );
  }

  ElevatedButton _buttonForm(
      BuildContext context, String text, void Function() function) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        fixedSize: MaterialStateProperty.all(Size(
          MediaQuery.of(context).size.width,
          50,
        )),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) =>
                states.contains(MaterialState.pressed)
                    ? const Color.fromRGBO(50, 65, 85, 0.5)
                    : null),
      ),
      onPressed: function,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 24,
          color: Colors.black54,
          letterSpacing: 1,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Future<void> _loginButton() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      return;
    }

    final UserModel? user =
        await _authServise.signInEmailPasssword(email.trim(), password.trim());
    if (user == null) {
      Fluttertoast.showToast(
          msg: 'Can`t SignIn you. Please check your email/password');
    } else {
      _emailController.clear();
      _passwordController.clear();
    }
  }

  Future<void> _registerButton() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      return;
    }

    final UserModel? user = await _authServise.registerEmailPasssword(
        email.trim(), password.trim());
    if (user == null) {
      Fluttertoast.showToast(
          msg: 'Can`t Register you. Please check your email/password');
    } else {
      _emailController.clear();
      _passwordController.clear();
    }
  }

  void _swapShowLoginReg() {
    setState(() {
      showLogin ? showLogin = false : showLogin = true;
    });
  }

  @override
  void initState() {
    super.initState();

    _tapGestureRecognizer = TapGestureRecognizer()..onTap = _swapShowLoginReg;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
        children: <Widget>[
          _logo(),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: <Widget>[
                _textField(
                  controller: _emailController,
                  icon: _emaiIcon,
                  hintText: _emailHintText,
                ),
                const SizedBox(height: 20),
                _textField(
                  controller: _passwordController,
                  icon: _passwordIcon,
                  hintText: _passwordHintText,
                  obscure: true,
                ),
                const SizedBox(height: 30),
                if (showLogin == true)
                  Column(
                    children: <Widget>[
                      _buttonForm(context, 'Sign In', _loginButton),
                      const SizedBox(height: 16),
                      RichText(
                        text: TextSpan(
                          text: 'Not registered yet? ',
                          style: const TextStyle(color: Colors.white),
                          children: <InlineSpan>[
                            TextSpan(
                                text: 'Sign Up!',
                                recognizer: _tapGestureRecognizer,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue,
                                )),
                          ],
                        ),
                      )
                    ],
                  )
                else
                  Column(
                    children: <Widget>[
                      _buttonForm(context, 'Sign Up', _registerButton),
                      const SizedBox(height: 16),
                      RichText(
                        text: TextSpan(
                          text: 'Already registered?',
                          style: const TextStyle(color: Colors.white),
                          children: <InlineSpan>[
                            TextSpan(
                                text: 'Sign In!',
                                recognizer: _tapGestureRecognizer,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue,
                                )),
                          ],
                        ),
                      )
                    ],
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
