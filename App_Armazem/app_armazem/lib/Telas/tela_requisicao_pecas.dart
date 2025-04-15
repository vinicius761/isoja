import 'package:app_armazem/Telas/Tela_Inserir_Reque.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:intl/intl.dart';

// Importações das classes modelo (ajuste os caminhos conforme sua estrutura)
import 'package:app_armazem/Model/filial.dart';
import 'package:app_armazem/Model/peca.dart';
import 'package:app_armazem/Model/requisicao.dart';

class TelaRequisicaoPecas extends StatefulWidget {
  @override
  _TelaRequisicaoPecasState createState() => _TelaRequisicaoPecasState();
}

class _TelaRequisicaoPecasState extends State<TelaRequisicaoPecas> {
  final DateFormat _formatadorData = DateFormat('dd/MM/yyyy');
  DateTime? _dataInicio;
  DateTime? _dataFim;
  String? _filialSelecionada;
  List<Requisicao> _requisicoes = [];
  List<Filial> _filiais = [];
  bool _carregando = false;

  @override
  void initState() {
    super.initState();
    _carregarDadosIniciais();
  }

  Future<void> _carregarDadosIniciais() async {
    setState(() => _carregando = true);

    // Simulação de carregamento - substitua pela sua implementação real
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _filiais = [
        Filial(codigo: '001', nome: 'Buriti'),
        Filial(codigo: '002', nome: 'Nova Chapada'),
      ];
      final List<Peca> _pecasDisponiveis = [
        Peca(codigo: 'P001', descricao: 'Parafuso sextavado', quantidade: 1),
        Peca(codigo: 'P002', descricao: 'Porca M6', quantidade: 1),
        Peca(codigo: 'P003', descricao: 'Arruela plana', quantidade: 1),
        Peca(
          codigo: 'P004',
          descricao: 'Parafuso auto-atarraxante',
          quantidade: 1,
        ),
        Peca(codigo: 'P005', descricao: 'Bucha plástica', quantidade: 1),
      ];
      _requisicoes = [
        Requisicao(
          id: 'REQ-001',
          data: DateTime.now().subtract(Duration(days: 2)),
          filial: '001',
          solicitante: 'João Silva',
          status: 'Aprovado',
          pecas: [
            Peca(
              codigo: 'P001',
              descricao: 'Parafuso sextavado',
              quantidade: 50,
            ),
            Peca(codigo: 'P002', descricao: 'Porca M6', quantidade: 100),
          ],
        ),
      ];

      _filialSelecionada = _filiais.isNotEmpty ? _filiais.first.codigo : null;
      _carregando = false;
    });
  }

  void _mostrarSeletorData(bool dataInicial) {
    DatePicker.showDatePicker(
      context,
      locale: DateTimePickerLocale.pt_br,
      dateFormat: 'dd-MMMM-yyyy',
      initialDateTime:
          dataInicial
              ? _dataInicio ?? DateTime.now()
              : (_dataFim ?? _dataInicio ?? DateTime.now()),
      minDateTime: dataInicial ? null : _dataInicio,
      maxDateTime: dataInicial ? _dataFim : null,
      onConfirm: (DateTime dateTime, List<int> index) {
        setState(() {
          if (dataInicial) {
            _dataInicio = dateTime;
            if (_dataFim == null || _dataFim!.isBefore(dateTime)) {
              _dataFim = dateTime.add(Duration(days: 1));
            }
          } else {
            _dataFim = dateTime;
          }
        });
        _filtrarRequisicoes();
      },
      pickerTheme: DateTimePickerTheme(
        backgroundColor: Colors.white,
        itemTextStyle: TextStyle(color: Colors.black, fontSize: 18),
        confirm: Text('Confirmar', style: TextStyle(color: Colors.blue)),
        cancel: Text('Cancelar', style: TextStyle(color: Colors.grey)),
      ),
    );
  }

  void _filtrarRequisicoes() {
    // Implemente sua lógica de filtro real aqui
    print(
      'Filtrando por: DataInicio=$_dataInicio, DataFim=$_dataFim, Filial=$_filialSelecionada',
    );
  }

  Future<void> _adicionarNovaRequisicao() async {
    final novaRequisicao = await Navigator.of(context).push<Requisicao>(
      MaterialPageRoute(builder: (context) => NovaRequisicaoScreen()),
    );

    if (novaRequisicao != null) {
      // Adicione a nova requisição à lista
      setState(() {
        _requisicoes.add(novaRequisicao);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Requisição adicionada com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _construirMenuLateral(),
      appBar: AppBar(
        title: Text('Requisições de Peças'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _adicionarNovaRequisicao,
            tooltip: 'Nova requisição',
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _carregarDadosIniciais,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFiltros(),
          Expanded(
            child:
                _carregando
                    ? Center(child: CircularProgressIndicator())
                    : _buildTabelaRequisicoes(),
          ),
        ],
      ),
    );
  }

  Widget _construirMenuLateral() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Início'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configurações'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sair'),
            onTap: () {
              Navigator.pop(context);
              // Adicione sua lógica de logout aqui
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFiltros() {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildDatePickerField(
                    label: 'Data Inicial',
                    date: _dataInicio,
                    onTap: () => _mostrarSeletorData(true),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: _buildDatePickerField(
                    label: 'Data Final',
                    date: _dataFim,
                    onTap: () => _mostrarSeletorData(false),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            _buildFilialDropdown(),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePickerField({
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date != null ? _formatadorData.format(date) : 'Selecione',
              style: TextStyle(fontSize: 16),
            ),
            Icon(Icons.calendar_today, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFilialDropdown() {
    return DropdownButtonFormField<String>(
      value: _filialSelecionada,
      decoration: InputDecoration(
        labelText: 'Filial',
        border: OutlineInputBorder(),
      ),
      items:
          _filiais.map((filial) {
            return DropdownMenuItem<String>(
              value: filial.codigo,
              child: Text('${filial.codigo} - ${filial.nome}'),
            );
          }).toList(),
      onChanged: (String? value) {
        if (value != null) {
          setState(() => _filialSelecionada = value);
          _filtrarRequisicoes();
        }
      },
    );
  }

  Widget _buildTabelaRequisicoes() {
    if (_requisicoes.isEmpty) {
      return Center(child: Text('Nenhuma requisição encontrada'));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Data')),
          DataColumn(label: Text('Filial')),
          DataColumn(label: Text('Solicitante')),
          DataColumn(label: Text('Qtd. Peças')),
          DataColumn(label: Text('Status')),
        ],
        rows:
            _requisicoes.map((requisicao) {
              final filial = _filiais.firstWhere(
                (f) => f.codigo == requisicao.filial,
                orElse: () => Filial(codigo: '', nome: 'Desconhecida'),
              );

              return DataRow(
                cells: [
                  DataCell(Text(requisicao.id)),
                  DataCell(Text(_formatadorData.format(requisicao.data))),
                  DataCell(Text(filial.nome)),
                  DataCell(Text(requisicao.solicitante)),
                  DataCell(Text(requisicao.pecas.length.toString())),
                  DataCell(_buildStatusChip(requisicao.status)),
                ],
                onSelectChanged: (_) => _mostrarDetalhesRequisicao(requisicao),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status.toLowerCase()) {
      case 'aprovado':
        color = Colors.green;
        break;
      case 'pendente':
        color = Colors.orange;
        break;
      case 'rejeitado':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }

    return Chip(
      label: Text(status, style: TextStyle(color: Colors.white)),
      backgroundColor: color,
    );
  }

  void _mostrarDetalhesRequisicao(Requisicao requisicao) {
    final filial = _filiais.firstWhere(
      (f) => f.codigo == requisicao.filial,
      orElse: () => Filial(codigo: '', nome: 'Desconhecida'),
    );

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Detalhes da Requisição'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildDetailRow('ID', requisicao.id),
                  _buildDetailRow(
                    'Data',
                    _formatadorData.format(requisicao.data),
                  ),
                  _buildDetailRow('Filial', filial.nome),
                  _buildDetailRow('Solicitante', requisicao.solicitante),
                  _buildDetailRow('Status', requisicao.status),
                  SizedBox(height: 16),
                  Text('Peças:', style: TextStyle(fontWeight: FontWeight.bold)),
                  ...requisicao.pecas.map(
                    (Peca pecaItem) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow('Código', pecaItem.codigo),
                        _buildDetailRow('Descrição', pecaItem.descricao),
                        _buildDetailRow(
                          'Quantidade',
                          pecaItem.quantidade.toString(),
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('Fechar'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
