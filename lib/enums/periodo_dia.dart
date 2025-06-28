enum PeriodoDoDia {
  manha,
  tarde,
  noite;

  String get descricao {
    switch (this) {
      case PeriodoDoDia.manha:
        return 'Manhã';
      case PeriodoDoDia.tarde:
        return 'Tarde';
      case PeriodoDoDia.noite:
        return 'Noite';
    }
  }

  static PeriodoDoDia fromDescricao(String descricao) {
    return PeriodoDoDia.values.firstWhere(
      (periodo) => periodo.descricao.toLowerCase() == descricao.toLowerCase(),
      orElse: () => PeriodoDoDia.tarde,
    );
  }
}
