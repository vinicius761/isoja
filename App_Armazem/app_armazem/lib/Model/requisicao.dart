import 'package:app_armazem/Model/peca.dart';

class Requisicao {
  final String id;
  final DateTime data;
  final String filial;
  final String solicitante;
  final String status;
  final List<Peca> pecas;
  final String? observacao;

  Requisicao({
    required this.id,
    required this.data,
    required this.filial,
    required this.solicitante,
    required this.status,
    required this.pecas,
    this.observacao,
  });
  factory Requisicao.nova() {
    return Requisicao(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      data: DateTime.now(),
      filial: '',
      solicitante: '',
      pecas: [],
      status: '',
    );
  }
  factory Requisicao.fromMap(Map<String, dynamic> map) {
    return Requisicao(
      id: map['id'],
      data: map['data'],
      filial: map['filial'],
      solicitante: map['solicitante'],
      status: map['status'],
      pecas: List<Peca>.from(map['pecas'].map((x) => Peca.fromMap(x))),
    );
  }
}
