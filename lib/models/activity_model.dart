import 'package:aikidomaruyama/enums/periodo_dia.dart';
import 'package:aikidomaruyama/enums/tipo_treino.dart';

class ActivityModel {
  DateTime date;
  PeriodoDoDia periodoDoDia;
  TipoTreino tipoTreino;

  //construtor
  ActivityModel({
    required this.date,
    required this.periodoDoDia,
    required this.tipoTreino,
  });

  ActivityModel.toMap(Map<String, dynamic> map)
    : date = map["date"],
      periodoDoDia = map["periodoDoDia"],
      tipoTreino = map["tipoTreino"];

  Map<String, dynamic> toMap() {
    return {
      "date": date,
      "periodoDoDia": periodoDoDia,
      "tipoTreino": tipoTreino,
    };
  }
}
