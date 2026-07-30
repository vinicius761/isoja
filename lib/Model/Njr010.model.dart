import 'dart:convert';

//  Contratos Vinculados
class NjrModel {
  final String njrFilial;
  final String njrCodctr;
  final String njrUltalt;
  final String njrDescri;
  final String njrTipo;
  final String njrTipmer;
  final String njrData;
  final String njrCtrext;
  final String njrCodent;
  final String njrLojent;
  final String njrCodter;
  final String njrLojter;
  final String njrOpetri;
  final String njrOpefut;
  final String njrCodope;
  final String njrCodsaf;
  final String njrTalhao;
  final String njrCodpro;
  final String njrUm1Pro;
  final String njrTabela;
  final String njrCodrpc;
  final String njrOpefis;
  final String njrTesest;
  final String njrTesfin;
  final String njrTesqte;
  final String njrTesrsi;
  final String njrTipemb;
  final String? njrObsadt; // BLOB
  final double njrQtdini;
  final double njrTolent;
  final double njrQtdctr;
  final double njrAutent;
  final double njrAutsai;
  final double njrQteemb;
  final double njrQtefco;
  final double njrQtefis;
  final double njrVlefis;
  final double njrQtsemb;
  final double njrQtsfco;
  final double njrQtsfis;
  final double njrVlsfis;
  final double njrQslemb;
  final double njrQslfco;
  final double njrSldfis;
  final double njrSldtot;
  final double njrQtdres;
  final double njrQtdque;
  final String njrTipfix;
  final double njrVlrbas;
  final double njrMoeda;
  final double njrTxmoed;
  final double njrVlruni;
  final String njrUmprc;
  final double njrVlrtot;
  final double njrVldola;
  final double njrXvlrdo;
  final double njrPercrd;
  final String njrCodidx;
  final String njrTpfret;
  final String njrCtrllg;
  final String njrCtrlcd;
  final String njrModelo;
  final String njrModbas;
  final String njrStsass;
  final String njrStsfis;
  final String njrStsfin;
  final String njrStsest;
  final String njrStatus;
  final String njrCodtse;
  final String njrModal;
  final String njrUsado;
  final String njrTpexc;
  final String njrInscpo;
  final String njrTkpfis;
  final String njrCtrpar;
  final String njrDatref;
  final String njrTipalg;
  final String njrClassp;
  final String njrClassq;
  final String njrHvium;
  final String njrTipum;
  final String njrHvical;
  final String njrOutum;
  final String njrTipcal;
  final double njrHvifat;
  final String njrOutcal;
  final String njrHvireg;
  final double njrTipfat;
  final double njrOutfat;
  final double njrHvitol;
  final String njrQpadr;
  final String njrTipace;
  final String njrCodngc;
  final String njrVersao;
  final String? njrXmsgnf; // BLOB
  final String njrMsgnfs;
  final String njrCodemb;
  final String njrCondpa;
  final String njrVia;
  final String njrIncote;
  final String njrCodrem;
  final String njrBolsa;
  final String njrTpsevo;
  final String njrCondpg;
  final double njrDiaspg;
  final String njrTipocl;
  final String njrCodfin;
  final String njrResfix;
  final String njrChkfix;
  final String njrItvdap;
  final String njrTransf;
  final String njrClvl;
  final String njrOperac;
  final double njrMoedar;
  final double njrDiasr;
  final double njrMoedaf;
  final double njrDiasf;
  final double njrTotnn7;
  final double njrTotn9G;
  final double njrTotn9K;
  final double njrTotaft;
  final String njrGenmod;
  final double njrTotarb;
  final String njrStsmin;
  final String njrPromin;
  final String njrConpes;
  final String njrBcoprv;
  final String njrAggprv;
  final String njrCtaprv;
  final double njrQtdum2;
  final String njrIndpre;
  final String njrCoda1U;
  final String njrUm2Pro;
  final String njrVended;
  final String njrClassf;
  final String njrXctrcl;
  final String njrXcoza3;
  final String njrXreza3;
  final String njrXfilpr;
  final double njrXvltus;
  final String dELET;
  final int rECNO;
  final int rECDE;

