import 'package:flutter/material.dart';
import '../views/calculator_page.dart';
import 'pokedex_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Menú Principal"), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // BOTÓN CALCULADORA
            SizedBox(
              width: 300,
              height: 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Calculadora 🧮",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CalculatorPage()),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            // BOTÓN POKEDEX
            SizedBox(
              width: 300,
              height: 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Pokédex 🃏",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PokedexScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
