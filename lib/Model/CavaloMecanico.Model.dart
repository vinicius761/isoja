class CavaloMecanico {
  final String placa;
  final String renavam;
  final String modelo;
  final String marca;
  final int anoFabricacao;
  final int idProprietario;

  CavaloMecanico({
    required this.placa,
    required this.renavam,
    required this.modelo,
    required this.marca,
    required this.anoFabricacao,
    required this.idProprietario,
  });

  factory CavaloMecanico.fromJson(Map<String, dynamic> json) {
    return CavaloMecanico(
      placa: json['placa'] as String? ?? '',
      renavam: json['renavam'] as String? ?? '',
      modelo: json['modelo'] as String? ?? '',
      marca: json['marca'] as String? ?? '',
      anoFabricacao: json['anoFabricacao'] as int? ?? 0,
      idProprietario: json['idProprietario'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'placa': placa,
      'renavam': renavam,
      'modelo': modelo,
      'marca': marca,
      'anoFabricacao': anoFabricacao,
      'idProprietario': idProprietario,
    };
  }

  CavaloMecanico copyWith({
    String? placa,
    String? renavam,
    String? modelo,
    String? marca,
    int? anoFabricacao,
    int? idProprietario,
  }) {
    return CavaloMecanico(
      placa: placa ?? this.placa,
      renavam: renavam ?? this.renavam,
      modelo: modelo ?? this.modelo,
      marca: marca ?? this.marca,
      anoFabricacao: anoFabricacao ?? this.anoFabricacao,
      idProprietario: idProprietario ?? this.idProprietario,
    );
  }
}