  const NjrModel({
    required this.njrFilial,
    required this.njrCodctr,
    required this.njrUltalt,
    required this.njrDescri,
    required this.njrTipo,
    required this.njrTipmer,
    required this.njrData,
    required this.njrCtrext,
    required this.njrCodent,
    required this.njrLojent,
    required this.njrCodter,
    required this.njrLojter,
    required this.njrOpetri,
    required this.njrOpefut,
    required this.njrCodope,
    required this.njrCodsaf,
    required this.njrTalhao,
    required this.njrCodpro,
    required this.njrUm1Pro,
    required this.njrTabela,
    required this.njrCodrpc,
    required this.njrOpefis,
    required this.njrTesest,
    required this.njrTesfin,
    required this.njrTesqte,
    required this.njrTesrsi,
    required this.njrTipemb,
    this.njrObsadt,
    required this.njrQtdini,
    required this.njrTolent,
    required this.njrQtdctr,
    required this.njrAutent,
    required this.njrAutsai,
    required this.njrQteemb,
    required this.njrQtefco,
    required this.njrQtefis,
    required this.njrVlefis,
    required this.njrQtsemb,
    required this.njrQtsfco,
    required this.njrQtsfis,
    required this.njrVlsfis,
    required this.njrQslemb,
    required this.njrQslfco,
    required this.njrSldfis,
    required this.njrSldtot,
    required this.njrQtdres,
    required this.njrQtdque,
    required this.njrTipfix,
    required this.njrVlrbas,
    required this.njrMoeda,
    required this.njrTxmoed,
    required this.njrVlruni,
    required this.njrUmprc,
    required this.njrVlrtot,
    required this.njrVldola,
    required this.njrXvlrdo,
    required this.njrPercrd,
    required this.njrCodidx,
    required this.njrTpfret,
    required this.njrCtrllg,
    required this.njrCtrlcd,
    required this.njrModelo,
    required this.njrModbas,
    required this.njrStsass,
    required this.njrStsfis,
    required this.njrStsfin,
    required this.njrStsest,
    required this.njrStatus,
    required this.njrCodtse,
    required this.njrModal,
    required this.njrUsado,
    required this.njrTpexc,
    required this.njrInscpo,
    required this.njrTkpfis,
    required this.njrCtrpar,
    required this.njrDatref,
    required this.njrTipalg,
    required this.njrClassp,
    required this.njrClassq,
    required this.njrHvium,
    required this.njrTipum,
    required this.njrHvical,
    required this.njrOutum,
    required this.njrTipcal,
    required this.njrHvifat,
    required this.njrOutcal,
    required this.njrHvireg,
    required this.njrTipfat,
    required this.njrOutfat,
    required this.njrHvitol,
    required this.njrQpadr,
    required this.njrTipace,
    required this.njrCodngc,
    required this.njrVersao,
    this.njrXmsgnf,
    required this.njrMsgnfs,
    required this.njrCodemb,
    required this.njrCondpa,
    required this.njrVia,
    required this.njrIncote,
    required this.njrCodrem,
    required this.njrBolsa,
    required this.njrTpsevo,
    required this.njrCondpg,
    required this.njrDiaspg,
    required this.njrTipocl,
    required this.njrCodfin,
    required this.njrResfix,
    required this.njrChkfix,
    required this.njrItvdap,
    required this.njrTransf,
    required this.njrClvl,
    required this.njrOperac,
    required this.njrMoedar,
    required this.njrDiasr,
    required this.njrMoedaf,
    required this.njrDiasf,
    required this.njrTotnn7,
    required this.njrTotn9G,
    required this.njrTotn9K,
    required this.njrTotaft,
    required this.njrGenmod,
    required this.njrTotarb,
    required this.njrStsmin,
    required this.njrPromin,
    required this.njrConpes,
    required this.njrBcoprv,
    required this.njrAggprv,
    required this.njrCtaprv,
    required this.njrQtdum2,
    required this.njrIndpre,
    required this.njrCoda1U,
    required this.njrUm2Pro,
    required this.njrVended,
    required this.njrClassf,
    required this.njrXctrcl,
    required this.njrXcoza3,
    required this.njrXreza3,
    required this.njrXfilpr,
    required this.njrXvltus,
    required this.dELET,
    required this.rECNO,
    required this.rECDE,
  });

