class cuenta {
  String _codUsuario = '', _nombre = '';
  double _monto = 0;

  cuenta(String codUsuario, String nombre, double monto) {
    _codUsuario = codUsuario;
    _nombre = nombre;
    _monto = monto;
  }

  String get codUsuario {
    return _codUsuario;
  }

  set codUsuario(String codUsuario) {
    _codUsuario = codUsuario;
  }

  String get nombre {
    return _nombre;
  }

  set nombre(String nombre) {
    _nombre = nombre;
  }


  double get monto {
    return _monto;
  }

  set monto(double monto) {
    _monto = monto;
  }
}