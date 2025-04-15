class Usuario {
  final String username;
  final String senha;
  final String nome;

  Usuario({required this.username, required this.senha, required this.nome});

  // Usuário teste em memória
  static Usuario get usuarioTeste =>
      Usuario(username: 'admin', senha: '123', nome: 'Usuário Teste');
}
