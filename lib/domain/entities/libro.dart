class libro {
  String _nombre = '', _autor = '', _categoria = '', _urlImage = '', _isbn = '';
  int _numCopias = 0;

  libro(String nombre, String autor, String categoria, String isbn, int numCopias, String urlImage) {
    _nombre = nombre;
    _autor = autor;
    _categoria = categoria;
    _isbn = isbn;
    _numCopias = numCopias;
    _urlImage =urlImage;
  }

  String get nombre {
    return _nombre;
  }

  set nombre(String nombre) {
    _nombre = nombre;
  }

  String get autor {
    return _autor;
  }

  set autor(String autor) {
    _autor = autor;
  }

  String get categoria {
    return _categoria;
  }

  set categoria(String categoria) {
    _categoria = categoria;
  }

  String get isbn {
    return _isbn;
  }

  set isbn(String isbn) {
    _isbn = isbn;
  }

  int get numCopias {
    return _numCopias;
  }

  set numCopias(int numCopias) {
    _numCopias = numCopias;
  }

  String get urlImage {
    return _urlImage;
  }

  set urlImage(String urlImage) {
    _urlImage = urlImage;
  }
}