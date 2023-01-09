class usuario {
  String _nombres = '', _apellidos = '';
  String _fechaNacimiento = '', _genero = '';

  usuario(String nombres, String apellidos) {
    _nombres = nombres;
    _apellidos = apellidos;
  }

  String get nombres {
    return _nombres;
  }

  set nombres(String nombres) {
    _nombres = nombres;
  }

  String get apellidos {
    return _apellidos;
  }

  set apellidos(String apellidos) {
    _apellidos = apellidos;
  }

  String get fechaNacimiento {
    return _fechaNacimiento;
  }

  set fechaNacimiento(String fechaNacimiento) {
    _fechaNacimiento = fechaNacimiento;
  }

  String get genero {
    return _genero;
  }

  set genero(String genero) {
    _genero = genero;
  }
}