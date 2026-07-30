String formatarHora(String hora) {
  String h = hora.trim();
  // Se vier HHmmss (ex: 094104)
  if (h.length == 6) {
    return "${h.substring(0, 2)}:${h.substring(2, 4)}:${h.substring(4, 6)}";
  }
  // Se já vier com dois pontos ou for HHmm
  return h.isNotEmpty ? h : "-";
}
