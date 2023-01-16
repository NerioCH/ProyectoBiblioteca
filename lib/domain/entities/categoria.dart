class categoria {
  String _codUsuario = '', _nombre = '', _tipo = '';

  categoria(String nombre) {
    _codUsuario = codUsuario;
    _nombre = nombre;
    _tipo = tipo;
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


  String get tipo {
    return _tipo;
  }

  set tipo(String tipo) {
    _tipo = tipo;
  }
}