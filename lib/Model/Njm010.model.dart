import 'dart:convert';

// Itens / Dados Fiscais
class NjmModel {
  final String njmFilial;
  final String njmCodrom;
  final String njmIterom;
  final String njmCodent;
  final String njmLojent;
  final String njmCodsaf;
  final String njmTalhao;
  final String njmCodpro;
  final String njmUm1Pro;
  final String njmLocal;
  final String njmCodine;
  final String njmCodctr;
  final String njmItem;
  final String njmSeqpri;
  final String njmOpefis;
  final String njmTes;
  final double njmPerdiv;
  final double njmQtdfco;
  final String njmLotctl;
  final String njmNmlot;
  final String njmLocliz;
  final String njmTpform;
  final String njmDocser;
  final String njmDocnum;
  final String njmDocite;
  final String njmDocemi;
  final String njmDocesp;
  final String njmChvnfe;
  final String njmMsgnfs;
  final double njmQtdfis;
  final double njmVlruni;
  final double njmVlrtot;
  final double njmFrete;
  final double njmSeguro;
  final double njmDespes;
  final String njmNfpser;
  final String njmNfpnum;
  final String njmTipo;
  final String njmTrans;
  final String njmTipmov;
  final String njmCondpg;
  final String njmPedido;
  final String njmStafis;
  final String njmDtrans;
  final String njmItvdap;
  final String njmTrserv;
  final String njmCodaut;
  final String njmIdmov;
  final String njmClvl;
  final String njmNumcom;
  final String njmSercom;
  final String njmSubtip;
  final String njmFilorg;
  final String njmCondco;
  final String njmGenmod;
  final String njmNumavi;
  final String njmNumdco;
  final String njmSeqdco;
  final String njmSeqnln;
  final String njmCadpro;
  final String njmIndpre;
  final String njmCoda1U;
  final String dELET;
  final int rECNO;
  final int rECDE;
  final String njmTpguia;
  final String njmUfguia;
  final String njmSergui;
  final String njmNmrgui;
  final String njmNumrec;
  final String njmCpfeng;

  const NjmModel({
    required this.njmFilial,
    required this.njmCodrom,
    required this.njmIterom,
    required this.njmCodent,
    required this.njmLojent,
    required this.njmCodsaf,
    required this.njmTalhao,
    required this.njmCodpro,
    required this.njmUm1Pro,
    required this.njmLocal,
    required this.njmCodine,
    required this.njmCodctr,
    required this.njmItem,
    required this.njmSeqpri,
    required this.njmOpefis,
    required this.njmTes,
    required this.njmPerdiv,
    required this.njmQtdfco,
    required this.njmLotctl,
    required this.njmNmlot,
    required this.njmLocliz,
    required this.njmTpform,
    required this.njmDocser,
    required this.njmDocnum,
    required this.njmDocite,
    required this.njmDocemi,
    required this.njmDocesp,
    required this.njmChvnfe,
    required this.njmMsgnfs,
    required this.njmQtdfis,
    required this.njmVlruni,
    required this.njmVlrtot,
    required this.njmFrete,
    required this.njmSeguro,
    required this.njmDespes,
    required this.njmNfpser,
    required this.njmNfpnum,
    required this.njmTipo,
    required this.njmTrans,
    required this.njmTipmov,
    required this.njmCondpg,
    required this.njmPedido,
    required this.njmStafis,
    required this.njmDtrans,
    required this.njmItvdap,
    required this.njmTrserv,
    required this.njmCodaut,
    required this.njmIdmov,
    required this.njmClvl,
    required this.njmNumcom,
    required this.njmSercom,
    required this.njmSubtip,
    required this.njmFilorg,
    required this.njmCondco,
    required this.njmGenmod,
    required this.njmNumavi,
    required this.njmNumdco,
    required this.njmSeqdco,
    required this.njmSeqnln,
    required this.njmCadpro,
    required this.njmIndpre,
    required this.njmCoda1U,
    required this.dELET,
    required this.rECNO,
    required this.rECDE,
    required this.njmTpguia,
    required this.njmUfguia,
    required this.njmSergui,
    required this.njmNmrgui,
    required this.njmNumrec,
    required this.njmCpfeng,
  });

