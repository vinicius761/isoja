class Filial {
  final String codigo;
  final String nome;

  Filial({required this.codigo, required this.nome});

  factory Filial.fromMap(Map<String, dynamic> map) {
    return Filial(codigo: map['codigo'], nome: map['nome']);
  }
}
