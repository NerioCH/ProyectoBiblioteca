class autor {
  String _apellidos = '', _nombres = '';

  autor(String nombres, String apellidos) {
    _apellidos = apellidos;
    _nombres = nombres;
  }

  String get apellidos {
    return _apellidos;
  }

  set apellidos(String apellidos) {
    _apellidos = apellidos;
  }

  String get nombres {
    return _nombres;
  }

  set nombres(String nombres) {
    _nombres = nombres;
  }
}
