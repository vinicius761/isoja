String capitalizarNome(String nome) {
  if (nome.isEmpty) return nome;

  return nome
      .toLowerCase()
      .split(' ')
      .map((palavra) {
        if (palavra.isEmpty) return palavra;
        return palavra[0].toUpperCase() + palavra.substring(1);
      })
      .join(' ');
}
