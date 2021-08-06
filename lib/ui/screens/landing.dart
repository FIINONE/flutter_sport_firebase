import 'package:flutter/material.dart';
import 'package:flutter_sport_firebase/model/user.dart';
import 'package:flutter_sport_firebase/ui/screens/auth.dart';
import 'package:flutter_sport_firebase/ui/screens/home.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserModel? _usermodel = Provider.of<UserModel?>(context);
    final bool _isLoggedIn = _usermodel != null;
    if (_isLoggedIn)
      return const HomePage();
    else
      return const AuthPage();
  }
}
