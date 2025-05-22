import 'package:aikidomaruyama/enums/periodo_dia.dart';
import 'package:aikidomaruyama/enums/tipo_treino.dart';

class ActivityModel {
  DateTime date;
  PeriodoDoDia periodoDoDia;
  TipoTreino tipoTreino;
  double? latitude;
  double? longitude;

  // Construtor
  ActivityModel({
    required this.date,
    required this.periodoDoDia,
    required this.tipoTreino,
    this.latitude,
    this.longitude,
  });

  // fromMap
  ActivityModel.toMap(Map<String, dynamic> map)
    : date = map["date"],
      periodoDoDia = map["periodoDoDia"],
      tipoTreino = map["tipoTreino"],
      latitude = map["latitude"],
      longitude = map["longitude"];

  // toMap
  Map<String, dynamic> toMap() {
    return {
      "date": date,
      "periodoDoDia": periodoDoDia,
      "tipoTreino": tipoTreino,
      "latitude": latitude,
      "longitude": longitude,
    };
  }
}
