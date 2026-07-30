class Configuracoes {
  final int? id;
  final String? cadroLinho;
  final String? romaneio;
  final String? Embloca;
  final String? checkRomaneio;
  final String? filaBeneficiamento;
  final String? classificacao;
  final String? cadroLinhoLote; // <- Novo Campo

  Configuracoes({
    this.id,
    this.cadroLinho,
    this.romaneio,
    this.Embloca,
    this.checkRomaneio,
    this.filaBeneficiamento,
    this.classificacao,
    this.cadroLinhoLote, // <- Novo Campo
  });

  factory Configuracoes.fromMap(Map<String, dynamic> map) {
    return Configuracoes(
      id: map['id'] ?? map['ID'],
      cadroLinho: map['CADROLINHO'],
      romaneio: map['ROMANEIO'],
      Embloca: map['EMBLOCA'],
      checkRomaneio: map['CHECKROMANEIO'],
      filaBeneficiamento: map['FILABENEFICIAMENTO'],
      classificacao: map['CLASSIFICACAO'],
      cadroLinhoLote: map['CADROLINHOLOTE'], // <- Mapeamento do Novo Campo
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id ?? 1,
      'CADROLINHO': cadroLinho,
      'ROMANEIO': romaneio,
      'EMBLOCA': Embloca,
      'CHECKROMANEIO': checkRomaneio,
      'FILABENEFICIAMENTO': filaBeneficiamento,
      'CLASSIFICACAO': classificacao,
      'CADROLINHOLOTE': cadroLinhoLote, // <- Mapeamento do Novo Campo
    };
  }
}
