import 'package:flutter/material.dart';
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

  void _salvar(ActivityProvider provider) {
    if (selectedPeriodo != null && selectedTipo != null) {
      final novaAtividade = ActivityModel(
        date: widget.date,
        periodoDoDia: selectedPeriodo!,
        tipoTreino: selectedTipo!,
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
        child: Column(
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
              onChanged: (value) => setState(() => selectedPeriodo = value),
              decoration: const InputDecoration(labelText: 'Período do Dia'),
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
              onChanged: (value) => setState(() => selectedTipo = value),
              decoration: const InputDecoration(labelText: 'Tipo de Treino'),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                _salvar(provider);
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
