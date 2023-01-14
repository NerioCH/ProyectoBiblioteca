class transaccion {
  String _codUsuario = '', _codCuenta = '', _fecha = '', _tipo = '', _detalles = '', _categoria = '';
  double _monto = 0;

  transaccion(String codUsuario, String codCuenta, String fecha, String tipo, String detalles, String categoria, double monto) {
    _codUsuario = codUsuario;
    _codCuenta = codCuenta;
    _fecha = fecha;
    _tipo = tipo;
    _detalles = detalles;
    _categoria = categoria;
    _monto = monto;
  }

  String get codUsuario {
    return _codUsuario;
  }

  set codUsuario(String codUsuario) {
    _codUsuario = codUsuario;
  }

  String get codCuenta {
    return _codCuenta;
  }

  set codCuenta(String codCuenta) {
    _codCuenta = codCuenta;
  }

  String get fecha {
    return _fecha;
  }

  set fecha(String fecha) {
    _fecha = fecha;
  }

  String get tipo {
    return _tipo;
  }

  set tipo(String tipo) {
    _tipo = tipo;
  }

  String get detalles {
    return _detalles;
  }

  set detalles(String detalles) {
    _detalles = detalles;
  }

  double get monto {
    return _monto;
  }

  set monto(double monto) {
    _monto = monto;
  }

  String get categoria {
    return _categoria;
  }

  set categoria(String categoria) {
    _categoria = categoria;
  }
}