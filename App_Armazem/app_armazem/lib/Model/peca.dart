class Peca {
  final String codigo;
  final String descricao;
  final int quantidade;

  Peca({
    required this.codigo,
    required this.descricao,
    required this.quantidade,
  });

  factory Peca.fromMap(Map<String, dynamic> map) {
    return Peca(
      codigo: map['codigo'],
      descricao: map['descricao'],
      quantidade: map['quantidade'],
    );
  }
  Peca copyWith({String? codigo, String? descricao, int? quantidade}) {
    return Peca(
      codigo: codigo ?? this.codigo,
      descricao: descricao ?? this.descricao,
      quantidade: quantidade ?? this.quantidade,
    );
  }
}
