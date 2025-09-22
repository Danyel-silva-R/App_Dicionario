import 'package:flutter/material.dart';
import 'palavra_page.dart';

class BuscarPage extends StatefulWidget {
  const BuscarPage({super.key, this.showBackButton = true});

  final bool showBackButton;

  @override
  State<BuscarPage> createState() => _BuscarPageState();
}

class _BuscarPageState extends State<BuscarPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _resultados = [
    'Inclusão',
    'Acessibilidade',
    'Educação',
    'Tecnologia',
  ];
  String _busca = '';

  @override
  Widget build(BuildContext context) {
    List<String> filtrados =
        _resultados
            .where(
              (palavra) => palavra.toLowerCase().contains(_busca.toLowerCase()),
            )
            .toList();

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
              child:
                  _busca.isEmpty
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
                      : ListView.builder(
                        itemCount: filtrados.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: InkWell(
                              onTap:
                                  () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) => PalavraPage(
                                            palavra: filtrados[index],
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
                                      child: Text(
                                        filtrados[index],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF424242),
                                        ),
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
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
