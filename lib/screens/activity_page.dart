import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../models/activity_model.dart';
import '../enums/periodo_dia.dart';
import '../enums/tipo_treino.dart';
import 'package:aikidomaruyama/providers/activity_provider.dart';

class ActivityPage extends StatefulWidget {
  final DateTime date;
  final ActivityModel? existingActivity;

  const ActivityPage({required this.date, this.existingActivity});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  PeriodoDoDia? selectedPeriodo;
  TipoTreino? selectedTipo;

  @override
  void initState() {
    super.initState();
    if (widget.existingActivity != null) {
      selectedPeriodo = widget.existingActivity!.periodoDoDia;
      selectedTipo = widget.existingActivity!.tipoTreino;
    }
  }

  Future<Position?> _obterLocalizacaoAtual(BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    //verificando se o serviço está habilitado
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text(
            'Serviço de localização desativado. Ative para continuar.',
          ),
        ),
      );
      return Future.error(
        'Serviço de localização desativado. Ative para continuar.',
      );
    }
    //verificando se o app tem permissão para coletar a geolocalização
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text('Permissão de localização negada.')),
        );
        return Future.error('Permissão de localização negada.');
      }
    }
    //verificando se a permissão foi negada para sempre
    if (permission == LocationPermission.deniedForever) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('Permissão de localização permanentemente negada.'),
        ),
      );
      return Future.error('Permissão de localização permanentemente negada.');
    }
    //obtendo a geolocalização
    try {
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text('Erro ao obter a localização: $e')),
      );
      return Future.error('Erro ao obter a localização: $e');
    }
  }

  void _salvar(ActivityProvider provider, double? lat, double? long) {
    if (selectedPeriodo != null && selectedTipo != null) {
      final novaAtividade = ActivityModel(
        date: widget.date,
        periodoDoDia: selectedPeriodo!,
        tipoTreino: selectedTipo!,
        latitude: lat,
        longitude: long,
      );

      // Aqui você pode usar o Provider para salvar ou atualizar
      if (widget.existingActivity == null) {
        provider.addActivity(novaAtividade);
      } else {
        provider.editActivity(widget.existingActivity!, novaAtividade);
      }
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Atividade salva')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ActivityProvider>(context);

    final isEditing = widget.existingActivity != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Atividade' : 'Nova Atividade'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: _obterLocalizacaoAtual(context),
          builder: (context, snapshot) {
            var state = snapshot.connectionState;
            if (state == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              if (snapshot.hasError) {
                return Text("Ocorreu um erro!");
              } else {
                final latitude = snapshot.data?.latitude;
                final longitude = snapshot.data?.longitude;
                return Column(
                  children: [
                    DropdownButtonFormField<PeriodoDoDia>(
                      value: selectedPeriodo,
                      items:
                          PeriodoDoDia.values
                              .map(
                                (p) => DropdownMenuItem(
                                  value: p,
                                  child: Text(p.descricao),
                                ),
                              )
                              .toList(),
                      onChanged:
                          (value) => setState(() => selectedPeriodo = value),
                      decoration: const InputDecoration(
                        labelText: 'Período do Dia',
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<TipoTreino>(
                      value: selectedTipo,
                      items:
                          TipoTreino.values
                              .map(
                                (t) => DropdownMenuItem(
                                  value: t,
                                  child: Text(t.descricao),
                                ),
                              )
                              .toList(),
                      onChanged:
                          (value) => setState(() => selectedTipo = value),
                      decoration: const InputDecoration(
                        labelText: 'Tipo de Treino',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text("Latitude: $latitude"),
                    const SizedBox(height: 16),
                    Text("Longitude: $longitude"),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () {
                        _salvar(provider, latitude, longitude);
                      },
                      child: const Text('Salvar'),
                    ),
                  ],
                );
              }
            }
          },
        ),
      ),
    );
  }
}
