class Validators {
  // Campo obrigatório
  static String? requiredField(String? value, {String fieldName = "Campo"}) {
    if (value == null || value.isEmpty)
      return "$fieldName não pode ficar vazio";
    return null;
  }

  // Validação de e-mail
  static String? email(String? value) {
    if (value == null || value.isEmpty) return "O e-mail não pode ficar vazio";
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return "E-mail inválido";
    return null;
  }

  // Validação de tamanho mínimo
  static String? minLength(
    String? value,
    int length, {
    String fieldName = "Campo",
  }) {
    if (value == null || value.length < length)
      return "$fieldName deve ter pelo menos $length caracteres";
    return null;
  }

  // Validação de senha (mínimo 6 caracteres)
  static String? password(String? value) {
    return minLength(value, 6, fieldName: "Senha");
  }
}
