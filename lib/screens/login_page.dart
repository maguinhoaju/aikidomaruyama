import 'package:aikidomaruyama/common/my_snackbar.dart';
import 'package:aikidomaruyama/components/decoration.dart';
import 'package:aikidomaruyama/providers/auth_provider.dart';
import 'package:aikidomaruyama/routes.dart';
import 'package:aikidomaruyama/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';

  const LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorMessage = '';

  void onChange() {
    setState(() {
      _errorMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    _emailController.addListener(onChange);
    _passwordController.addListener(onChange);

    final logo = Hero(
      tag: 'logo',
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 80.0,
            child: Image.asset('assets/images/logo.png'),
          ),
          const Text(
            'Academia Sergipana de Aikido',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 8, 64, 110),
            ),
          ),
        ],
      ),
    );

    final errorMessage = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        _errorMessage,
        style: const TextStyle(fontSize: 14.0, color: Colors.red),
        textAlign: TextAlign.center,
      ),
    );

    final email = TextFormField(
      validator: (value) {
        if (value!.isEmpty || !value.contains('@')) {
          showSnackBar(context: context, text: "Email inválido");
          return 'Por favor digite um email válido.';
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: _emailController,
      decoration: getHintTextInputDecoration("E-mail"),
      textInputAction: TextInputAction.next,
      onEditingComplete: () => node.nextFocus(),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: _passwordController,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (v) {
        FocusScope.of(context).requestFocus(node);
      },
      decoration: getHintTextInputDecoration("Senha"),
    );

    final loginButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: FilledButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            String email = _emailController.text;
            String password = _passwordController.text;

            AuthProvider authProvider = Provider.of<AuthProvider>(
              context,
              listen: false,
            );
            authProvider.signIn(email, password).then((resposta) {
              if (resposta) {
                Navigator.pushNamed(context, Routes.HOME);
              } else {
                _errorMessage = 'Falha ao efetuar login.';
              }
            });
          }
        },
        style: getButtonStyle(),
        child: const Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    final registerButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: FilledButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.REGISTER);
        },
        style: getButtonStyle(),
        child: const Text('Registrar', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = TextButton(
      child: const Text(
        'Esqueceu a senha?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        print("Click!");
      },
    );

    // Montagem do formulário
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Center(
          //SingleChildScrollView - habilita a rolagem da tela se exceder seu tamanho
          child: SingleChildScrollView(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                logo,
                const SizedBox(height: 24.0),
                errorMessage,
                const SizedBox(height: 13.0),
                email,
                const SizedBox(height: 10.0),
                password,
                const SizedBox(height: 16.0),
                loginButton,
                registerButton,
                forgotLabel,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
