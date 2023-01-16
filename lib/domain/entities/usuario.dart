class usuario {
  String _nombres = '', _apellidos = '', _urlImage = '';
  String _dni = '', _estado = '', _tipo = '', _correo = '';

  usuario(String nombres, String apellidos, String dni, String estado,
      String tipo, String correo, String urlImage) {
    _nombres = nombres;
    _apellidos = apellidos;
    _dni = dni;
    _estado = estado;
    _tipo = tipo;
    _correo = correo;
    _urlImage = urlImage;
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

  String get dni {
    return _dni;
  }

  set dni(String dni) {
    _dni = dni;
  }

  String get estado {
    return _estado;
  }

  set estado(String estado) {
    _estado = estado;
  }

  String get tipo {
    return _tipo;
  }

  set tipo(String tipo) {
    _tipo = tipo;
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
