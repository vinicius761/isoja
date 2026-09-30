class Acoplamento {
  final int? idAcoplamento;
  final int idCavalo;
  final int idCarreta;
  final DateTime? dataEngate;
  final DateTime? dataDesengate;

  Acoplamento({
    this.idAcoplamento,
    required this.idCavalo,
    required this.idCarreta,
    this.dataEngate,
    this.dataDesengate,
  });

  factory Acoplamento.fromJson(Map<String, dynamic> json) {
    return Acoplamento(
      idAcoplamento: (json['idAcoplamento'] as num?)?.toInt(),
      idCavalo: (json['idCavalo'] as num?)?.toInt() ?? 0,
      idCarreta: (json['idCarreta'] as num?)?.toInt() ?? 0,
      dataEngate:
          json['dataEngate'] != null
              ? DateTime.tryParse(json['dataEngate'].toString())
              : null,
      dataDesengate:
          json['dataDesengate'] != null
              ? DateTime.tryParse(json['dataDesengate'].toString())
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (idAcoplamento != null) 'idAcoplamento': idAcoplamento,
      'idCavalo': idCavalo,
      'idCarreta': idCarreta,
      if (dataEngate != null) 'dataEngate': dataEngate!.toIso8601String(),
      if (dataDesengate != null)
        'dataDesengate': dataDesengate!.toIso8601String(),
    };
  }

  Acoplamento copyWith({
    int? idAcoplamento,
    int? idCavalo,
    int? idCarreta,
    DateTime? dataEngate,
    DateTime? dataDesengate,
  }) {
    return Acoplamento(
      idAcoplamento: idAcoplamento ?? this.idAcoplamento,
      idCavalo: idCavalo ?? this.idCavalo,
      idCarreta: idCarreta ?? this.idCarreta,
      dataEngate: dataEngate ?? this.dataEngate,
      dataDesengate: dataDesengate ?? this.dataDesengate,
    );
  }
}
