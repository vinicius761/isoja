enum StatusCarga { emTransito, finalizada }

class CargaModel {
  final String id;
  final String placa;
  final String motorista;
  final String talhao;
  final double peso;
  final DateTime dataHora;
  final StatusCarga status;

  CargaModel({
    required this.id,
    required this.placa,
    required this.motorista,
    required this.talhao,
    required this.peso,
    required this.dataHora,
    required this.status,
  });
}