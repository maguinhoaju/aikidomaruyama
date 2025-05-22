enum TipoTreino {
  kids,
  normal,
  graduado,
  yudansha;

  String get descricao {
    switch (this) {
      case TipoTreino.kids:
        return 'Kids';
      case TipoTreino.normal:
        return 'Normal';
      case TipoTreino.graduado:
        return 'Graduado';
      case TipoTreino.yudansha:
        return 'Yudansha';
    }
  }
}
