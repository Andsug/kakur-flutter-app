
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const KakurApp());
}

class KakurApp extends StatelessWidget {
  const KakurApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Kakur Inglés',
      debugShowCheckedModeBanner: false,
      home: VocabularyScreen(),
    );
  }
}

class VocabularyScreen extends StatefulWidget {
  const VocabularyScreen({super.key});

  @override
  State<VocabularyScreen> createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  List<dynamic> palabras = [];
  int index = 0;
  bool showSpanish = false;
  bool showEnglish = false;

  @override
  void initState() {
    super.initState();
    loadJSON();
  }

  Future<void> loadJSON() async {
    final String response = await rootBundle.loadString('assets/pagina_9_vocabulario.json');
    final data = await json.decode(response);
    setState(() {
      palabras = data;
    });
  }

  void nextWord() {
    setState(() {
      index = (index + 1) % palabras.length;
      showSpanish = false;
      showEnglish = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (palabras.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final palabra = palabras[index];

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      showEnglish ? palabra["ingles"] : "👈",
                      style: const TextStyle(fontSize: 22, color: Colors.green),
                    ),
                    Text(
                      showEnglish ? palabra["pronunciacion"] : "",
                      style: const TextStyle(fontSize: 22, color: Colors.orange),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showEnglish = true;
                        });
                      },
                      child: const Text("👈"),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      showSpanish ? palabra["español"] : "👉",
                      style: const TextStyle(fontSize: 22, color: Colors.blue),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showSpanish = true;
                        });
                      },
                      child: const Text("👉"),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: nextWord,
              child: const Text("Siguiente"),
            )
          ],
        ),
      ),
    );
  }
}
