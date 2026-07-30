String? validarCampoVazio(String? value, String nomeDoCampo) {
  if (value == null || value.trim().isEmpty) {
    return 'O campo $nomeDoCampo não pode ser vazio';
  }
  return null; // Retorna null se estiver preenchido corretamente
}