  factory NjrModel.fromMap(Map<String, dynamic> map) {
    return NjrModel(
      njrFilial: map['NJR_FILIAL'] ?? '',
      njrCodctr: map['NJR_CODCTR'] ?? '',
      njrUltalt: map['NJR_ULTALT'] ?? '',
      njrDescri: map['NJR_DESCRI'] ?? '',
      njrTipo: map['NJR_TIPO'] ?? '',
      njrTipmer: map['NJR_TIPMER'] ?? '',
      njrData: map['NJR_DATA'] ?? '',
      njrCtrext: map['NJR_CTREXT'] ?? '',
      njrCodent: map['NJR_CODENT'] ?? '',
      njrLojent: map['NJR_LOJENT'] ?? '',
      njrCodter: map['NJR_CODTER'] ?? '',
      njrLojter: map['NJR_LOJTER'] ?? '',
      njrOpetri: map['NJR_OPETRI'] ?? '',
      njrOpefut: map['NJR_OPEFUT'] ?? '',
      njrCodope: map['NJR_CODOPE'] ?? '',
      njrCodsaf: map['NJR_CODSAF'] ?? '',
      njrTalhao: map['NJR_TALHAO'] ?? '',
      njrCodpro: map['NJR_CODPRO'] ?? '',
      njrUm1Pro: map['NJR_UM1PRO'] ?? '',
      njrTabela: map['NJR_TABELA'] ?? '',
      njrCodrpc: map['NJR_CODRPC'] ?? '',
      njrOpefis: map['NJR_OPEFIS'] ?? '',
      njrTesest: map['NJR_TESEST'] ?? '',
      njrTesfin: map['NJR_TESFIN'] ?? '',
      njrTesqte: map['NJR_TESQTE'] ?? '',
      njrTesrsi: map['NJR_TESRSI'] ?? '',
      njrTipemb: map['NJR_TIPEMB'] ?? '',
      njrObsadt: map['NJR_OBSADT'],
      njrQtdini: (map['NJR_QTDINI'] as num?)?.toDouble() ?? 0.0,
      njrTolent: (map['NJR_TOLENT'] as num?)?.toDouble() ?? 0.0,
      njrQtdctr: (map['NJR_QTDCTR'] as num?)?.toDouble() ?? 0.0,
      njrAutent: (map['NJR_AUTENT'] as num?)?.toDouble() ?? 0.0,
      njrAutsai: (map['NJR_AUTSAI'] as num?)?.toDouble() ?? 0.0,
      njrQteemb: (map['NJR_QTEEMB'] as num?)?.toDouble() ?? 0.0,
      njrQtefco: (map['NJR_QTEFCO'] as num?)?.toDouble() ?? 0.0,
      njrQtefis: (map['NJR_QTEFIS'] as num?)?.toDouble() ?? 0.0,
      njrVlefis: (map['NJR_VLEFIS'] as num?)?.toDouble() ?? 0.0,
      njrQtsemb: (map['NJR_QTSEMB'] as num?)?.toDouble() ?? 0.0,
      njrQtsfco: (map['NJR_QTSFCO'] as num?)?.toDouble() ?? 0.0,
      njrQtsfis: (map['NJR_QTSFIS'] as num?)?.toDouble() ?? 0.0,
      njrVlsfis: (map['NJR_VLSFIS'] as num?)?.toDouble() ?? 0.0,
      njrQslemb: (map['NJR_QSLEMB'] as num?)?.toDouble() ?? 0.0,
      njrQslfco: (map['NJR_QSLFCO'] as num?)?.toDouble() ?? 0.0,
      njrSldfis: (map['NJR_SLDFIS'] as num?)?.toDouble() ?? 0.0,
      njrSldtot: (map['NJR_SLDTOT'] as num?)?.toDouble() ?? 0.0,
      njrQtdres: (map['NJR_QTDRES'] as num?)?.toDouble() ?? 0.0,
      njrQtdque: (map['NJR_QTDQUE'] as num?)?.toDouble() ?? 0.0,
      njrTipfix: map['NJR_TIPFIX'] ?? '',
      njrVlrbas: (map['NJR_VLRBAS'] as num?)?.toDouble() ?? 0.0,
      njrMoeda: (map['NJR_MOEDA'] as num?)?.toDouble() ?? 0.0,
      njrTxmoed: (map['NJR_TXMOED'] as num?)?.toDouble() ?? 0.0,
      njrVlruni: (map['NJR_VLRUNI'] as num?)?.toDouble() ?? 0.0,
      njrUmprc: map['NJR_UMPRC'] ?? '',
      njrVlrtot: (map['NJR_VLRTOT'] as num?)?.toDouble() ?? 0.0,
      njrVldola: (map['NJR_VLDOLA'] as num?)?.toDouble() ?? 0.0,
      njrXvlrdo: (map['NJR_XVLRDO'] as num?)?.toDouble() ?? 0.0,
      njrPercrd: (map['NJR_PERCRD'] as num?)?.toDouble() ?? 0.0,
      njrCodidx: map['NJR_CODIDX'] ?? '',
      njrTpfret: map['NJR_TPFRET'] ?? '',
      njrCtrllg: map['NJR_CTRLLG'] ?? '',
      njrCtrlcd: map['NJR_CTRLCD'] ?? '',
      njrModelo: map['NJR_MODELO'] ?? '',
      njrModbas: map['NJR_MODBAS'] ?? '',
      njrStsass: map['NJR_STSASS'] ?? '',
      njrStsfis: map['NJR_STSFIS'] ?? '',
      njrStsfin: map['NJR_STSFIN'] ?? '',
      njrStsest: map['NJR_STSEST'] ?? '',
      njrStatus: map['NJR_STATUS'] ?? '',
      njrCodtse: map['NJR_CODTSE'] ?? '',
      njrModal: map['NJR_MODAL'] ?? '',
      njrUsado: map['NJR_USADO'] ?? '',
      njrTpexc: map['NJR_TPEXC'] ?? '',
      njrInscpo: map['NJR_INSCPO'] ?? '',
      njrTkpfis: map['NJR_TKPFIS'] ?? '',
      njrCtrpar: map['NJR_CTRPAR'] ?? '',
      njrDatref: map['NJR_DATREF'] ?? '',
      njrTipalg: map['NJR_TIPALG'] ?? '',
      njrClassp: map['NJR_CLASSP'] ?? '',
      njrClassq: map['NJR_CLASSQ'] ?? '',
      njrHvium: map['NJR_HVIUM'] ?? '',
      njrTipum: map['NJR_TIPUM'] ?? '',
      njrHvical: map['NJR_HVICAL'] ?? '',
      njrOutum: map['NJR_OUTUM'] ?? '',
      njrTipcal: map['NJR_TIPCAL'] ?? '',
      njrHvifat: (map['NJR_HVIFAT'] as num?)?.toDouble() ?? 0.0,
      njrOutcal: map['NJR_OUTCAL'] ?? '',
      njrHvireg: map['NJR_HVIREG'] ?? '',
      njrTipfat: (map['NJR_TIPFAT'] as num?)?.toDouble() ?? 0.0,
      njrOutfat: (map['NJR_OUTFAT'] as num?)?.toDouble() ?? 0.0,
      njrHvitol: (map['NJR_HVITOL'] as num?)?.toDouble() ?? 0.0,
      njrQpadr: map['NJR_QPADR'] ?? '',
      njrTipace: map['NJR_TIPACE'] ?? '',
      njrCodngc: map['NJR_CODNGC'] ?? '',
      njrVersao: map['NJR_VERSAO'] ?? '',
      njrXmsgnf: map['NJR_XMSGNF'],
      njrMsgnfs: map['NJR_MSGNFS'] ?? '',
      njrCodemb: map['NJR_CODEMB'] ?? '',
      njrCondpa: map['NJR_CONDPA'] ?? '',
      njrVia: map['NJR_VIA'] ?? '',
      njrIncote: map['NJR_INCOTE'] ?? '',
      njrCodrem: map['NJR_CODREM'] ?? '',
      njrBolsa: map['NJR_BOLSA'] ?? '',
      njrTpsevo: map['NJR_TPSEVO'] ?? '',
      njrCondpg: map['NJR_CONDPG'] ?? '',
      njrDiaspg: (map['NJR_DIASPG'] as num?)?.toDouble() ?? 0.0,
      njrTipocl: map['NJR_TIPOCL'] ?? '',
      njrCodfin: map['NJR_CODFIN'] ?? '',
      njrResfix: map['NJR_RESFIX'] ?? '',
      njrChkfix: map['NJR_CHKFIX'] ?? '',
      njrItvdap: map['NJR_ITVDAP'] ?? '',
      njrTransf: map['NJR_TRANSF'] ?? '',
      njrClvl: map['NJR_CLVL'] ?? '',
      njrOperac: map['NJR_OPERAC'] ?? '',
      njrMoedar: (map['NJR_MOEDAR'] as num?)?.toDouble() ?? 0.0,
      njrDiasr: (map['NJR_DIASR'] as num?)?.toDouble() ?? 0.0,
      njrMoedaf: (map['NJR_MOEDAF'] as num?)?.toDouble() ?? 0.0,
      njrDiasf: (map['NJR_DIASF'] as num?)?.toDouble() ?? 0.0,
      njrTotnn7: (map['NJR_TOTNN7'] as num?)?.toDouble() ?? 0.0,
      njrTotn9G: (map['NJR_TOTN9G'] as num?)?.toDouble() ?? 0.0,
      njrTotn9K: (map['NJR_TOTN9K'] as num?)?.toDouble() ?? 0.0,
      njrTotaft: (map['NJR_TOTAFT'] as num?)?.toDouble() ?? 0.0,
      njrGenmod: map['NJR_GENMOD'] ?? '',
      njrTotarb: (map['NJR_TOTARB'] as num?)?.toDouble() ?? 0.0,
      njrStsmin: map['NJR_STSMIN'] ?? '',
      njrPromin: map['NJR_PROMIN'] ?? '',
      njrConpes: map['NJR_CONPES'] ?? '',
      njrBcoprv: map['NJR_BCOPRV'] ?? '',
      njrAggprv: map['NJR_AGGPRV'] ?? '',
      njrCtaprv: map['NJR_CTAPRV'] ?? '',
      njrQtdum2: (map['NJR_QTDUM2'] as num?)?.toDouble() ?? 0.0,
      njrIndpre: map['NJR_INDPRE'] ?? '',
      njrCoda1U: map['NJR_CODA1U'] ?? '',
      njrUm2Pro: map['NJR_UM2PRO'] ?? '',
      njrVended: map['NJR_VENDED'] ?? '',
      njrClassf: map['NJR_CLASSF'] ?? '',
      njrXctrcl: map['NJR_XCTRCL'] ?? '',
      njrXcoza3: map['NJR_XCOZA3'] ?? '',
      njrXreza3: map['NJR_XREZA3'] ?? '',
      njrXfilpr: map['NJR_XFILPR'] ?? '',
      njrXvltus: (map['NJR_XVLTUS'] as num?)?.toDouble() ?? 0.0,
      dELET: map['D_E_L_E_T_'] ?? '',
      rECNO: map['R_E_C_N_O_']?.toInt() ?? 0,
      rECDE: map['R_E_C_D_E_L_']?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'NJR_FILIAL': njrFilial,
      'NJR_CODCTR': njrCodctr,
      'NJR_ULTALT': njrUltalt,
      'NJR_DESCRI': njrDescri,
      'NJR_TIPO': njrTipo,
      'NJR_TIPMER': njrTipmer,
      'NJR_DATA': njrData,
      'NJR_CTREXT': njrCtrext,
      'NJR_CODENT': njrCodent,
      'NJR_LOJENT': njrLojent,
      'NJR_CODTER': njrCodter,
      'NJR_LOJTER': njrLojter,
      'NJR_OPETRI': njrOpetri,
      'NJR_OPEFUT': njrOpefut,
      'NJR_CODOPE': njrCodope,
      'NJR_CODSAF': njrCodsaf,
      'NJR_TALHAO': njrTalhao,
      'NJR_CODPRO': njrCodpro,
      'NJR_UM1PRO': njrUm1Pro,
      'NJR_TABELA': njrTabela,
      'NJR_CODRPC': njrCodrpc,
      'NJR_OPEFIS': njrOpefis,
      'NJR_TESEST': njrTesest,
      'NJR_TESFIN': njrTesfin,
      'NJR_TESQTE': njrTesqte,
      'NJR_TESRSI': njrTesrsi,
      'NJR_TIPEMB': njrTipemb,
      'NJR_OBSADT': njrObsadt,
      'NJR_QTDINI': njrQtdini,
      'NJR_TOLENT': njrTolent,
      'NJR_QTDCTR': njrQtdctr,
      'NJR_AUTENT': njrAutent,
      'NJR_AUTSAI': njrAutsai,
      'NJR_QTEEMB': njrQteemb,
      'NJR_QTEFCO': njrQtefco,
      'NJR_QTEFIS': njrQtefis,
      'NJR_VLEFIS': njrVlefis,
      'NJR_QTSEMB': njrQtsemb,
      'NJR_QTSFCO': njrQtsfco,
      'NJR_QTSFIS': njrQtsfis,
      'NJR_VLSFIS': njrVlsfis,
      'NJR_QSLEMB': njrQslemb,
      'NJR_QSLFCO': njrQslfco,
      'NJR_SLDFIS': njrSldfis,
      'NJR_SLDTOT': njrSldtot,
      'NJR_QTDRES': njrQtdres,
      'NJR_QTDQUE': njrQtdque,
      'NJR_TIPFIX': njrTipfix,
      'NJR_VLRBAS': njrVlrbas,
      'NJR_MOEDA': njrMoeda,
      'NJR_TXMOED': njrTxmoed,
      'NJR_VLRUNI': njrVlruni,
      'NJR_UMPRC': njrUmprc,
      'NJR_VLRTOT': njrVlrtot,
      'NJR_VLDOLA': njrVldola,
      'NJR_XVLRDO': njrXvlrdo,
      'NJR_PERCRD': njrPercrd,
      'NJR_CODIDX': njrCodidx,
      'NJR_TPFRET': njrTpfret,
      'NJR_CTRLLG': njrCtrllg,
      'NJR_CTRLCD': njrCtrlcd,
      'NJR_MODELO': njrModelo,
      'NJR_MODBAS': njrModbas,
      'NJR_STSASS': njrStsass,
      'NJR_STSFIS': njrStsfis,
      'NJR_STSFIN': njrStsfin,
      'NJR_STSEST': njrStsest,
      'NJR_STATUS': njrStatus,
      'NJR_CODTSE': njrCodtse,
      'NJR_MODAL': njrModal,
      'NJR_USADO': njrUsado,
      'NJR_TPEXC': njrTpexc,
      'NJR_INSCPO': njrInscpo,
      'NJR_TKPFIS': njrTkpfis,
      'NJR_CTRPAR': njrCtrpar,
      'NJR_DATREF': njrDatref,
      'NJR_TIPALG': njrTipalg,
      'NJR_CLASSP': njrClassp,
      'NJR_CLASSQ': njrClassq,
      'NJR_HVIUM': njrHvium,
      'NJR_TIPUM': njrTipum,
      'NJR_HVICAL': njrHvical,
      'NJR_OUTUM': njrOutum,
      'NJR_TIPCAL': njrTipcal,
      'NJR_HVIFAT': njrHvifat,
      'NJR_OUTCAL': njrOutcal,
      'NJR_HVIREG': njrHvireg,
      'NJR_TIPFAT': njrTipfat,
      'NJR_OUTFAT': njrOutfat,
      'NJR_HVITOL': njrHvitol,
      'NJR_QPADR': njrQpadr,
      'NJR_TIPACE': njrTipace,
      'NJR_CODNGC': njrCodngc,
      'NJR_VERSAO': njrVersao,
      'NJR_XMSGNF': njrXmsgnf,
      'NJR_MSGNFS': njrMsgnfs,
      'NJR_CODEMB': njrCodemb,
      'NJR_CONDPA': njrCondpa,
      'NJR_VIA': njrVia,
      'NJR_INCOTE': njrIncote,
      'NJR_CODREM': njrCodrem,
      'NJR_BOLSA': njrBolsa,
      'NJR_TPSEVO': njrTpsevo,
      'NJR_CONDPG': njrCondpg,
      'NJR_DIASPG': njrDiaspg,
      'NJR_TIPOCL': njrTipocl,
      'NJR_CODFIN': njrCodfin,
      'NJR_RESFIX': njrResfix,
      'NJR_CHKFIX': njrChkfix,
      'NJR_ITVDAP': njrItvdap,
      'NJR_TRANSF': njrTransf,
      'NJR_CLVL': njrClvl,
      'NJR_OPERAC': njrOperac,
      'NJR_MOEDAR': njrMoedar,
      'NJR_DIASR': njrDiasr,
      'NJR_MOEDAF': njrMoedaf,
      'NJR_DIASF': njrDiasf,
      'NJR_TOTNN7': njrTotnn7,
      'NJR_TOTN9G': njrTotn9G,
      'NJR_TOTN9K': njrTotn9K,
      'NJR_TOTAFT': njrTotaft,
      'NJR_GENMOD': njrGenmod,
      'NJR_TOTARB': njrTotarb,
      'NJR_STSMIN': njrStsmin,
      'NJR_PROMIN': njrPromin,
      'NJR_CONPES': njrConpes,
      'NJR_BCOPRV': njrBcoprv,
      'NJR_AGGPRV': njrAggprv,
      'NJR_CTAPRV': njrCtaprv,
      'NJR_QTDUM2': njrQtdum2,
      'NJR_INDPRE': njrIndpre,
      'NJR_CODA1U': njrCoda1U,
      'NJR_UM2PRO': njrUm2Pro,
      'NJR_VENDED': njrVended,
      'NJR_CLASSF': njrClassf,
      'NJR_XCTRCL': njrXctrcl,
      'NJR_XCOZA3': njrXcoza3,
      'NJR_XREZA3': njrXreza3,
      'NJR_XFILPR': njrXfilpr,
      'NJR_XVLTUS': njrXvltus,
      'D_E_L_E_T_': dELET,
      'R_E_C_N_O_': rECNO,
      'R_E_C_D_E_L_': rECDE,
    };
  }

  factory NjrModel.fromJson(String source) =>
      NjrModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
