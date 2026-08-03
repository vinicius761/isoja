class VeiculoModel {
  final String recno;
  final String placa;
  final String modelo;
  final String filial;
  final String codigo;
  final String delet;

  const VeiculoModel({
    required this.recno,
    required this.placa,
    required this.modelo,
    required this.filial,
    required this.codigo,
    required this.delet,
  });

  /// Converte um Map (banco local/SQLite) para a Model
  factory VeiculoModel.fromMap(Map<String, dynamic> map) {
    return VeiculoModel(
      recno: map['recno'] as String? ?? '',
      placa: map['placa'] as String? ?? '',
      modelo: map['modelo'] as String? ?? '',
      filial: map['filial'] as String? ?? '',
      codigo: map['codigo'] as String? ?? '',
      delet: map['delet'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'recno': recno,
      'placa': placa,
      'modelo': modelo,
      'filial': filial,
      'codigo': codigo,
      'delet': delet,
    };
  }

  factory VeiculoModel.fromJson(Map<String, dynamic> json) =>
      VeiculoModel.fromMap(json);

  Map<String, dynamic> toJson() => toMap();

  VeiculoModel copyWith({
    String? recno,
    String? placa,
    String? modelo,
    String? filial,
    String? codigo,
    String? delet,
  }) {
    return VeiculoModel(
      recno: recno ?? this.recno,
      placa: placa ?? this.placa,
      modelo: modelo ?? this.modelo,
      filial: filial ?? this.filial,
      codigo: codigo ?? this.codigo,
      delet: delet ?? this.delet,
    );
  }
}
