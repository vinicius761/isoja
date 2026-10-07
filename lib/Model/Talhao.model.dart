import 'dart:convert';

class Talhao {
  final String nn3Filial;
  final String nn3Safra;
  final String m0Filial;
  final String nn3Faz;
  final String nn3Talhao;
  final String? talhaoSpl;
  final String? nn3Descri;
  final double nn3Hectar;
  final String? nn3Codpro;
  final String? nn4Codvar;
  final String? nn4Desvar;

  Talhao({
    required this.nn3Filial,
    required this.nn3Safra,
    required this.m0Filial,
    required this.nn3Faz,
    required this.nn3Talhao,
    this.talhaoSpl,
    this.nn3Descri,
    required this.nn3Hectar,
    this.nn3Codpro,
    this.nn4Codvar,
    this.nn4Desvar,
  });

  factory Talhao.fromMap(Map<String, dynamic> map) {
    return Talhao(
      nn3Filial: map['NN3_FILIAL'] as String? ?? '',
      nn3Safra: map['NN3_SAFRA'] as String? ?? '',
      m0Filial: map['M0_FILIAL'] as String? ?? '',
      nn3Faz: map['NN3_FAZ'] as String? ?? '',
      nn3Talhao: map['NN3_TALHAO'] as String? ?? '',
      talhaoSpl: map['TALHAO_SPL'] as String?,
      nn3Descri: map['NN3_DESCRI'] as String?,
      nn3Hectar: (map['NN3_HECTAR'] as num?)?.toDouble() ?? 0.0,
      nn3Codpro: map['NN3_CODPRO'] as String?,
      nn4Codvar: map['NN4_CODVAR'] as String?,
      nn4Desvar: map['NN4_DESVAR'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'NN3_FILIAL': nn3Filial,
      'NN3_SAFRA': nn3Safra,
      'M0_FILIAL': m0Filial,
      'NN3_FAZ': nn3Faz,
      'NN3_TALHAO': nn3Talhao,
      'TALHAO_SPL': talhaoSpl,
      'NN3_DESCRI': nn3Descri,
      'NN3_HECTAR': nn3Hectar,
      'NN3_CODPRO': nn3Codpro,
      'NN4_CODVAR': nn4Codvar,
      'NN4_DESVAR': nn4Desvar,
    };
  }

  factory Talhao.fromJson(String source) =>
      Talhao.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());
}
