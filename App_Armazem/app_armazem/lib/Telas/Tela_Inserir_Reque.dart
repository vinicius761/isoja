import 'package:app_armazem/Widgest/pesquisa_peca_dialog.dart';
import 'package:flutter/material.dart';
import 'package:app_armazem/Model/peca.dart';
import 'package:app_armazem/Model/requisicao.dart';
import 'package:intl/intl.dart';

class NovaRequisicaoScreen extends StatefulWidget {
  @override
  _NovaRequisicaoScreenState createState() => _NovaRequisicaoScreenState();
}

class _NovaRequisicaoScreenState extends State<NovaRequisicaoScreen> {
  final _formKey = GlobalKey<FormState>();
  final Requisicao _novaRequisicao = Requisicao.nova();
  final List<Peca> _pecasAdicionadas = [];
  final _pecaController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _observacaoController = TextEditingController();
  final _quantidadeController = TextEditingController(text: '1');
  final List<Peca> _pecasDisponiveis = [
    Peca(codigo: 'P001', descricao: 'Parafuso sextavado', quantidade: 1),
    Peca(codigo: 'P002', descricao: 'Porca M6', quantidade: 1),
    Peca(codigo: 'P003', descricao: 'Arruela plana', quantidade: 1),
    Peca(codigo: 'P004', descricao: 'Parafuso auto-atarraxante', quantidade: 1),
    Peca(codigo: 'P005', descricao: 'Bucha plástica', quantidade: 1),
  ];

  @override
  void dispose() {
    _pecaController.dispose();
    _descricaoController.dispose();
    _observacaoController.dispose();
    _quantidadeController.dispose();
    super.dispose();
  }

  void _adicionarPeca() {
    if (_pecaController.text.isEmpty || _descricaoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preencha o código e descrição da peça')),
      );
      return;
    }

    setState(() {
      _pecasAdicionadas.add(
        Peca(
          codigo: _pecaController.text,
          descricao: _descricaoController.text,
          quantidade: int.tryParse(_quantidadeController.text) ?? 1,
        ),
      );
      _pecaController.clear();
      _descricaoController.clear();
      _quantidadeController.text = '1';
    });
  }

  void _removerPeca(int index) {
    setState(() {
      _pecasAdicionadas.removeAt(index);
    });
  }

  void _alterarQuantidade(int index, int novaQuantidade) {
    if (novaQuantidade < 1) return;

    setState(() {
      _pecasAdicionadas[index] = _pecasAdicionadas[index].copyWith(
        quantidade: novaQuantidade,
      );
    });
  }

  void _salvarRequisicao() {
    if (_pecasAdicionadas.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Adicione pelo menos uma peça')));
      return;
    }

    // Atualiza a requisição com os dados
    _novaRequisicao.pecas.addAll(_pecasAdicionadas);
    // _novaRequisicao.observacao = _observacaoController.text;

    // Aqui você adicionaria a lógica para salvar a requisição
    print('Requisição salva: $_novaRequisicao');

    Navigator.of(context).pop(_novaRequisicao);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Requisição'),
        actions: [
          IconButton(icon: Icon(Icons.save), onPressed: _salvarRequisicao),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildInfoRequisicao(),
                SizedBox(height: 20),
                _buildFormPeca(),
                SizedBox(height: 20),
                _buildListaPecas(),
                SizedBox(height: 20),
                _buildCampoObservacao(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRequisicao() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Requisição #${_novaRequisicao.id}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Data: ${DateFormat('dd/MM/yyyy HH:mm').format(_novaRequisicao.data)}',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormPeca() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Adicionar Peça',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _pecaController,
              decoration: InputDecoration(
                labelText: 'Código da Peça',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.confirmation_number),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    final pecaSelecionada = await showDialog<Peca>(
                      context: context,
                      builder:
                          (context) => PesquisaPecaDialog(
                            pecasDisponiveis: _pecasDisponiveis,
                          ),
                    );

                    if (pecaSelecionada != null) {
                      setState(() {
                        _pecaController.text = pecaSelecionada.codigo;
                        _descricaoController.text = pecaSelecionada.descricao;
                      });
                    }
                  },
                ),
              ),
              readOnly: true,
              onTap: () async {
                final pecaSelecionada = await showDialog<Peca>(
                  context: context,
                  builder:
                      (context) => PesquisaPecaDialog(
                        pecasDisponiveis: _pecasDisponiveis,
                      ),
                );

                if (pecaSelecionada != null) {
                  setState(() {
                    _pecaController.text = pecaSelecionada.codigo;
                    _descricaoController.text = pecaSelecionada.descricao;
                  });
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe o código';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _pecaController,
              decoration: InputDecoration(
                labelText: 'Código da Peça',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.confirmation_number),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    final pecaSelecionada = await showDialog<Peca>(
                      context: context,
                      builder:
                          (context) => PesquisaPecaDialog(
                            pecasDisponiveis: _pecasDisponiveis,
                          ),
                    );

                    if (pecaSelecionada != null) {
                      setState(() {
                        _pecaController.text = pecaSelecionada.codigo;
                        _descricaoController.text = pecaSelecionada.descricao;
                      });
                    }
                  },
                ),
              ),
              readOnly: true, // Impede edição manual
              onTap: () async {
                final pecaSelecionada = await showDialog<Peca>(
                  context: context,
                  builder:
                      (context) => PesquisaPecaDialog(
                        pecasDisponiveis: _pecasDisponiveis,
                      ),
                );

                if (pecaSelecionada != null) {
                  setState(() {
                    _pecaController.text = pecaSelecionada.codigo;
                    _descricaoController.text = pecaSelecionada.descricao;
                  });
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe o código';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text('Quantidade:', style: TextStyle(fontSize: 16)),
                ),
                _buildContadorQuantidade(),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _adicionarPeca,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('Adicionar Peça'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContadorQuantidade() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              final current = int.tryParse(_quantidadeController.text) ?? 1;
              if (current > 1) {
                setState(() {
                  _quantidadeController.text = (current - 1).toString();
                });
              }
            },
          ),
          SizedBox(
            width: 40,
            child: TextField(
              controller: _quantidadeController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: (value) {
                if (value.isEmpty) {
                  _quantidadeController.text = '1';
                }
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              final current = int.tryParse(_quantidadeController.text) ?? 1;
              setState(() {
                _quantidadeController.text = (current + 1).toString();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildListaPecas() {
    if (_pecasAdicionadas.isEmpty) {
      return Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              'Nenhuma peça adicionada',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      );
    }

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Peças Adicionadas',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _pecasAdicionadas.length,
              itemBuilder: (context, index) {
                final peca = _pecasAdicionadas[index];
                return ListTile(
                  title: Text('${peca.codigo} - ${peca.descricao}'),
                  subtitle: Text('Quantidade: ${peca.quantidade}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.remove_circle_outline,
                          color: Colors.red,
                        ),
                        onPressed:
                            () =>
                                _alterarQuantidade(index, peca.quantidade - 1),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.add_circle_outline,
                          color: Colors.green,
                        ),
                        onPressed:
                            () =>
                                _alterarQuantidade(index, peca.quantidade + 1),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.grey),
                        onPressed: () => _removerPeca(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCampoObservacao() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Observações',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _observacaoController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Informações adicionais...',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
