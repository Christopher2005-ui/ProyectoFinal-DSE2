import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailScreen extends StatefulWidget {
  final String url;

  const DetailScreen({super.key, required this.url});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Map data = {};
  String description = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAllData();
  }

  Future<void> fetchAllData() async {
    final response = await http.get(Uri.parse(widget.url));
    final result = json.decode(response.body);

    final speciesResponse = await http.get(Uri.parse(result['species']['url']));
    final speciesData = json.decode(speciesResponse.body);

    final flavor = speciesData['flavor_text_entries'].firstWhere(
      (entry) => entry['language']['name'] == 'es',
      orElse: () => speciesData['flavor_text_entries'][0],
    );

    setState(() {
      data = result;
      description = flavor['flavor_text']
          .replaceAll('\n', ' ')
          .replaceAll('\f', ' ');
      isLoading = false;
    });
  }

  Color getTypeColor(String type) {
    switch (type) {
      case "fire":
        return Colors.red;
      case "water":
        return Colors.blue;
      case "grass":
        return Colors.green;
      case "electric":
        return Colors.amber;
      case "psychic":
        return Colors.pink;
      case "ghost":
        return Colors.deepPurple;
      case "dragon":
        return Colors.indigo;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final image = data['sprites']['other']['official-artwork']['front_default'];

    final types = (data['types'] as List)
        .map((t) => t['type']['name'])
        .toList();

    final stats = data['stats'];

    final mainColor = getTypeColor(types[0]);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [mainColor, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [
              // 🔙 BOTÓN VOLVER
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              const SizedBox(height: 10),

              // 🖼 IMAGEN
              Image.network(image, height: 200),

              const SizedBox(height: 10),

              // 🧾 NOMBRE
              Text(
                data['name'].toUpperCase(),
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              // 🧬 TIPOS
              Wrap(
                spacing: 10,
                children: types
                    .map(
                      (t) => Chip(
                        label: Text(t.toUpperCase()),
                        backgroundColor: Colors.white,
                      ),
                    )
                    .toList(),
              ),

              const SizedBox(height: 20),

              // 📦 TARJETA GLASS
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),

                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 📖 DESCRIPCIÓN
                        const Text(
                          "Descripción",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          description,
                          style: const TextStyle(color: Colors.white70),
                        ),

                        const SizedBox(height: 20),

                        // 📊 STATS
                        const Text(
                          "Estadísticas",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        buildStat("HP", stats[0]['base_stat']),
                        buildStat("Ataque", stats[1]['base_stat']),
                        buildStat("Defensa", stats[2]['base_stat']),
                        buildStat("Velocidad", stats[5]['base_stat']),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStat(String name, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$name: $value", style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: value / 150,
              minHeight: 8,
              backgroundColor: Colors.white24,
              color: Colors.greenAccent,
            ),
          ),
        ],
      ),
    );
  }
}
