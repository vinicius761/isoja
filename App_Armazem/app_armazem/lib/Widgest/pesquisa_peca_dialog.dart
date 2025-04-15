import 'package:flutter/material.dart';
import 'package:app_armazem/Model/peca.dart';

class PesquisaPecaDialog extends StatefulWidget {
  final List<Peca> pecasDisponiveis;

  const PesquisaPecaDialog({Key? key, required this.pecasDisponiveis})
    : super(key: key);

  @override
  _PesquisaPecaDialogState createState() => _PesquisaPecaDialogState();
}

class _PesquisaPecaDialogState extends State<PesquisaPecaDialog> {
  final _searchController = TextEditingController();
  List<Peca> _pecasFiltradas = [];

  @override
  void initState() {
    super.initState();
    _pecasFiltradas = widget.pecasDisponiveis;
    _searchController.addListener(_filtrarPecas);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filtrarPecas() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _pecasFiltradas =
          widget.pecasDisponiveis.where((peca) {
            return peca.codigo.toLowerCase().contains(query) ||
                peca.descricao.toLowerCase().contains(query);
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: BoxConstraints(maxHeight: 500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Pesquisar Peça',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Pesquisar por código ou descrição',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child:
                  _pecasFiltradas.isEmpty
                      ? Center(child: Text('Nenhuma peça encontrada'))
                      : ListView.builder(
                        itemCount: _pecasFiltradas.length,
                        itemBuilder: (context, index) {
                          final peca = _pecasFiltradas[index];
                          return ListTile(
                            title: Text('${peca.codigo} - ${peca.descricao}'),
                            onTap: () {
                              Navigator.of(context).pop(peca);
                            },
                          );
                        },
                      ),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar'),
            ),
          ],
        ),
      ),
    );
  }
}
