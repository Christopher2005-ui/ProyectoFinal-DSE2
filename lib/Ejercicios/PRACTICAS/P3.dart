class Rectangulo {
  double ancho;
  double alto;

  Rectangulo(this.ancho, this.alto);

  // Propiedad derivada
  double get area => ancho * alto;

  // Propiedad derivada
  double get perimetro => 2 * (ancho + alto);

  void mostrarInformacion() {
    print('Ancho: $ancho');
    print('Alto: $alto');
    print('Área: $area');
    print('Perímetro: $perimetro');

    if (ancho == alto) {
      print('Es un cuadrado');
    } else {
      print('Es un rectángulo');
    }
  }
}

void main() {
  var r1 = Rectangulo(10, 5);
  r1.mostrarInformacion();

  print('-------------');

  var r2 = Rectangulo(4, 4);
  r2.mostrarInformacion();
}
