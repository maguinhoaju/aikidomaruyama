import 'package:aikidomaruyama/routes.dart';
import 'package:aikidomaruyama/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  RegisterPage({super.key});

  bool _isValidEmail(String? email) {
    if (email == null || email.isEmpty || !email.contains("@")) {
      return false;
    } else {
      return true;
    }
  }

  bool _isValidPassword(String password, String confirmPassword) {
    if (password == confirmPassword) {
      return true;
    } else {
      return false;
    }
  }

  bool _isFormValid() {
    return (_isValidEmail(_emailController.text) ||
        _isValidPassword(
          _passwordController.text,
          _confirmPasswordController.text,
        ));
  }

  void register(BuildContext context) {
    String email = _emailController.text;
    String password = _passwordController.text;

    AuthProvider authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );
    authProvider.signUp(email, password).then((resposta) {
      if (resposta) {
        Navigator.pushNamed(context, Routes.HOME);
      } else {
        Navigator.pushNamed(context, Routes.LOGIN);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "Cadastro",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (!_isValidEmail(value)) {
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
                    if (!_isValidPassword(value, _passwordController.text)) {
                      return 'As senhas não podem ser diferentes.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    if (_isFormValid()) {
                      register(context);
                    } else {
                      const SnackBar(
                        content: Text('Campos obrigatórios ou inválidos!'),
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
