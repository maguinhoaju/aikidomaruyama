import 'package:aikidomaruyama/components/decoration.dart';
//import 'package:aikidomaruyama/providers/authentication.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  //  final AuthenticationService _authenticationService = AuthenticationService();

  final requirementsButton = Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: FilledButton(
      onPressed: () {},
      style: getButtonStyle(),
      child: const Text('Requisitos', style: TextStyle(color: Colors.white)),
    ),
  );

  final activitiesButton = Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: FilledButton(
      onPressed: () {},
      style: getButtonStyle(),
      child: const Text('Atividades', style: TextStyle(color: Colors.white)),
    ),
  );

  final requirementsElevatenButton = ElevatedButton.icon(
    onPressed: () {},
    icon: const Icon(Icons.flag_circle, size: 48),
    label: const Text('Requisitos'),
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: const Color.fromARGB(255, 8, 64, 110),
      textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      elevation: 5,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    ),
  );

  final activitiesElevatenButton = ElevatedButton.icon(
    onPressed: () {},
    icon: const Icon(Icons.calendar_month, size: 48),
    label: const Text('Atividades'),
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: const Color.fromARGB(255, 8, 64, 110),
      textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      elevation: 5,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Administração",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                //          _authenticationService.signOut();
              },
            ),
            ListTile(
              title: const Text(
                "Home",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/homepage');
              },
            ),
            ListTile(
              title: const Text(
                "Administração",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/adminpage');
              },
            ),
            ListTile(
              title: const Text(
                "Perfil",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/profilepage');
              },
            ),
            ListTile(
              title: const Text(
                "Cadastro",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/registerpage');
              },
            ),
          ],
        ),
      ),
      body: Center(
        //SingleChildScrollView - habilita a rolagem da tela se exceder seu tamanho
        child: SingleChildScrollView(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(left: 48.0, right: 48.0),
            children: <Widget>[
              requirementsElevatenButton,
              const SizedBox(height: 32.0),
              activitiesElevatenButton,
              const SizedBox(height: 200.0),
            ],
          ),
        ),
      ),
    );
  }
}
