class TransportadoraModel {
  final String? codigo;
  final String? nome;
  final String? nomeFantasia;
  final String? cnpjCpf;
  final String? deletado;

  TransportadoraModel({
    this.codigo,
    this.nome,
    this.nomeFantasia,
    this.cnpjCpf,
    this.deletado,
  });

  factory TransportadoraModel.fromMap(Map<String, dynamic> map) {
    return TransportadoraModel(
      codigo: map['codigo'] as String?,
      nome: map['nome'] as String?,
      nomeFantasia: map['nomeFantasia'] as String?,
      cnpjCpf: map['cnpjCpf'] as String?,
      deletado: map['deletado'] as String?,
    );
  }

  // Método para converter o objeto em Map
  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'nome': nome,
      'nomeFantasia': nomeFantasia,
      'cnpjCpf': cnpjCpf,
      'deletado': deletado,
    };
  }

  factory TransportadoraModel.fromJson(Map<String, dynamic> json) =>
      TransportadoraModel.fromMap(json);

  Map<String, dynamic> toJson() => toMap();
}
