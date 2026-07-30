import 'dart:convert';

// Cabeçalho & Pesagens
class NjjModel {
  final String njjFilial;
  final String njjCodrom;
  final String njjTipo;
  final String njjPlaca;
  final String njjCodtra;
  final String njjCodmot;
  final String njjCodent;
  final String njjLojent;
  final String njjEntent;
  final String njjEntloj;
  final String njjTpform;
  final String njjDocser;
  final String njjDocnum;
  final String njjDocemi;
  final String njjDocesp;
  final String njjChvnfe;
  final double njjQtdfis;
  final double njjVlruni;
  final double njjVlrtot;
  final String njjTes;
  final double njjFrete;
  final double njjSeguro;
  final double njjDespes;
  final String njjNfpser;
  final String njjNfpnum;
  final String njjMsgnfs;
  final String njjObs;
  final String njjTpfret;
  final String njjCodsaf;
  final String njjCodpro;
  final String njjUm1Pro;
  final String njjCultiv;
  final String njjMoega;
  final String njjTabela;
  final String njjTktcla;
  final String njjStscla;
  final String njjDatps1;
  final String njjLocal;
  final String njjHorps1;
  final double njjPeso1;
  final String njjModps1;
  final String njjDatps2;
  final String njjHorps2;
  final double njjPeso2;
  final String njjModps2;
  final double njjPssubt;
  final double njjPsdesc;
  final double njjPsbase;
  final double njjPsextr;
  final double njjPsliqu;
  final String njjStspes;
  final String njjStatus;
  final String njjStafis;
  final String njjStactr;
  final String njjFilrel;
  final String njjRomrel;
  final String njjData;
  final String njjDtrans;
  final String njjTipent;
  final String njjRomori;
  final String njjTrserv;
  final String njjCodctr;
  final String njjCodaut;
  final String njjDocest;
  final String njjQparec;
  final String njjQusuar;
  final String njjOrdclt;
  final String njjLibqld;
  final String njjCoearr;
  final String njjCoedef;
  final String njjCoedod;
  final String njjCoedes;
  final String njjCoereg;
  final double njjPeso3;
  final String njjTpclas;
  final String njjDatche;
  final String njjHorche;
  final String njjOrigem;
  final String njjFaz;
  final String njjTalhao;
  final String njjCodvar;
  final String njjEst;
  final double njjDiffis;
  final String njjCgc;
  final String njjDtulal;
  final String njjHrulal;
  final String njjToetap;
  final String njjNumop;
  final String njjAponop;
  final String njjCodunb;
  final String njjNragen;
  final double njjQtdaut;
  final String njjEtapa;
  final String njjDtagen;
  final String njjHragen;
  final String njjItpims;
  final String njjFilorg;
  final double njjPesemb;
  final String njjStscrg;
  final double njjQtdfar;
  final String njjNrmov;
  final String njjCodtrf;
  final String njjSeqtrf;
  final String njjIndpre;
  final String njjCoda1U;
  final String njjMapa;
  final double njjXqttl1;
  final String njjXcotl2;
  final double njjXqttl2;
  final String njjXcotl3;
  final double njjXqttl3;
  final String njjXcotl4;
  final double njjXqttl4;
  final String njjXrorev;
  final String dELET;
  final int rECNO;
  final int rECDE;
  final String njjXromge;
  final String njjUsergi;
  final String njjUserga;
  final String? njjMsuid; // Campo nullable conforme a tabela
  final String njjXfecen;

