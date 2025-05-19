import 'dart:io';
import 'package:aikidomaruyama/screens/home_page.dart';
//import 'package:aikidomaruyama/providers/authentication.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class RegisterNewPage extends StatefulWidget {
  static String tag = 'home-page';

  const RegisterNewPage({super.key});

  @override
  _RegisterNewPageState createState() => _RegisterNewPageState();
}

class _RegisterNewPageState extends State<RegisterNewPage> {
  //  final AuthenticationService _authenticationService = AuthenticationService();

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  bool _validatePassword(String password, String confirmPassword) {
    if (password == confirmPassword) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nome', _emailController.text);
    await prefs.setString('password', _passwordController.text);
    await prefs.setString('confirmPassword', _confirmPasswordController.text);
  }

  @override
  Widget build(BuildContext context) {
    //final node = FocusScope.of(context);

    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "Novo Cadastro",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um e-mail válido.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Senha'),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira uma senha.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Conrimar senha',
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, confirme a senha.';
                    }
                    if (!_validatePassword(value, _passwordController.text)) {
                      return 'As senhas não podem ser diferentes.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _saveData();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Cadastro realizado com sucesso!'),
                        ),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    }
                  },
                  child: const Text('Cadastrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