  factory NjmModel.fromMap(Map<String, dynamic> map) {
    return NjmModel(
      njmFilial: map['NJM_FILIAL'] ?? '',
      njmCodrom: map['NJM_CODROM'] ?? '',
      njmIterom: map['NJM_ITEROM'] ?? '',
      njmCodent: map['NJM_CODENT'] ?? '',
      njmLojent: map['NJM_LOJENT'] ?? '',
      njmCodsaf: map['NJM_CODSAF'] ?? '',
      njmTalhao: map['NJM_TALHAO'] ?? '',
      njmCodpro: map['NJM_CODPRO'] ?? '',
      njmUm1Pro: map['NJM_UM1PRO'] ?? '',
      njmLocal: map['NJM_LOCAL'] ?? '',
      njmCodine: map['NJM_CODINE'] ?? '',
      njmCodctr: map['NJM_CODCTR'] ?? '',
      njmItem: map['NJM_ITEM'] ?? '',
      njmSeqpri: map['NJM_SEQPRI'] ?? '',
      njmOpefis: map['NJM_OPEFIS'] ?? '',
      njmTes: map['NJM_TES'] ?? '',
      njmPerdiv: (map['NJM_PERDIV'] as num?)?.toDouble() ?? 0.0,
      njmQtdfco: (map['NJM_QTDFCO'] as num?)?.toDouble() ?? 0.0,
      njmLotctl: map['NJM_LOTCTL'] ?? '',
      njmNmlot: map['NJM_NMLOT'] ?? '',
      njmLocliz: map['NJM_LOCLIZ'] ?? '',
      njmTpform: map['NJM_TPFORM'] ?? '',
      njmDocser: map['NJM_DOCSER'] ?? '',
      njmDocnum: map['NJM_DOCNUM'] ?? '',
      njmDocite: map['NJM_DOCITE'] ?? '',
      njmDocemi: map['NJM_DOCEMI'] ?? '',
      njmDocesp: map['NJM_DOCESP'] ?? '',
      njmChvnfe: map['NJM_CHVNFE'] ?? '',
      njmMsgnfs: map['NJM_MSGNFS'] ?? '',
      njmQtdfis: (map['NJM_QTDFIS'] as num?)?.toDouble() ?? 0.0,
      njmVlruni: (map['NJM_VLRUNI'] as num?)?.toDouble() ?? 0.0,
      njmVlrtot: (map['NJM_VLRTOT'] as num?)?.toDouble() ?? 0.0,
      njmFrete: (map['NJM_FRETE'] as num?)?.toDouble() ?? 0.0,
      njmSeguro: (map['NJM_SEGURO'] as num?)?.toDouble() ?? 0.0,
      njmDespes: (map['NJM_DESPES'] as num?)?.toDouble() ?? 0.0,
      njmNfpser: map['NJM_NFPSER'] ?? '',
      njmNfpnum: map['NJM_NFPNUM'] ?? '',
      njmTipo: map['NJM_TIPO'] ?? '',
      njmTrans: map['NJM_TRANS'] ?? '',
      njmTipmov: map['NJM_TIPMOV'] ?? '',
      njmCondpg: map['NJM_CONDPG'] ?? '',
      njmPedido: map['NJM_PEDIDO'] ?? '',
      njmStafis: map['NJM_STAFIS'] ?? '',
      njmDtrans: map['NJM_DTRANS'] ?? '',
      njmItvdap: map['NJM_ITVDAP'] ?? '',
      njmTrserv: map['NJM_TRSERV'] ?? '',
      njmCodaut: map['NJM_CODAUT'] ?? '',
      njmIdmov: map['NJM_IDMOV'] ?? '',
      njmClvl: map['NJM_CLVL'] ?? '',
      njmNumcom: map['NJM_NUMCOM'] ?? '',
      njmSercom: map['NJM_SERCOM'] ?? '',
      njmSubtip: map['NJM_SUBTIP'] ?? '',
      njmFilorg: map['NJM_FILORG'] ?? '',
      njmCondco: map['NJM_CONDCO'] ?? '',
      njmGenmod: map['NJM_GENMOD'] ?? '',
      njmNumavi: map['NJM_NUMAVI'] ?? '',
      njmNumdco: map['NJM_NUMDCO'] ?? '',
      njmSeqdco: map['NJM_SEQDCO'] ?? '',
      njmSeqnln: map['NJM_SEQNLN'] ?? '',
      njmCadpro: map['NJM_CADPRO'] ?? '',
      njmIndpre: map['NJM_INDPRE'] ?? '',
      njmCoda1U: map['NJM_CODA1U'] ?? '',
      dELET: map['D_E_L_E_T_'] ?? '',
      rECNO: map['R_E_C_N_O_']?.toInt() ?? 0,
      rECDE: map['R_E_C_D_E_L_']?.toInt() ?? 0,
      njmTpguia: map['NJM_TPGUIA'] ?? '',
      njmUfguia: map['NJM_UFGUIA'] ?? '',
      njmSergui: map['NJM_SERGUI'] ?? '',
      njmNmrgui: map['NJM_NMRGUI'] ?? '',
      njmNumrec: map['NJM_NUMREC'] ?? '',
      njmCpfeng: map['NJM_CPFENG'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'NJM_FILIAL': njmFilial,
      'NJM_CODROM': njmCodrom,
      'NJM_ITEROM': njmIterom,
      'NJM_CODENT': njmCodent,
      'NJM_LOJENT': njmLojent,
      'NJM_CODSAF': njmCodsaf,
      'NJM_TALHAO': njmTalhao,
      'NJM_CODPRO': njmCodpro,
      'NJM_UM1PRO': njmUm1Pro,
      'NJM_LOCAL': njmLocal,
      'NJM_CODINE': njmCodine,
      'NJM_CODCTR': njmCodctr,
      'NJM_ITEM': njmItem,
      'NJM_SEQPRI': njmSeqpri,
      'NJM_OPEFIS': njmOpefis,
      'NJM_TES': njmTes,
      'NJM_PERDIV': njmPerdiv,
      'NJM_QTDFCO': njmQtdfco,
      'NJM_LOTCTL': njmLotctl,
      'NJM_NMLOT': njmNmlot,
      'NJM_LOCLIZ': njmLocliz,
      'NJM_TPFORM': njmTpform,
      'NJM_DOCSER': njmDocser,
      'NJM_DOCNUM': njmDocnum,
      'NJM_DOCITE': njmDocite,
      'NJM_DOCEMI': njmDocemi,
      'NJM_DOCESP': njmDocesp,
      'NJM_CHVNFE': njmChvnfe,
      'NJM_MSGNFS': njmMsgnfs,
      'NJM_QTDFIS': njmQtdfis,
      'NJM_VLRUNI': njmVlruni,
      'NJM_VLRTOT': njmVlrtot,
      'NJM_FRETE': njmFrete,
      'NJM_SEGURO': njmSeguro,
      'NJM_DESPES': njmDespes,
      'NJM_NFPSER': njmNfpser,
      'NJM_NFPNUM': njmNfpnum,
      'NJM_TIPO': njmTipo,
      'NJM_TRANS': njmTrans,
      'NJM_TIPMOV': njmTipmov,
      'NJM_CONDPG': njmCondpg,
      'NJM_PEDIDO': njmPedido,
      'NJM_STAFIS': njmStafis,
      'NJM_DTRANS': njmDtrans,
      'NJM_ITVDAP': njmItvdap,
      'NJM_TRSERV': njmTrserv,
      'NJM_CODAUT': njmCodaut,
      'NJM_IDMOV': njmIdmov,
      'NJM_CLVL': njmClvl,
      'NJM_NUMCOM': njmNumcom,
      'NJM_SERCOM': njmSercom,
      'NJM_SUBTIP': njmSubtip,
      'NJM_FILORG': njmFilorg,
      'NJM_CONDCO': njmCondco,
      'NJM_GENMOD': njmGenmod,
      'NJM_NUMAVI': njmNumavi,
      'NJM_NUMDCO': njmNumdco,
      'NJM_SEQDCO': njmSeqdco,
      'NJM_SEQNLN': njmSeqnln,
      'NJM_CADPRO': njmCadpro,
      'NJM_INDPRE': njmIndpre,
      'NJM_CODA1U': njmCoda1U,
      'D_E_L_E_T_': dELET,
      'R_E_C_N_O_': rECNO,
      'R_E_C_D_E_L_': rECDE,
      'NJM_TPGUIA': njmTpguia,
      'NJM_UFGUIA': njmUfguia,
      'NJM_SERGUI': njmSergui,
      'NJM_NMRGUI': njmNmrgui,
      'NJM_NUMREC': njmNumrec,
      'NJM_CPFENG': njmCpfeng,
    };
  }

  factory NjmModel.fromJson(String source) =>
      NjmModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