  const NjjModel({
    required this.njjFilial,
    required this.njjCodrom,
    required this.njjTipo,
    required this.njjPlaca,
    required this.njjCodtra,
    required this.njjCodmot,
    required this.njjCodent,
    required this.njjLojent,
    required this.njjEntent,
    required this.njjEntloj,
    required this.njjTpform,
    required this.njjDocser,
    required this.njjDocnum,
    required this.njjDocemi,
    required this.njjDocesp,
    required this.njjChvnfe,
    required this.njjQtdfis,
    required this.njjVlruni,
    required this.njjVlrtot,
    required this.njjTes,
    required this.njjFrete,
    required this.njjSeguro,
    required this.njjDespes,
    required this.njjNfpser,
    required this.njjNfpnum,
    required this.njjMsgnfs,
    required this.njjObs,
    required this.njjTpfret,
    required this.njjCodsaf,
    required this.njjCodpro,
    required this.njjUm1Pro,
    required this.njjCultiv,
    required this.njjMoega,
    required this.njjTabela,
    required this.njjTktcla,
    required this.njjStscla,
    required this.njjDatps1,
    required this.njjLocal,
    required this.njjHorps1,
    required this.njjPeso1,
    required this.njjModps1,
    required this.njjDatps2,
    required this.njjHorps2,
    required this.njjPeso2,
    required this.njjModps2,
    required this.njjPssubt,
    required this.njjPsdesc,
    required this.njjPsbase,
    required this.njjPsextr,
    required this.njjPsliqu,
    required this.njjStspes,
    required this.njjStatus,
    required this.njjStafis,
    required this.njjStactr,
    required this.njjFilrel,
    required this.njjRomrel,
    required this.njjData,
    required this.njjDtrans,
    required this.njjTipent,
    required this.njjRomori,
    required this.njjTrserv,
    required this.njjCodctr,
    required this.njjCodaut,
    required this.njjDocest,
    required this.njjQparec,
    required this.njjQusuar,
    required this.njjOrdclt,
    required this.njjLibqld,
    required this.njjCoearr,
    required this.njjCoedef,
    required this.njjCoedod,
    required this.njjCoedes,
    required this.njjCoereg,
    required this.njjPeso3,
    required this.njjTpclas,
    required this.njjDatche,
    required this.njjHorche,
    required this.njjOrigem,
    required this.njjFaz,
    required this.njjTalhao,
    required this.njjCodvar,
    required this.njjEst,
    required this.njjDiffis,
    required this.njjCgc,
    required this.njjDtulal,
    required this.njjHrulal,
    required this.njjToetap,
    required this.njjNumop,
    required this.njjAponop,
    required this.njjCodunb,
    required this.njjNragen,
    required this.njjQtdaut,
    required this.njjEtapa,
    required this.njjDtagen,
    required this.njjHragen,
    required this.njjItpims,
    required this.njjFilorg,
    required this.njjPesemb,
    required this.njjStscrg,
    required this.njjQtdfar,
    required this.njjNrmov,
    required this.njjCodtrf,
    required this.njjSeqtrf,
    required this.njjIndpre,
    required this.njjCoda1U,
    required this.njjMapa,
    required this.njjXqttl1,
    required this.njjXcotl2,
    required this.njjXqttl2,
    required this.njjXcotl3,
    required this.njjXqttl3,
    required this.njjXcotl4,
    required this.njjXqttl4,
    required this.njjXrorev,
    required this.dELET,
    required this.rECNO,
    required this.rECDE,
    required this.njjXromge,
    required this.njjUsergi,
    required this.njjUserga,
    this.njjMsuid,
    required this.njjXfecen,
  });

