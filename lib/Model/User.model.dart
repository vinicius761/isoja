class UserModel {
  final String idUser;
  final String user;
  final String nome;
  final String email;
  final String senha;
  final String dataCriacao;
  final String idProtheus;
  final String isAdmin;

  UserModel({
    required this.idUser,
    required this.nome,
    required this.user,
    required this.email,
    required this.senha,
    required this.dataCriacao,
    required this.idProtheus,
    required this.isAdmin,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      idUser: json['ID_USER'].toString(),
      nome: json['NOME'],
      user: json['USER'],
      email: json['EMAIL'],
      senha: json['SENHA'],
      dataCriacao: json['DATA_CRIACAO'],
      idProtheus: json['ID_PROTHEUS'].toString(),
      isAdmin: json['ADMIN'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID_USER': idUser,
      'NOME': nome,
      'EMAIL': email,
      'USER': user,
      'SENHA': senha,
      'DATA_CRIACAO': dataCriacao,
      'ID_PROTHEUS': idProtheus,
      'ADMIN': isAdmin,
    };
  }
}
