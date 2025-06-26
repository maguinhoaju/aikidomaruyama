import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/activity_model.dart';
import '../enums/periodo_dia.dart';
import '../enums/tipo_treino.dart';

final List<Activity> mockActivities = [
  // Janeiro
  Activity(
    id: '1',
    date: DateTime(2025, 1, 8),
    periodoDoDia: PeriodoDoDia.manha,
    tipoTreino: TipoTreino.kids,
  ),
  Activity(
    id: '2',
    date: DateTime(2025, 1, 10),
    periodoDoDia: PeriodoDoDia.tarde,
    tipoTreino: TipoTreino.normal,
  ),
  Activity(
    id: '3',
    date: DateTime(2025, 1, 15),
    periodoDoDia: PeriodoDoDia.noite,
    tipoTreino: TipoTreino.graduado,
  ),
  Activity(
    id: '4',
    date: DateTime(2025, 1, 19),
    periodoDoDia: PeriodoDoDia.manha,
    tipoTreino: TipoTreino.yudansha,
  ),

  // Fevereiro
  Activity(
    id: '5',
    date: DateTime(2025, 2, 5),
    periodoDoDia: PeriodoDoDia.noite,
    tipoTreino: TipoTreino.kids,
  ),
  Activity(
    id: '6',
    date: DateTime(2025, 2, 7),
    periodoDoDia: PeriodoDoDia.manha,
    tipoTreino: TipoTreino.normal,
  ),
  Activity(
    id: '7',
    date: DateTime(2025, 2, 14),
    periodoDoDia: PeriodoDoDia.tarde,
    tipoTreino: TipoTreino.graduado,
  ),
  Activity(
    id: '8',
    date: DateTime(2025, 2, 21),
    periodoDoDia: PeriodoDoDia.noite,
    tipoTreino: TipoTreino.yudansha,
  ),

  // Março
  Activity(
    id: '9',
    date: DateTime(2025, 3, 3),
    periodoDoDia: PeriodoDoDia.manha,
    tipoTreino: TipoTreino.normal,
  ),
  Activity(
    id: '10',
    date: DateTime(2025, 3, 6),
    periodoDoDia: PeriodoDoDia.tarde,
    tipoTreino: TipoTreino.graduado,
  ),
  Activity(
    id: '11',
    date: DateTime(2025, 3, 10),
    periodoDoDia: PeriodoDoDia.noite,
    tipoTreino: TipoTreino.yudansha,
  ),
  Activity(
    id: '12',
    date: DateTime(2025, 3, 13),
    periodoDoDia: PeriodoDoDia.manha,
    tipoTreino: TipoTreino.kids,
  ),
  Activity(
    id: '13',
    date: DateTime(2025, 3, 18),
    periodoDoDia: PeriodoDoDia.tarde,
    tipoTreino: TipoTreino.normal,
  ),

  // Abril
  Activity(
    id: '14',
    date: DateTime(2025, 4, 1),
    periodoDoDia: PeriodoDoDia.noite,
    tipoTreino: TipoTreino.graduado,
  ),
  Activity(
    id: '15',
    date: DateTime(2025, 4, 4),
    periodoDoDia: PeriodoDoDia.manha,
    tipoTreino: TipoTreino.yudansha,
  ),
  Activity(
    id: '16',
    date: DateTime(2025, 4, 8),
    periodoDoDia: PeriodoDoDia.tarde,
    tipoTreino: TipoTreino.kids,
  ),
  Activity(
    id: '17',
    date: DateTime(2025, 4, 15),
    periodoDoDia: PeriodoDoDia.noite,
    tipoTreino: TipoTreino.normal,
  ),
  Activity(
    id: '18',
    date: DateTime(2025, 4, 18),
    periodoDoDia: PeriodoDoDia.manha,
    tipoTreino: TipoTreino.graduado,
  ),

  // Maio
  Activity(
    id: '19',
    date: DateTime(2025, 5, 6),
    periodoDoDia: PeriodoDoDia.tarde,
    tipoTreino: TipoTreino.yudansha,
  ),
  Activity(
    id: '20',
    date: DateTime(2025, 5, 9),
    periodoDoDia: PeriodoDoDia.noite,
    tipoTreino: TipoTreino.kids,
  ),
  Activity(
    id: '21',
    date: DateTime(2025, 5, 13),
    periodoDoDia: PeriodoDoDia.manha,
    tipoTreino: TipoTreino.normal,
  ),
  Activity(
    id: '22',
    date: DateTime(2025, 5, 15),
    periodoDoDia: PeriodoDoDia.tarde,
    tipoTreino: TipoTreino.graduado,
  ),
  Activity(
    id: '23',
    date: DateTime(2025, 5, 15),
    periodoDoDia: PeriodoDoDia.noite,
    tipoTreino: TipoTreino.normal,
    latitude: 37.4239980,
    longitude: -122.0841,
  ),
  Activity(
    id: '24',
    date: DateTime(2025, 5, 17),
    periodoDoDia: PeriodoDoDia.manha,
    tipoTreino: TipoTreino.normal,
    latitude: 37.4119981,
    longitude: -122.082,
  ),
  Activity(
    id: '25',
    date: DateTime(2025, 5, 17),
    periodoDoDia: PeriodoDoDia.noite,
    tipoTreino: TipoTreino.normal,
    latitude: 37.5219991,
    longitude: -122.0861,
  ),
  Activity(
    id: '26',
    date: DateTime(2025, 5, 17),
    periodoDoDia: PeriodoDoDia.noite,
    tipoTreino: TipoTreino.yudansha,
    latitude: 37.4219983,
    longitude: -121.084,
  ),
];
