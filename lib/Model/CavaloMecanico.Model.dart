class CavaloMecanico {
  final int? id;
  final String placa;
  final String renavam;
  final String modelo;
  final String marca;
  final int anoFabricacao;
  final int idProprietario;

  CavaloMecanico({
    this.id,
    required this.placa,
    required this.renavam,
    required this.modelo,
    required this.marca,
    required this.anoFabricacao,
    required this.idProprietario,
  });

  factory CavaloMecanico.fromJson(Map<String, dynamic> json) {
    return CavaloMecanico(
      id: (json['id'] as num?)?.toInt(),
      placa: json['placa'] as String? ?? '',
      renavam: json['renavam'] as String? ?? '',
      modelo: json['modelo'] as String? ?? '',
      marca: json['marca'] as String? ?? '',
      anoFabricacao: (json['anoFabricacao'] as num?)?.toInt() ?? 0,
      idProprietario: (json['idProprietario'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'placa': placa,
      'renavam': renavam,
      'modelo': modelo,
      'marca': marca,
      'anoFabricacao': anoFabricacao,
      'idProprietario': idProprietario,
    };
  }

  CavaloMecanico copyWith({
    int? id,
    String? placa,
    String? renavam,
    String? modelo,
    String? marca,
    int? anoFabricacao,
    int? idProprietario,
  }) {
    return CavaloMecanico(
      id: id ?? this.id,
      placa: placa ?? this.placa,
      renavam: renavam ?? this.renavam,
      modelo: modelo ?? this.modelo,
      marca: marca ?? this.marca,
      anoFabricacao: anoFabricacao ?? this.anoFabricacao,
      idProprietario: idProprietario ?? this.idProprietario,
    );
  }
}
