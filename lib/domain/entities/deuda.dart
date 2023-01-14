class deuda {
  String _codUsuario = '', _titulo = '', _detalles = '', _fechaLimite = '';
  double _monto = 0;

  deuda(String codUsuario, String titulo, String detalles, String fechaLimite, double monto) {
    _codUsuario = codUsuario;
    _titulo = titulo;
    _detalles =  detalles;
    _fechaLimite = fechaLimite;
    _monto = monto;
  }

  String get codUsuario {
    return _codUsuario;
  }

  set codUsuario(String codUsuario) {
    _codUsuario = codUsuario;
  }

  String get titulo {
    return _titulo;
  }

  set titulo(String titulo) {
    _titulo = titulo;
  }
  String get detalles {
    return _detalles;
  }

  set detalles(String detalles) {
    _detalles = detalles;
  }
  String get fechaLimite {
    return _fechaLimite;
  }

  set fechaLimite(String fechaLimite) {
    _fechaLimite = fechaLimite;
  }

  double get monto {
    return _monto;
  }

  set monto(double monto) {
    _monto = monto;
  }
}