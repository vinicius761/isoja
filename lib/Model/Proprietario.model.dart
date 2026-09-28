class Proprietario {
  final String? id;
  final String nome;
  final String cpfCnpj;
  final String telefone;
  final String email;

  Proprietario({
    this.id,
    required this.nome,
    required this.cpfCnpj,
    required this.telefone,
    required this.email,
  });

  factory Proprietario.fromJson(Map<String, dynamic> json) {
    return Proprietario(
      id: json['id'].toString(),
      nome: json['nome'],
      cpfCnpj: json['cpfCnpj'],
      telefone: json['telefone'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'nome': nome,
      'cpfCnpj': cpfCnpj,
      'telefone': telefone,
      'email': email,
    };
  }

  Proprietario copyWith({
    String? id,
    String? nome,
    String? cpfCnpj,
    String? telefone,
    String? email,
  }) {
    return Proprietario(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      cpfCnpj: cpfCnpj ?? this.cpfCnpj,
      telefone: telefone ?? this.telefone,
      email: email ?? this.email,
    );
  }
}
