class ConfiguracaoBalanca {
  final int? id;

  final String? ipBalanca;
  final String? portBalanca;

  ConfiguracaoBalanca({this.id, this.ipBalanca, this.portBalanca});

  factory ConfiguracaoBalanca.fromMap(Map<String, dynamic> map) {
    final rawId = map['id'] ?? map['ID'];
    return ConfiguracaoBalanca(
      id: rawId is String ? int.tryParse(rawId) : rawId,
      ipBalanca: map['IP'],
      portBalanca: map['PORTA'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'ID': id ?? 1, 'IP': ipBalanca, 'PORTA': portBalanca};
  }
}