  factory NjjModel.fromMap(Map<String, dynamic> map) {
    return NjjModel(
      njjFilial: map['NJJ_FILIAL'] ?? '',
      njjCodrom: map['NJJ_CODROM'] ?? '',
      njjTipo: map['NJJ_TIPO'] ?? '',
      njjPlaca: map['NJJ_PLACA'] ?? '',
      njjCodtra: map['NJJ_CODTRA'] ?? '',
      njjCodmot: map['NJJ_CODMOT'] ?? '',
      njjCodent: map['NJJ_CODENT'] ?? '',
      njjLojent: map['NJJ_LOJENT'] ?? '',
      njjEntent: map['NJJ_ENTENT'] ?? '',
      njjEntloj: map['NJJ_ENTLOJ'] ?? '',
      njjTpform: map['NJJ_TPFORM'] ?? '',
      njjDocser: map['NJJ_DOCSER'] ?? '',
      njjDocnum: map['NJJ_DOCNUM'] ?? '',
      njjDocemi: map['NJJ_DOCEMI'] ?? '',
      njjDocesp: map['NJJ_DOCESP'] ?? '',
      njjChvnfe: map['NJJ_CHVNFE'] ?? '',
      njjQtdfis: (map['NJJ_QTDFIS'] as num?)?.toDouble() ?? 0.0,
      njjVlruni: (map['NJJ_VLRUNI'] as num?)?.toDouble() ?? 0.0,
      njjVlrtot: (map['NJJ_VLRTOT'] as num?)?.toDouble() ?? 0.0,
      njjTes: map['NJJ_TES'] ?? '',
      njjFrete: (map['NJJ_FRETE'] as num?)?.toDouble() ?? 0.0,
      njjSeguro: (map['NJJ_SEGURO'] as num?)?.toDouble() ?? 0.0,
      njjDespes: (map['NJJ_DESPES'] as num?)?.toDouble() ?? 0.0,
      njjNfpser: map['NJJ_NFPSER'] ?? '',
      njjNfpnum: map['NJJ_NFPNUM'] ?? '',
      njjMsgnfs: map['NJJ_MSGNFS'] ?? '',
      njjObs: map['NJJ_OBS'] ?? '',
      njjTpfret: map['NJJ_TPFRET'] ?? '',
      njjCodsaf: map['NJJ_CODSAF'] ?? '',
      njjCodpro: map['NJJ_CODPRO'] ?? '',
      njjUm1Pro: map['NJJ_UM1PRO'] ?? '',
      njjCultiv: map['NJJ_CULTIV'] ?? '',
      njjMoega: map['NJJ_MOEGA'] ?? '',
      njjTabela: map['NJJ_TABELA'] ?? '',
      njjTktcla: map['NJJ_TKTCLA'] ?? '',
      njjStscla: map['NJJ_STSCLA'] ?? '',
      njjDatps1: map['NJJ_DATPS1'] ?? '',
      njjLocal: map['NJJ_LOCAL'] ?? '',
      njjHorps1: map['NJJ_HORPS1'] ?? '',
      njjPeso1: (map['NJJ_PESO1'] as num?)?.toDouble() ?? 0.0,
      njjModps1: map['NJJ_MODPS1'] ?? '',
      njjDatps2: map['NJJ_DATPS2'] ?? '',
      njjHorps2: map['NJJ_HORPS2'] ?? '',
      njjPeso2: (map['NJJ_PESO2'] as num?)?.toDouble() ?? 0.0,
      njjModps2: map['NJJ_MODPS2'] ?? '',
      njjPssubt: (map['NJJ_PSSUBT'] as num?)?.toDouble() ?? 0.0,
      njjPsdesc: (map['NJJ_PSDESC'] as num?)?.toDouble() ?? 0.0,
      njjPsbase: (map['NJJ_PSBASE'] as num?)?.toDouble() ?? 0.0,
      njjPsextr: (map['NJJ_PSEXTR'] as num?)?.toDouble() ?? 0.0,
      njjPsliqu: (map['NJJ_PSLIQU'] as num?)?.toDouble() ?? 0.0,
      njjStspes: map['NJJ_STSPES'] ?? '',
      njjStatus: map['NJJ_STATUS'] ?? '',
      njjStafis: map['NJJ_STAFIS'] ?? '',
      njjStactr: map['NJJ_STACTR'] ?? '',
      njjFilrel: map['NJJ_FILREL'] ?? '',
      njjRomrel: map['NJJ_ROMREL'] ?? '',
      njjData: map['NJJ_DATA'] ?? '',
      njjDtrans: map['NJJ_DTRANS'] ?? '',
      njjTipent: map['NJJ_TIPENT'] ?? '',
      njjRomori: map['NJJ_ROMORI'] ?? '',
      njjTrserv: map['NJJ_TRSERV'] ?? '',
      njjCodctr: map['NJJ_CODCTR'] ?? '',
      njjCodaut: map['NJJ_CODAUT'] ?? '',
      njjDocest: map['NJJ_DOCEST'] ?? '',
      njjQparec: map['NJJ_QPAREC'] ?? '',
      njjQusuar: map['NJJ_QUSUAR'] ?? '',
      njjOrdclt: map['NJJ_ORDCLT'] ?? '',
      njjLibqld: map['NJJ_LIBQLD'] ?? '',
      njjCoearr: map['NJJ_COEARR'] ?? '',
      njjCoedef: map['NJJ_COEDEF'] ?? '',
      njjCoedod: map['NJJ_COEDOD'] ?? '',
      njjCoedes: map['NJJ_COEDES'] ?? '',
      njjCoereg: map['NJJ_COEREG'] ?? '',
      njjPeso3: (map['NJJ_PESO3'] as num?)?.toDouble() ?? 0.0,
      njjTpclas: map['NJJ_TPCLAS'] ?? '',
      njjDatche: map['NJJ_DATCHE'] ?? '',
      njjHorche: map['NJJ_HORCHE'] ?? '',
      njjOrigem: map['NJJ_ORIGEM'] ?? '',
      njjFaz: map['NJJ_FAZ'] ?? '',
      njjTalhao: map['NJJ_TALHAO'] ?? '',
      njjCodvar: map['NJJ_CODVAR'] ?? '',
      njjEst: map['NJJ_EST'] ?? '',
      njjDiffis: (map['NJJ_DIFFIS'] as num?)?.toDouble() ?? 0.0,
      njjCgc: map['NJJ_CGC'] ?? '',
      njjDtulal: map['NJJ_DTULAL'] ?? '',
      njjHrulal: map['NJJ_HRULAL'] ?? '',
      njjToetap: map['NJJ_TOETAP'] ?? '',
      njjNumop: map['NJJ_NUMOP'] ?? '',
      njjAponop: map['NJJ_APONOP'] ?? '',
      njjCodunb: map['NJJ_CODUNB'] ?? '',
      njjNragen: map['NJJ_NRAGEN'] ?? '',
      njjQtdaut: (map['NJJ_QTDAUT'] as num?)?.toDouble() ?? 0.0,
      njjEtapa: map['NJJ_ETAPA'] ?? '',
      njjDtagen: map['NJJ_DTAGEN'] ?? '',
      njjHragen: map['NJJ_HRAGEN'] ?? '',
      njjItpims: map['NJJ_ITPIMS'] ?? '',
      njjFilorg: map['NJJ_FILORG'] ?? '',
      njjPesemb: (map['NJJ_PESEMB'] as num?)?.toDouble() ?? 0.0,
      njjStscrg: map['NJJ_STSCRG'] ?? '',
      njjQtdfar: (map['NJJ_QTDFAR'] as num?)?.toDouble() ?? 0.0,
      njjNrmov: map['NJJ_NRMOV'] ?? '',
      njjCodtrf: map['NJJ_CODTRF'] ?? '',
      njjSeqtrf: map['NJJ_SEQTRF'] ?? '',
      njjIndpre: map['NJJ_INDPRE'] ?? '',
      njjCoda1U: map['NJJ_CODA1U'] ?? '',
      njjMapa: map['NJJ_MAPA'] ?? '',
      njjXqttl1: (map['NJJ_XQTTL1'] as num?)?.toDouble() ?? 0.0,
      njjXcotl2: map['NJJ_XCOTL2'] ?? '',
      njjXqttl2: (map['NJJ_XQTTL2'] as num?)?.toDouble() ?? 0.0,
      njjXcotl3: map['NJJ_XCOTL3'] ?? '',
      njjXqttl3: (map['NJJ_XQTTL3'] as num?)?.toDouble() ?? 0.0,
      njjXcotl4: map['NJJ_XCOTL4'] ?? '',
      njjXqttl4: (map['NJJ_XQTTL4'] as num?)?.toDouble() ?? 0.0,
      njjXrorev: map['NJJ_XROREV'] ?? '',
      dELET: map['D_E_L_E_T_'] ?? '',
      rECNO: map['R_E_C_N_O_']?.toInt() ?? 0,
      rECDE: map['R_E_C_D_E_L_']?.toInt() ?? 0,
      njjXromge: map['NJJ_XROMGE'] ?? '',
      njjUsergi: map['NJJ_USERGI'] ?? '',
      njjUserga: map['NJJ_USERGA'] ?? '',
      njjMsuid: map['NJJ_MSUID'],
      njjXfecen: map['NJJ_XFECEN'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'NJJ_FILIAL': njjFilial,
      'NJJ_CODROM': njjCodrom,
      'NJJ_TIPO': njjTipo,
      'NJJ_PLACA': njjPlaca,
      'NJJ_CODTRA': njjCodtra,
      'NJJ_CODMOT': njjCodmot,
      'NJJ_CODENT': njjCodent,
      'NJJ_LOJENT': njjLojent,
      'NJJ_ENTENT': njjEntent,
      'NJJ_ENTLOJ': njjEntloj,
      'NJJ_TPFORM': njjTpform,
      'NJJ_DOCSER': njjDocser,
      'NJJ_DOCNUM': njjDocnum,
      'NJJ_DOCEMI': njjDocemi,
      'NJJ_DOCESP': njjDocesp,
      'NJJ_CHVNFE': njjChvnfe,
      'NJJ_QTDFIS': njjQtdfis,
      'NJJ_VLRUNI': njjVlruni,
      'NJJ_VLRTOT': njjVlrtot,
      'NJJ_TES': njjTes,
      'NJJ_FRETE': njjFrete,
      'NJJ_SEGURO': njjSeguro,
      'NJJ_DESPES': njjDespes,
      'NJJ_NFPSER': njjNfpser,
      'NJJ_NFPNUM': njjNfpnum,
      'NJJ_MSGNFS': njjMsgnfs,
      'NJJ_OBS': njjObs,
      'NJJ_TPFRET': njjTpfret,
      'NJJ_CODSAF': njjCodsaf,
      'NJJ_CODPRO': njjCodpro,
      'NJJ_UM1PRO': njjUm1Pro,
      'NJJ_CULTIV': njjCultiv,
      'NJJ_MOEGA': njjMoega,
      'NJJ_TABELA': njjTabela,
      'NJJ_TKTCLA': njjTktcla,
      'NJJ_STSCLA': njjStscla,
      'NJJ_DATPS1': njjDatps1,
      'NJJ_LOCAL': njjLocal,
      'NJJ_HORPS1': njjHorps1,
      'NJJ_PESO1': njjPeso1,
      'NJJ_MODPS1': njjModps1,
      'NJJ_DATPS2': njjDatps2,
      'NJJ_HORPS2': njjHorps2,
      'NJJ_PESO2': njjPeso2,
      'NJJ_MODPS2': njjModps2,
      'NJJ_PSSUBT': njjPssubt,
      'NJJ_PSDESC': njjPsdesc,
      'NJJ_PSBASE': njjPsbase,
      'NJJ_PSEXTR': njjPsextr,
      'NJJ_PSLIQU': njjPsliqu,
      'NJJ_STSPES': njjStspes,
      'NJJ_STATUS': njjStatus,
      'NJJ_STAFIS': njjStafis,
      'NJJ_STACTR': njjStactr,
      'NJJ_FILREL': njjFilrel,
      'NJJ_ROMREL': njjRomrel,
      'NJJ_DATA': njjData,
      'NJJ_DTRANS': njjDtrans,
      'NJJ_TIPENT': njjTipent,
      'NJJ_ROMORI': njjRomori,
      'NJJ_TRSERV': njjTrserv,
      'NJJ_CODCTR': njjCodctr,
      'NJJ_CODAUT': njjCodaut,
      'NJJ_DOCEST': njjDocest,
      'NJJ_QPAREC': njjQparec,
      'NJJ_QUSUAR': njjQusuar,
      'NJJ_ORDCLT': njjOrdclt,
      'NJJ_LIBQLD': njjLibqld,
      'NJJ_COEARR': njjCoearr,
      'NJJ_COEDEF': njjCoedef,
      'NJJ_COEDOD': njjCoedod,
      'NJJ_COEDES': njjCoedes,
      'NJJ_COEREG': njjCoereg,
      'NJJ_PESO3': njjPeso3,
      'NJJ_TPCLAS': njjTpclas,
      'NJJ_DATCHE': njjDatche,
      'NJJ_HORCHE': njjHorche,
      'NJJ_ORIGEM': njjOrigem,
      'NJJ_FAZ': njjFaz,
      'NJJ_TALHAO': njjTalhao,
      'NJJ_CODVAR': njjCodvar,
      'NJJ_EST': njjEst,
      'NJJ_DIFFIS': njjDiffis,
      'NJJ_CGC': njjCgc,
      'NJJ_DTULAL': njjDtulal,
      'NJJ_HRULAL': njjHrulal,
      'NJJ_TOETAP': njjToetap,
      'NJJ_NUMOP': njjNumop,
      'NJJ_APONOP': njjAponop,
      'NJJ_CODUNB': njjCodunb,
      'NJJ_NRAGEN': njjNragen,
      'NJJ_QTDAUT': njjQtdaut,
      'NJJ_ETAPA': njjEtapa,
      'NJJ_DTAGEN': njjDtagen,
      'NJJ_HRAGEN': njjHragen,
      'NJJ_ITPIMS': njjItpims,
      'NJJ_FILORG': njjFilorg,
      'NJJ_PESEMB': njjPesemb,
      'NJJ_STSCRG': njjStscrg,
      'NJJ_QTDFAR': njjQtdfar,
      'NJJ_NRMOV': njjNrmov,
      'NJJ_CODTRF': njjCodtrf,
      'NJJ_SEQTRF': njjSeqtrf,
      'NJJ_INDPRE': njjIndpre,
      'NJJ_CODA1U': njjCoda1U,
      'NJJ_MAPA': njjMapa,
      'NJJ_XQTTL1': njjXqttl1,
      'NJJ_XCOTL2': njjXcotl2,
      'NJJ_XQTTL2': njjXqttl2,
      'NJJ_XCOTL3': njjXcotl3,
      'NJJ_XQTTL3': njjXqttl3,
      'NJJ_XCOTL4': njjXcotl4,
      'NJJ_XQTTL4': njjXqttl4,
      'NJJ_XROREV': njjXrorev,
      'D_E_L_E_T_': dELET,
      'R_E_C_N_O_': rECNO,
      'R_E_C_D_E_L_': rECDE,
      'NJJ_XROMGE': njjXromge,
      'NJJ_USERGI': njjUsergi,
      'NJJ_USERGA': njjUserga,
      'NJJ_MSUID': njjMsuid,
      'NJJ_XFECEN': njjXfecen,
    };
  }

  factory NjjModel.fromJson(String source) =>
      NjjModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
