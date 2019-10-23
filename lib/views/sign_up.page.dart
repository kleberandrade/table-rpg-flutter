import 'package:flutter/material.dart';
import 'package:table_rpg/models/user.dart';
import 'package:table_rpg/services/auth.dart';
import 'package:table_rpg/views/sign_in_page.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = '/signup';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = new TextEditingController();
  final _emailController = new TextEditingController();
  final _passwordController = new TextEditingController();
  final _confirmPasswordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _showNameTextField(),
              _showEmailTextField(),
              _showPasswordTextField(),
              _showConfirmPasswordTextField(),
              _showSignUpButton(),
              _showSignInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showNameTextField() {
    return TextField(
      controller: _nameController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Nome',
        prefixIcon: Icon(Icons.person),
      ),
    );
  }

  Widget _showEmailTextField() {
    return TextField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Email',
        prefixIcon: Icon(Icons.email),
      ),
    );
  }

  Widget _showPasswordTextField() {
    return TextField(
      controller: _passwordController,
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Senha',
        prefixIcon: Icon(Icons.vpn_key),
      ),
    );
  }

  Widget _showConfirmPasswordTextField() {
    return TextField(
      controller: _confirmPasswordController,
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Confirmar senha',
        prefixIcon: Icon(Icons.vpn_key),
      ),
    );
  }

  Future _signUp() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    await Auth.signUp(email, password).then(_onResultSignUpSuccess);
  }

  void _onResultSignUpSuccess(String userId) {
    final email = _emailController.text;
    final name = _nameController.text;
    final user = User(userId: userId, name: name, email: email);
    Auth.addUser(user);
  }

  Widget _showSignUpButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: RaisedButton(child: Text('REGISTRAR'), onPressed: _signUp),
    );
  }

  void _signIn() {
    Navigator.of(context).pushReplacementNamed(SignInPage.routeName);
  }

  Widget _showSignInButton() {
    return FlatButton(child: Text('Login'), onPressed: _signIn);
  }
}
