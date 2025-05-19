import 'dart:io';
import 'package:aikidomaruyama/models/profile_model.dart';
//import 'package:aikidomaruyama/providers/authentication.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  static String tag = 'home-page';

  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //final AuthenticationService _authenticationService = AuthenticationService();

  String _nome = '';
  String _fotoPath = '';
  String _graduacao = 'BRANCA';

  final ProfileModel _profileModel = ProfileModel(
    name: "Carlos Magno de França Veiga",
    startDate: "01/11/2007",
    lastExamDate: "25/09/2022",
    adultWorkoutsRequirement: "30",
    adultWorkouts: "12",
    seminarsRequirement: "2",
    seminars: "1",
    ukesRequirement: "1",
    ukes: "1",
  );

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nome = prefs.getString('nome') ?? '';
      _fotoPath = prefs.getString('fotoPath') ?? '';
      _graduacao = prefs.getString('graduacao') ?? 'BRANCA';
    });
  }

  Color _getGraduacaoColor(String graduacao) {
    switch (graduacao) {
      case 'AMARELA':
        return Colors.yellow;
      case 'ROXA':
        return Colors.purple;
      case 'VERDE':
        return Colors.green;
      case 'AZUL':
        return Colors.blue;
      case 'MARROM':
        return Colors.brown;
      case 'SHODAN':
      case 'NIDAN':
      case 'SANDAN':
      case 'YODAN':
      case 'GODAN':
      case 'ROKUDAN':
        return Colors.black;
      default:
        return Colors.white;
    }
  }

  Color _getTextGraduacaoColor(String graduacao) {
    switch (graduacao) {
      case 'BRANCA':
      case 'AMARELA':
        return Colors.black;
      case 'ROXA':
        return Colors.white;
      case 'VERDE':
      case 'AZUL':
        return Colors.black;
      case 'MARROM':
      case 'SHODAN':
      case 'NIDAN':
      case 'SANDAN':
      case 'YODAN':
      case 'GODAN':
      case 'ROKUDAN':
        return Colors.white;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "Perfil",
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
                  //     _authenticationService.signOut();
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
        body: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage:
                        _fotoPath.isNotEmpty
                            ? FileImage(File(_fotoPath))
                            : null,
                    child:
                        _fotoPath.isEmpty
                            ? const Icon(Icons.person, size: 50)
                            : null,
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _nome,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Data de Início",
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        _profileModel.startDate,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Data do Último Exame",
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        _profileModel.lastExamDate,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _getGraduacaoColor(_graduacao),
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  _graduacao,
                  style: TextStyle(
                    color: _getTextGraduacaoColor(_graduacao),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Container(
                alignment: Alignment.center,
                height: 400,
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Minhas Conquistas",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Column(
                      children: [
                        const Text("Treinos de Adultos"),
                        Slider(
                          value: double.parse(_profileModel.adultWorkouts),
                          max: double.parse(
                            _profileModel.adultWorkoutsRequirement,
                          ),
                          divisions: 5,
                          label: "Treinos de Adultos",
                          onChanged: (double value) {},
                        ),
                        const SizedBox(height: 32),
                        const Text("Seminários"),
                        Slider(
                          value: double.parse(_profileModel.seminars),
                          max: double.parse(_profileModel.seminarsRequirement),
                          divisions: 5,
                          label: "Seminários",
                          onChanged: (double value) {},
                        ),
                        const SizedBox(height: 32),
                        const Text("Ukes"),
                        Slider(
                          value: double.parse(_profileModel.ukes),
                          max: double.parse(_profileModel.ukesRequirement),
                          divisions: 5,
                          label: "Ukes",
                          onChanged: (double value) {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
