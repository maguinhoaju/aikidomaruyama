import '../models/activity_model.dart';
import '../enums/periodo_dia.dart';
import '../enums/tipo_treino.dart';

final List<ActivityModel> mockActivities = [
  // Janeiro
  ActivityModel(
    date: DateTime(2025, 1, 8),
    periodoDoDia: PeriodoDoDia.manha,
    tipoTreino: TipoTreino.kids,
  ),
  ActivityModel(
    date: DateTime(2025, 1, 10),
    periodoDoDia: PeriodoDoDia.tarde,
    tipoTreino: TipoTreino.normal,
  ),
  ActivityModel(
    date: DateTime(2025, 1, 15),
    periodoDoDia: PeriodoDoDia.noite,
    tipoTreino: TipoTreino.graduado,
  ),
  ActivityModel(
    date: DateTime(2025, 1, 19),
    periodoDoDia: PeriodoDoDia.manha,
    tipoTreino: TipoTreino.yudansha,
  ),

  // Fevereiro
  ActivityModel(
    date: DateTime(2025, 2, 5),
    periodoDoDia: PeriodoDoDia.noite,
    tipoTreino: TipoTreino.kids,
  ),
  ActivityModel(
    date: DateTime(2025, 2, 7),
    periodoDoDia: PeriodoDoDia.manha,
    tipoTreino: TipoTreino.normal,
  ),
  ActivityModel(
    date: DateTime(2025, 2, 14),
    periodoDoDia: PeriodoDoDia.tarde,
    tipoTreino: TipoTreino.graduado,
  ),
  ActivityModel(
    date: DateTime(2025, 2, 21),
    periodoDoDia: PeriodoDoDia.noite,
    tipoTreino: TipoTreino.yudansha,
  ),

  // Março
  ActivityModel(
    date: DateTime(2025, 3, 3),
    periodoDoDia: PeriodoDoDia.manha,
    tipoTreino: TipoTreino.normal,
  ),
  ActivityModel(
    date: DateTime(2025, 3, 6),
    periodoDoDia: PeriodoDoDia.tarde,
    tipoTreino: TipoTreino.graduado,
  ),
  ActivityModel(
    date: DateTime(2025, 3, 10),
    periodoDoDia: PeriodoDoDia.noite,
    tipoTreino: TipoTreino.yudansha,
  ),
  ActivityModel(
    date: DateTime(2025, 3, 13),
    periodoDoDia: PeriodoDoDia.manha,
    tipoTreino: TipoTreino.kids,
  ),
  ActivityModel(
    date: DateTime(2025, 3, 18),
    periodoDoDia: PeriodoDoDia.tarde,
    tipoTreino: TipoTreino.normal,
  ),

  // Abril
  ActivityModel(
    date: DateTime(2025, 4, 1),
    periodoDoDia: PeriodoDoDia.noite,
    tipoTreino: TipoTreino.graduado,
  ),
  ActivityModel(
    date: DateTime(2025, 4, 4),
    periodoDoDia: PeriodoDoDia.manha,
    tipoTreino: TipoTreino.yudansha,
  ),
  ActivityModel(
    date: DateTime(2025, 4, 8),
    periodoDoDia: PeriodoDoDia.tarde,
    tipoTreino: TipoTreino.kids,
  ),
  ActivityModel(
    date: DateTime(2025, 4, 15),
    periodoDoDia: PeriodoDoDia.noite,
    tipoTreino: TipoTreino.normal,
  ),
  ActivityModel(
    date: DateTime(2025, 4, 18),
    periodoDoDia: PeriodoDoDia.manha,
    tipoTreino: TipoTreino.graduado,
  ),

  // Maio (mês atual)
  ActivityModel(
    date: DateTime(2025, 5, 6),
    periodoDoDia: PeriodoDoDia.tarde,
    tipoTreino: TipoTreino.yudansha,
  ),
  ActivityModel(
    date: DateTime(2025, 5, 9),
    periodoDoDia: PeriodoDoDia.noite,
    tipoTreino: TipoTreino.kids,
  ),
  ActivityModel(
    date: DateTime(2025, 5, 13),
    periodoDoDia: PeriodoDoDia.manha,
    tipoTreino: TipoTreino.normal,
  ),
  ActivityModel(
    date: DateTime(2025, 5, 15),
    periodoDoDia: PeriodoDoDia.tarde,
    tipoTreino: TipoTreino.graduado,
  ),
  ActivityModel(
    date: DateTime(2025, 5, 17),
    periodoDoDia: PeriodoDoDia.noite,
    tipoTreino: TipoTreino.yudansha,
  ),
];
