import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';
import 'package:table_rpg/services/auth.dart';
import 'package:table_rpg/views/sign_up.page.dart';

import 'home_page.dart';

class SignInPage extends StatefulWidget {
  static const String routeName = '/signin';

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = new TextEditingController();
  final _passwordController = new TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _showEmailTextField(),
              _showPasswordTextField(),
              _showSignInButton(),
              _showSignUpButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showEmailTextField() {
    return TextField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration:
          InputDecoration(hintText: Strings.of(context).valueOf("email"), prefixIcon: Icon(Icons.email)),
    );
  }

  void _toggleObscurePassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  Widget _showPasswordTextField() {
    return TextField(
      controller: _passwordController,
      keyboardType: TextInputType.text,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        hintText: Strings.of(context).valueOf("password"),
        prefixIcon: Icon(Icons.vpn_key),
        suffixIcon: IconButton(
          icon:
              Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
          onPressed: _toggleObscurePassword,
        ),
      ),
    );
  }

  Future<void> _signIn() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    await Auth.signIn(email, password).then(_onSignInSuccess);
  }

  void _onSignInSuccess(String userId) {
    print('Signed in: $userId');
    Navigator.of(context).pushReplacementNamed(HomePage.routeName);
  }

  Widget _showSignInButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: RaisedButton(child: Text(Strings.of(context).valueOf("signin")), onPressed: _signIn),
    );
  }

  void _signUp() {
    Navigator.of(context).pushReplacementNamed(SignUpPage.routeName);
  }

  Widget _showSignUpButton() {
    return FlatButton(child: Text(Strings.of(context).valueOf("create_account")), onPressed: _signUp);
  }
}
