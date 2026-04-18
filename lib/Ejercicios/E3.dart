void main() {
  Map<String, double> carrito = {
    'Laptop': 1200.0,
    'Mouse': 25.0,
    'Teclado': 45.0,
  };

  // Iterar sobre un mapa para aplicar descuento
  carrito.forEach((producto, precio) {
    double precioConDescuento = precio * 0.90;
    print('$producto: \$${precioConDescuento.toStringAsFixed(2)}');
  });
}
