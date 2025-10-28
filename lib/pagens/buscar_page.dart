import 'package:flutter/material.dart';
import 'palavra_page.dart';
import 'package:dicionario_assurini/data/repositories/tupi_repository.dart';

class BuscarPage extends StatefulWidget {
  const BuscarPage({super.key, this.showBackButton = true});

  final bool showBackButton;

  @override
  State<BuscarPage> createState() => _BuscarPageState();
}

class _BuscarPageState extends State<BuscarPage> {
  final TextEditingController _controller = TextEditingController();
  String _busca = '';
  final _repo = TupiRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E9E1),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _controller,
                onChanged: (value) => setState(() => _busca = value),
                decoration: InputDecoration(
                  hintText: 'Digite a palavra...',
                  hintStyle: const TextStyle(color: Color(0xFF9E9E9E)),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFF654321),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: _busca.isEmpty
                  ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              size: 80,
                              color: Color(0xFF9E9E9E),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Digite algo para buscar',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF9E9E9E),
                              ),
                            ),
                          ],
                        ),
                      )
                  : FutureBuilder<List<Map<String, String>>>(
                      future: _repo.searchPalavras(_busca),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'Erro ao buscar: ${snapshot.error}',
                              style: const TextStyle(color: Colors.red),
                            ),
                          );
                        }
                        final resultados = snapshot.data ?? [];
                        if (resultados.isEmpty) {
                          return const Center(child: Text('Nenhum resultado'));
                        }
                        return ListView.builder(
                          itemCount: resultados.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => PalavraPage(
                                      palavra: resultados[index]['tupi'] ?? '',
                                    ),
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              resultados[index]['tupi'] ?? '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF424242),
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              resultados[index]['portugues'] ?? '',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF757575),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Color(0xFF9E9E9E),
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
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
