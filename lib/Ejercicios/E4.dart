class Vehiculo {
  final String marca;
  final String modelo;

  // Constructor con parámetros nombrados y obligatorios
  Vehiculo({required this.marca, required this.modelo});

  void mostrarInfo() => print('Vehículo: $marca $modelo');
}

void main() {
  final miAuto = Vehiculo(marca: 'Toyota', modelo: 'Corolla');
  miAuto.mostrarInfo();
}
