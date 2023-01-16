class prestamo {
  String _codUsuario = '', _codLibro = '', _distrito = '', _fechaSolicitud = '', _fechaPrestamo = '', _fechaDevolucion = '', _estado = '';
  double _multa = 0;

  prestamo(
    String codUsuario,
    String codLibro,
    String distrito,
    String fechaSolicitud,
    String fechaPrestamo,
    String fechaDevolucion,
    String estado,
    double multa) {
    _codUsuario = codUsuario;
    _codLibro = codLibro;
    _distrito =  distrito;
    _fechaSolicitud = fechaSolicitud;
    _fechaPrestamo = fechaPrestamo;
    _fechaDevolucion = fechaDevolucion;
    _estado = estado;
    _multa = multa;
  }

  String get codUsuario {
    return _codUsuario;
  }

  set codUsuario(String codUsuario) {
    _codUsuario = codUsuario;
  }

  String get codLibro {
    return _codLibro;
  }

  set codLibro(String codLibro) {
    _codLibro = codLibro;
  }
  String get distrito {
    return _distrito;
  }

  set distrito(String distrito) {
    _distrito = distrito;
  }

  String get fechaSolicitud {
    return _fechaSolicitud;
  }

  set fechaSolicitud(String fechaSolicitud) {
    _fechaSolicitud = fechaSolicitud;
  }
  String get fechaPrestamo {
    return _fechaPrestamo;
  }

  set fechaPrestamo(String fechaPrestamo) {
    _fechaPrestamo = fechaPrestamo;
  }
  String get fechaDevolucion{
    return _fechaDevolucion;
  }

  set fechaDevolucion(String fechaDevolucion) {
    _fechaDevolucion= fechaDevolucion;
  }
  String get estado {
    return _estado;
  }

  set estado(String estado) {
    _estado = estado;
  }


  double get multa {
    return _multa;
  }

  set multa(double multa) {
    _multa = multa;
  }
}