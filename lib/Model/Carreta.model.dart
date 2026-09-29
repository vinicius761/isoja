class Carreta {
  final int? id;
  final String placa;
  final String renavam;
  final String tipo;
  final int eixos;
  final double capacidadeCargaKg;
  final int anoFabricacao;
  final int idProprietario;

  Carreta({
    this.id,
    required this.placa,
    required this.renavam,
    required this.tipo,
    required this.eixos,
    required this.capacidadeCargaKg,
    required this.anoFabricacao,
    required this.idProprietario,
  });

  factory Carreta.fromJson(Map<String, dynamic> json) {
    return Carreta(
      id: (json['id'] as num?)?.toInt(),
      placa: json['placa'] as String? ?? '',
      renavam: json['renavam'] as String? ?? '',
      tipo: json['tipo'] as String? ?? '',
      eixos: (json['eixos'] as num?)?.toInt() ?? 0,
      capacidadeCargaKg: (json['capacidadeCargaKg'] as num?)?.toDouble() ?? 0.0,
      anoFabricacao: (json['anoFabricacao'] as num?)?.toInt() ?? 0,
      idProprietario: (json['idProprietario'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'placa': placa,
      'renavam': renavam,
      'tipo': tipo,
      'eixos': eixos,
      'capacidadeCargaKg': capacidadeCargaKg,
      'anoFabricacao': anoFabricacao,
      'idProprietario': idProprietario,
    };
  }

  Carreta copyWith({
    int? id,
    String? placa,
    String? renavam,
    String? tipo,
    int? eixos,
    double? capacidadeCargaKg,
    int? anoFabricacao,
    int? idProprietario,
  }) {
    return Carreta(
      id: id ?? this.id,
      placa: placa ?? this.placa,
      renavam: renavam ?? this.renavam,
      tipo: tipo ?? this.tipo,
      eixos: eixos ?? this.eixos,
      capacidadeCargaKg: capacidadeCargaKg ?? this.capacidadeCargaKg,
      anoFabricacao: anoFabricacao ?? this.anoFabricacao,
      idProprietario: idProprietario ?? this.idProprietario,
    );
  }
}
