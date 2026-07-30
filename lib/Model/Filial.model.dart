class Filial {
  final String filial;
  final String desc_filial;
  final String cod_entidade;
  final String loja_entidade;
  final String cod_fornec;
  final String Loja_fornec;
  final String Cod_cliente;
  final String Loja_cliente;
  final String Cod_filial;

  Filial({
    required this.filial,
    required this.desc_filial,
    required this.cod_entidade,
    required this.loja_entidade,
    required this.cod_fornec,
    required this.Loja_fornec,
    required this.Cod_cliente,
    required this.Loja_cliente,
    required this.Cod_filial,
  });

  /// ADICIONADO: Converte o JSON vindo da API para a Model local
  factory Filial.fromJson(Map<String, dynamic> json) {
    return Filial(
      filial: json['filial']?.toString() ?? '',
      desc_filial: json['desc_filial']?.toString() ?? '',
      cod_entidade: json['cod_entidade']?.toString() ?? '',
      loja_entidade: json['loja_entidade']?.toString() ?? '',
      cod_fornec: json['cod_fornec']?.toString() ?? '',
      Loja_fornec: json['Loja_fornec']?.toString() ?? '',
      Cod_cliente: json['Cod_cliente']?.toString() ?? '',
      Loja_cliente: json['Loja_cliente']?.toString() ?? '',
      Cod_filial: json['Cod_filial']?.toString() ?? '',
    );
  }

  /// Converte o mapa vindo do banco de dados SQLite (protheus) para a Model
  factory Filial.fromMap(Map<String, dynamic> map) {
    return Filial(
      filial: map['M0_CODFIL']?.toString() ?? '',
      desc_filial: map['M0_FILIAL']?.toString() ?? '',
      cod_entidade: map['NJ0_CODENT']?.toString() ?? '',
      loja_entidade: map['NJ0_LOJENT']?.toString() ?? '',
      cod_fornec: map['NJ0_CODFOR']?.toString() ?? '',
      Loja_fornec: map['NJ0_LOJFOR']?.toString() ?? '',
      Cod_cliente: map['NJ0_CODCLI']?.toString() ?? '',
      Loja_cliente: map['NJ0_LOJCLI']?.toString() ?? '',
      Cod_filial: map['NJ0_CODCRP']?.toString() ?? '',
    );
  }

  /// Converte a Model para salvar no SQLite usando as colunas nativas do banco
  Map<String, dynamic> toMap() {
    return {
      'M0_CODFIL': filial,
      'M0_FILIAL': desc_filial,
      'NJ0_CODENT': cod_entidade,
      'NJ0_LOJENT': loja_entidade,
      'NJ0_CODFOR': cod_fornec,
      'NJ0_LOJFOR': Loja_fornec,
      'NJ0_CODCLI': Cod_cliente,
      'NJ0_LOJCLI': Loja_cliente,
      'NJ0_CODCRP': Cod_filial,
    };
  }

  /// Converte a Model para formato JSON padrão para requisições de API
  Map<String, dynamic> toJson() {
    return {
      'filial': filial,
      'desc_filial': desc_filial,
      'cod_entidade': cod_entidade,
      'loja_entidade': loja_entidade,
      'cod_fornec': cod_fornec,
      'Loja_fornec': Loja_fornec,
      'Cod_cliente': Cod_cliente,
      'Loja_cliente': Loja_cliente,
      'Cod_filial': Cod_filial,
    };
  }

  Filial copyWith({
    String? filial,
    String? desc_filial,
    String? cod_entidade,
    String? loja_entidade,
    String? cod_fornec,
    String? Loja_fornec,
    String? Cod_cliente,
    String? Loja_cliente,
    String? Cod_filial,
  }) {
    return Filial(
      filial: filial ?? this.filial,
      desc_filial: desc_filial ?? this.desc_filial,
      cod_entidade: cod_entidade ?? this.cod_entidade,
      loja_entidade: loja_entidade ?? this.loja_entidade,
      cod_fornec: cod_fornec ?? this.cod_fornec,
      Loja_fornec: Loja_fornec ?? this.Loja_fornec,
      Cod_cliente: Cod_cliente ?? this.Cod_cliente,
      Loja_cliente: Loja_cliente ?? this.Loja_cliente,
      Cod_filial: Cod_filial ?? this.Cod_filial,
    );
  }
}
