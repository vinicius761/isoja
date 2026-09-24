import 'dart:convert';

class EntidadeEntrega {
  final String codigoEntidade;
  final String lojaEntidade;
  final String nomeEntidade;
  final String cnpjCpfEntidade;

  EntidadeEntrega({
    required this.codigoEntidade,
    required this.lojaEntidade,
    required this.nomeEntidade,
    required this.cnpjCpfEntidade,
  });

  // Converte a instância para Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'codigoEntidade': codigoEntidade,
      'lojaEntidade': lojaEntidade,
      'nomeEntidade': nomeEntidade,
      'cnpjCpfEntidade': cnpjCpfEntidade,
    };
  }

  factory EntidadeEntrega.fromJson(Map<String, dynamic> json) {
    return EntidadeEntrega(
      codigoEntidade: json['codigoEntidade']?.toString() ?? '',
      lojaEntidade: json['lojaEntidade']?.toString() ?? '',
      nomeEntidade: json['nomeEntidade']?.toString() ?? '',
      cnpjCpfEntidade: json['cnpjCpfEntidade']?.toString() ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EntidadeEntrega.fromRawJson(String str) =>
      EntidadeEntrega.fromJson(json.decode(str) as Map<String, dynamic>);
}
