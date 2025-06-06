import 'dart:io';
import 'package:aikidomaruyama/models/activity_model.dart';
import 'package:aikidomaruyama/screens/activities_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:aikidomaruyama/common/my_drawer.dart';
import 'package:aikidomaruyama/models/practitioner_model.dart';
//import 'package:aikidomaruyama/providers/auth_provider.dart';
import 'package:aikidomaruyama/providers/activity_provider.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';

  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  String _nome = '';
  String _fotoPath = '';
  String _graduacao = 'BRANCA';

  final PractitionerModel _practitionerModel = PractitionerModel(
    name: "Carlos Magno de França Veiga",
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
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
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

  // Filtra atividades por dia
  List<ActivityModel> _getActivitiesForDay(
    Map<DateTime, List<ActivityModel>> map,
    DateTime day,
  ) {
    final key = DateTime(day.year, day.month, day.day);
    return map[key] ?? [];
  }

  // Verifica se há treinos no dia para marcar no calendário
  bool _hasTrainingOnDay(Map<DateTime, List<ActivityModel>> map, DateTime day) {
    final key = DateTime(day.year, day.month, day.day);
    return map.containsKey(key);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ActivityProvider>(context);
    final trainingMap = provider.trainingByDate;

    final avatar = CircleAvatar(
      radius: 80,
      backgroundImage: _fotoPath.isNotEmpty ? FileImage(File(_fotoPath)) : null,
      child: _fotoPath.isEmpty ? const Icon(Icons.person, size: 50) : null,
    );

    final containerGraduacao = Container(
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
    );

    final barraAtividades = Container(
      alignment: Alignment.center,
      height: 32,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: const Text(
        "Registro de Atividades",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );

    final columnResumo = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          _nome,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          "Total de Treinos: ${_practitionerModel.adultWorkouts} / ${_practitionerModel.adultWorkoutsRequirement}",
          style: const TextStyle(fontSize: 14),
        ),
        Text(
          "Seminários: ${_practitionerModel.seminars} / ${_practitionerModel.seminarsRequirement}",
          style: const TextStyle(fontSize: 14),
        ),
        Text(
          "Ukes: ${_practitionerModel.ukes} / ${_practitionerModel.ukesRequirement}",
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );

    final calendario = TableCalendar(
      firstDay: DateTime(2020),
      lastDay: DateTime(2030),
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ActivitiesPage(date: selectedDay)),
        );
      },
      onPageChanged: (focusedDay) {
        setState(() {
          _focusedDay = focusedDay;
        });
      },
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          final hasTraining = _hasTrainingOnDay(trainingMap, day);
          return Container(
            margin: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: hasTraining ? Colors.redAccent : null,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '${day.day}',
              style: TextStyle(color: hasTraining ? Colors.white : null),
            ),
          );
        },
        todayBuilder: (context, day, focusedDay) {
          return Container(
            margin: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '${day.day}',
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
        selectedBuilder: (context, day, focusedDay) {
          final hasTraining = _hasTrainingOnDay(trainingMap, day);
          return Container(
            margin: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: hasTraining ? Colors.red : Colors.grey,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '${day.day}',
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      ),
      calendarStyle: const CalendarStyle(outsideDaysVisible: false),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
    );

    //montagem da tela
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text("Home", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
        drawer: CustomDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [avatar, const SizedBox(height: 16), columnResumo],
              ),
              const SizedBox(height: 16),
              containerGraduacao,
              const SizedBox(height: 16),
              barraAtividades,
              const SizedBox(height: 2),
              calendario,
            ],
          ),
        ),
      ),
    );
  }
}
