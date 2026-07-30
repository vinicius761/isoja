import 'dart:convert';

//  Análise / Classificação
class NjkModel {
  final String njkFilial;
  final String njkCodrom;
  final String njkItem;
  final String njkTpclas;
  final String njkTipreg;
  final String njkCoddes;
  final double njkBasdes;
  final String njkObrgt;
  final double njkPerdes;
  final double njkReades;
  final double njkQtddes;
  final String njkDesres;
  final String njkResinf;
  final String dELET;
  final int rECNO;
  final int rECDE;

  const NjkModel({
    required this.njkFilial,
    required this.njkCodrom,
    required this.njkItem,
    required this.njkTpclas,
    required this.njkTipreg,
    required this.njkCoddes,
    required this.njkBasdes,
    required this.njkObrgt,
    required this.njkPerdes,
    required this.njkReades,
    required this.njkQtddes,
    required this.njkDesres,
    required this.njkResinf,
    required this.dELET,
    required this.rECNO,
    required this.rECDE,
  });

  factory NjkModel.fromMap(Map<String, dynamic> map) {
    return NjkModel(
      njkFilial: map['NJK_FILIAL'] ?? '',
      njkCodrom: map['NJK_CODROM'] ?? '',
      njkItem: map['NJK_ITEM'] ?? '',
      njkTpclas: map['NJK_TPCLAS'] ?? '',
      njkTipreg: map['NJK_TIPREG'] ?? '',
      njkCoddes: map['NJK_CODDES'] ?? '',
      njkBasdes: (map['NJK_BASDES'] as num?)?.toDouble() ?? 0.0,
      njkObrgt: map['NJK_OBRGT'] ?? '',
      njkPerdes: (map['NJK_PERDES'] as num?)?.toDouble() ?? 0.0,
      njkReades: (map['NJK_READES'] as num?)?.toDouble() ?? 0.0,
      njkQtddes: (map['NJK_QTDDES'] as num?)?.toDouble() ?? 0.0,
      njkDesres: map['NJK_DESRES'] ?? '',
      njkResinf: map['NJK_RESINF'] ?? '',
      dELET: map['D_E_L_E_T_'] ?? '',
      rECNO: map['R_E_C_N_O_']?.toInt() ?? 0,
      rECDE: map['R_E_C_D_E_L_']?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'NJK_FILIAL': njkFilial,
      'NJK_CODROM': njkCodrom,
      'NJK_ITEM': njkItem,
      'NJK_TPCLAS': njkTpclas,
      'NJK_TIPREG': njkTipreg,
      'NJK_CODDES': njkCoddes,
      'NJK_BASDES': njkBasdes,
      'NJK_OBRGT': njkObrgt,
      'NJK_PERDES': njkPerdes,
      'NJK_READES': njkReades,
      'NJK_QTDDES': njkQtddes,
      'NJK_DESRES': njkDesres,
      'NJK_RESINF': njkResinf,
      'D_E_L_E_T_': dELET,
      'R_E_C_N_O_': rECNO,
      'R_E_C_D_E_L_': rECDE,
    };
  }

  factory NjkModel.fromJson(String source) =>
      NjkModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
