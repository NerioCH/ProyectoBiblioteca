class usuario {
  String _nombres = '', _apellidos = '', _urlImage = '';
  String _fechaNacimiento = '', _genero = '', _correo = '';

  usuario(String nombres, String apellidos, String fechaNacimiento, String genero, String correo, String urlImage) {
    _nombres = nombres;
    _apellidos = apellidos;
    _fechaNacimiento = fechaNacimiento;
    _genero = genero;
    _correo = correo;
    _urlImage =urlImage;
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

  String get correo {
    return _correo;
  }

  set correo(String correo) {
    _correo = correo;
  }

  String get urlImage {
    return _urlImage;
  }

  set urlImage(String urlImage) {
    _urlImage = urlImage;
  }
}