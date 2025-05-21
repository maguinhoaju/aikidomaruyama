import 'dart:io';
import 'package:aikidomaruyama/screens/home_page.dart';
//import 'package:aikidomaruyama/providers/authentication.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class CompleteRegisterPage extends StatefulWidget {
  static String tag = 'home-page';

  const CompleteRegisterPage({super.key});

  @override
  _CompleteRegisterPageState createState() => _CompleteRegisterPageState();
}

class _CompleteRegisterPageState extends State<CompleteRegisterPage> {
  //  final AuthenticationService _authenticationService = AuthenticationService();

  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _dataInicioController = TextEditingController();
  final _dataUltimoExameController = TextEditingController();

  String _graduacaoSelecionada = 'BRANCA'; // Valor padrão
  String? _fotoPath;

  final List<String> _graduacoes = [
    'BRANCA',
    'AMARELA',
    'ROXA',
    'VERDE',
    'AZUL',
    'MARROM',
    'SHODAN',
    'NIDAN',
    'SANDAN',
    'YODAN',
    'GODAN',
    'ROKUDAN',
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final path =
          '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
      await pickedFile.saveTo(path);

      setState(() {
        _fotoPath = path;
      });

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('fotoPath', path);
    }
  }

  Future<void> _takePhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final path =
          '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
      await pickedFile.saveTo(path);

      setState(() {
        _fotoPath = path;
      });

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('fotoPath', path);
    }
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nomeController.text = prefs.getString('nome') ?? '';
      _dataNascimentoController.text = prefs.getString('dataNascimento') ?? '';
      _dataInicioController.text = prefs.getString('dataInicio') ?? '';
      _dataUltimoExameController.text =
          prefs.getString('dataUltimoExame') ?? '';
      _fotoPath = prefs.getString('fotoPath');

      // Carregar e definir a graduação, garantindo que seja um valor válido
      final savedGraduacao = prefs.getString('graduacao');
      if (savedGraduacao != null && _graduacoes.contains(savedGraduacao)) {
        _graduacaoSelecionada = savedGraduacao;
      }
    });
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nome', _nomeController.text);
    await prefs.setString('dataNascimento', _dataNascimentoController.text);
    await prefs.setString('dataInicio', _dataInicioController.text);
    await prefs.setString('dataUltimoExame', _dataUltimoExameController.text);
    await prefs.setString('graduacao', _graduacaoSelecionada);
    await prefs.setString('fotoPath', _fotoPath ?? '');
  }

  @override
  Widget build(BuildContext context) {
    //final node = FocusScope.of(context);

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
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
                onTap: () {
                  //         _authenticationService.signOut();
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
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: const Icon(Icons.camera_alt),
                              title: const Text('Tirar Foto'),
                              onTap: () {
                                Navigator.pop(context);
                                _takePhoto();
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.image),
                              title: const Text('Escolher Foto'),
                              onTap: () {
                                Navigator.pop(context);
                                _pickImage();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        _fotoPath != null ? FileImage(File(_fotoPath!)) : null,
                    child:
                        _fotoPath == null
                            ? const Icon(Icons.camera_alt, size: 50)
                            : null,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nomeController,
                  decoration: const InputDecoration(labelText: 'Nome Completo'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu nome completo';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _dataNascimentoController,
                  decoration: const InputDecoration(
                    labelText: 'Data de Nascimento',
                  ),
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira sua data de nascimento';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _dataInicioController,
                  decoration: const InputDecoration(
                    labelText: 'Data de Início no Aikido',
                  ),
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a data de início no Aikido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _graduacaoSelecionada,
                  decoration: const InputDecoration(
                    labelText: 'Graduação Atual',
                  ),
                  items:
                      _graduacoes.map((graduacao) {
                        return DropdownMenuItem<String>(
                          value: graduacao,
                          child: Text(graduacao),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _graduacaoSelecionada =
                          value ??
                          'BRANCA'; // Definindo valor padrão caso seja nulo
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, selecione sua graduação';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _dataUltimoExameController,
                  decoration: const InputDecoration(
                    labelText: 'Data do Último Exame',
                  ),
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a data do último exame';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
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
