import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'detail_screen.dart';

class PokedexScreen extends StatefulWidget {
  const PokedexScreen({super.key});

  @override
  State<PokedexScreen> createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  List results = [];
  List filtered = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPokemons();
  }

  Future<void> fetchPokemons() async {
    final url = Uri.parse("https://pokeapi.co/api/v2/pokemon?limit=100");
    final response = await http.get(url);
    final data = json.decode(response.body);

    setState(() {
      results = data['results'];
      filtered = results;
      isLoading = false;
    });
  }

  void searchPokemon(String query) {
    final search = results.where((p) {
      return p['name'].toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filtered = search;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(" Pokédex Pro"), centerTitle: true),

      body: Container(
        // 🎨 FONDO BONITO
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.deepPurple, Colors.redAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Column(
          children: [
            // 🔍 BUSCADOR BONITO
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                onChanged: searchPokemon,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Buscar Pokémon...",
                  hintStyle: const TextStyle(color: Colors.white70),
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  filled: true,
                  fillColor: Colors.white24,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // 📋 LISTA
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final pokemon = filtered[index];

                        final image =
                            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png";

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    DetailScreen(url: pokemon['url']),
                              ),
                            );
                          },

                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            padding: const EdgeInsets.all(10),

                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 5,
                                  offset: const Offset(2, 3),
                                ),
                              ],
                            ),

                            child: Row(
                              children: [
                                Image.network(image, width: 60),

                                const SizedBox(width: 15),

                                Text(
                                  pokemon['name'].toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const Spacer(),

                                const Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          ),
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
