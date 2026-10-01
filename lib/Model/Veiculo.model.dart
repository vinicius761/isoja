class Veiculo {
  final int? id;
  final String filial;
  final String cod;
  final String descricao;
  final String placa;
  final String estpla;
  final String codmun;
  final String munpla;
  final String tag;
  final String ativo;
  final String status;
  final String datsts;
  final String horsts;
  final double capacn;
  final double capacm;
  final double limmax;
  final double tara;
  final double volmax;
  final double maxvol;
  final double qtduni;
  final String unitiz;
  final double altint;
  final double larint;
  final double comint;
  final double altext;
  final double larext;
  final double comext;
  final String anofab;
  final String anomod;
  final String chassi;
  final String renava;
  final String marvei;
  final String corvei;
  final String tipvei;
  final String tipgrp;
  final String rodage;
  final double qtdeix;
  final double qteixv;
  final String bitmap;
  final String frovei;
  final String motori;
  final String codfor;
  final String lojfor;
  final String codfav;
  final String lojfav;
  final String codbem;
  final String codgru;
  final String filatu;
  final String filbas;
  final String filvga;
  final String numvga;
  final String filprv;
  final String datprv;
  final String horprv;
  final double veloc;
  final String libseg;
  final String dtivsg;
  final String dtfvsg;
  final String civ;
  final double cipp;
  final String veiras;
  final double custo1;
  final double custo2;
  final double custo3;
  final double custo4;
  final double custo5;
  final String sertms;
  final String tiptra;
  final String gstdmd;
  final String intope;
  final String integr;
  final String mults;
  final String dELet;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Veiculo({
    this.id,
    required this.filial,
    required this.cod,
    required this.descricao,
    required this.placa,
    required this.estpla,
    this.codmun = '',
    this.munpla = '',
    this.tag = '',
    this.ativo = '1',
    this.status = '1',
    this.datsts = '',
    this.horsts = '',
    this.capacn = 0.0,
    this.capacm = 0.0,
    this.limmax = 0.0,
    this.tara = 0.0,
    this.volmax = 0.0,
    this.maxvol = 0.0,
    this.qtduni = 0.0,
    this.unitiz = '',
    this.altint = 0.0,
    this.larint = 0.0,
    this.comint = 0.0,
    this.altext = 0.0,
    this.larext = 0.0,
    this.comext = 0.0,
    this.anofab = '',
    this.anomod = '',
    required this.chassi,
    required this.renava,
    this.marvei = '',
    this.corvei = '',
    this.tipvei = '',
    this.tipgrp = '',
    this.rodage = '',
    this.qtdeix = 0.0,
    this.qteixv = 0.0,
    this.bitmap = '',
    this.frovei = '1',
    this.motori = '',
    this.codfor = '',
    this.lojfor = '',
    this.codfav = '',
    this.lojfav = '',
    this.codbem = '',
    this.codgru = '',
    this.filatu = '',
    this.filbas = '',
    this.filvga = '',
    this.numvga = '',
    this.filprv = '',
    this.datprv = '',
    this.horprv = '',
    this.veloc = 0.0,
    this.libseg = '',
    this.dtivsg = '',
    this.dtfvsg = '',
    this.civ = '',
    this.cipp = 0.0,
    this.veiras = 'N',
    this.custo1 = 0.0,
    this.custo2 = 0.0,
    this.custo3 = 0.0,
    this.custo4 = 0.0,
    this.custo5 = 0.0,
    this.sertms = '',
    this.tiptra = '',
    this.gstdmd = '',
    this.intope = '',
    this.integr = '',
    this.mults = '',
    this.dELet = ' ',
    this.createdAt,
    this.updatedAt,
  });

  factory Veiculo.fromJson(Map<String, dynamic> json) {
    return Veiculo(
      id: json['id'] ?? json['DA3_ID'],
      filial: json['filial'] ?? json['DA3_FILIAL'] ?? '',
      cod: json['cod'] ?? json['DA3_COD'] ?? '',
      descricao: json['descricao'] ?? json['DA3_DESC'] ?? '',
      placa: json['placa'] ?? json['DA3_PLACA'] ?? '',
      estpla: json['estpla'] ?? json['DA3_ESTPLA'] ?? '',
      codmun: json['codmun'] ?? json['DA3_CODMUN'] ?? '',
      munpla: json['munpla'] ?? json['DA3_MUNPLA'] ?? '',
      tag: json['tag'] ?? json['DA3_TAG'] ?? '',
      ativo: json['ativo'] ?? json['DA3_ATIVO'] ?? '1',
      status: json['status'] ?? json['DA3_STATUS'] ?? '1',
      datsts: json['datsts'] ?? json['DA3_DATSTS'] ?? '',
      horsts: json['horsts'] ?? json['DA3_HORSTS'] ?? '',
      capacn: (json['capacn'] ?? json['DA3_CAPACN'] as num?)?.toDouble() ?? 0.0,
      capacm: (json['capacm'] ?? json['DA3_CAPACM'] as num?)?.toDouble() ?? 0.0,
      limmax: (json['limmax'] ?? json['DA3_LIMMAX'] as num?)?.toDouble() ?? 0.0,
      tara: (json['tara'] ?? json['DA3_TARA'] as num?)?.toDouble() ?? 0.0,
      volmax: (json['volmax'] ?? json['DA3_VOLMAX'] as num?)?.toDouble() ?? 0.0,
      maxvol: (json['maxvol'] ?? json['DA3_MAXVOL'] as num?)?.toDouble() ?? 0.0,
      qtduni: (json['qtduni'] ?? json['DA3_QTDUNI'] as num?)?.toDouble() ?? 0.0,
      unitiz: json['unitiz'] ?? json['DA3_UNITIZ'] ?? '',
      altint: (json['altint'] ?? json['DA3_ALTINT'] as num?)?.toDouble() ?? 0.0,
      larint: (json['larint'] ?? json['DA3_LARINT'] as num?)?.toDouble() ?? 0.0,
      comint: (json['comint'] ?? json['DA3_COMINT'] as num?)?.toDouble() ?? 0.0,
      altext: (json['altext'] ?? json['DA3_ALTEXT'] as num?)?.toDouble() ?? 0.0,
      larext: (json['larext'] ?? json['DA3_LAREXT'] as num?)?.toDouble() ?? 0.0,
      comext: (json['comext'] ?? json['DA3_COMEXT'] as num?)?.toDouble() ?? 0.0,
      anofab: json['anofab'] ?? json['DA3_ANOFAB'] ?? '',
      anomod: json['anomod'] ?? json['DA3_ANOMOD'] ?? '',
      chassi: json['chassi'] ?? json['DA3_CHASSI'] ?? '',
      renava: json['renava'] ?? json['DA3_RENAVA'] ?? '',
      marvei: json['marvei'] ?? json['DA3_MARVEI'] ?? '',
      corvei: json['corvei'] ?? json['DA3_CORVEI'] ?? '',
      tipvei: json['tipvei'] ?? json['DA3_TIPVEI'] ?? '',
      tipgrp: json['tipgrp'] ?? json['DA3_TIPGRP'] ?? '',
      rodage: json['rodage'] ?? json['DA3_RODAGE'] ?? '',
      qtdeix: (json['qtdeix'] ?? json['DA3_QTDEIX'] as num?)?.toDouble() ?? 0.0,
      qteixv: (json['qteixv'] ?? json['DA3_QTEIXV'] as num?)?.toDouble() ?? 0.0,
      bitmap: json['bitmap'] ?? json['DA3_BITMAP'] ?? '',
      frovei: json['frovei'] ?? json['DA3_FROVEI'] ?? '1',
      motori: json['motori'] ?? json['DA3_MOTORI'] ?? '',
      codfor: json['codfor'] ?? json['DA3_CODFOR'] ?? '',
      lojfor: json['lojfor'] ?? json['DA3_LOJFOR'] ?? '',
      codfav: json['codfav'] ?? json['DA3_CODFAV'] ?? '',
      lojfav: json['lojfav'] ?? json['DA3_LOJFAV'] ?? '',
      codbem: json['codbem'] ?? json['DA3_CODBEM'] ?? '',
      codgru: json['codgru'] ?? json['DA3_CODGRU'] ?? '',
      filatu: json['filatu'] ?? json['DA3_FILATU'] ?? '',
      filbas: json['filbas'] ?? json['DA3_FILBAS'] ?? '',
      filvga: json['filvga'] ?? json['DA3_FILVGA'] ?? '',
      numvga: json['numvga'] ?? json['DA3_NUMVGA'] ?? '',
      filprv: json['filprv'] ?? json['DA3_FILPRV'] ?? '',
      datprv: json['datprv'] ?? json['DA3_DATPRV'] ?? '',
      horprv: json['horprv'] ?? json['DA3_HORPRV'] ?? '',
      veloc: (json['veloc'] ?? json['DA3_VELOC'] as num?)?.toDouble() ?? 0.0,
      libseg: json['libseg'] ?? json['DA3_LIBSEG'] ?? '',
      dtivsg: json['dtivsg'] ?? json['DA3_DTIVSG'] ?? '',
      dtfvsg: json['dtfvsg'] ?? json['DA3_DTFVSG'] ?? '',
      civ: json['civ'] ?? json['DA3_CIV'] ?? '',
      cipp: (json['cipp'] ?? json['DA3_CIPP'] as num?)?.toDouble() ?? 0.0,
      veiras: json['veiras'] ?? json['DA3_VEIRAS'] ?? 'N',
      custo1: (json['custo1'] ?? json['DA3_CUSTO1'] as num?)?.toDouble() ?? 0.0,
      custo2: (json['custo2'] ?? json['DA3_CUSTO2'] as num?)?.toDouble() ?? 0.0,
      custo3: (json['custo3'] ?? json['DA3_CUSTO3'] as num?)?.toDouble() ?? 0.0,
      custo4: (json['custo4'] ?? json['DA3_CUSTO4'] as num?)?.toDouble() ?? 0.0,
      custo5: (json['custo5'] ?? json['DA3_CUSTO5'] as num?)?.toDouble() ?? 0.0,
      sertms: json['sertms'] ?? json['DA3_SERTMS'] ?? '',
      tiptra: json['tiptra'] ?? json['DA3_TIPTRA'] ?? '',
      gstdmd: json['gstdmd'] ?? json['DA3_GSTDMD'] ?? '',
      intope: json['intope'] ?? json['DA3_INTOPE'] ?? '',
      integr: json['integr'] ?? json['DA3_INTEGR'] ?? '',
      mults: json['mults'] ?? json['DA3_MULTS'] ?? '',
      dELet: json['D_E_L_E_T_'] ?? ' ',
      createdAt:
          json['created_at'] != null
              ? DateTime.tryParse(json['created_at'].toString())
              : null,
      updatedAt:
          json['updated_at'] != null
              ? DateTime.tryParse(json['updated_at'].toString())
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'filial': filial,
      'cod': cod,
      'descricao': descricao,
      'placa': placa,
      'estpla': estpla,
      'codmun': codmun,
      'munpla': munpla,
      'tag': tag,
      'ativo': ativo,
      'status': status,
      'datsts': datsts,
      'horsts': horsts,
      'capacn': capacn,
      'capacm': capacm,
      'limmax': limmax,
      'tara': tara,
      'volmax': volmax,
      'maxvol': maxvol,
      'qtduni': qtduni,
      'unitiz': unitiz,
      'altint': altint,
      'larint': larint,
      'comint': comint,
      'altext': altext,
      'larext': larext,
      'comext': comext,
      'anofab': anofab,
      'anomod': anomod,
      'chassi': chassi,
      'renava': renava,
      'marvei': marvei,
      'corvei': corvei,
      'tipvei': tipvei,
      'tipgrp': tipgrp,
      'rodage': rodage,
      'qtdeix': qtdeix,
      'qteixv': qteixv,
      'bitmap': bitmap,
      'frovei': frovei,
      'motori': motori,
      'codfor': codfor,
      'lojfor': lojfor,
      'codfav': codfav,
      'lojfav': lojfav,
      'codbem': codbem,
      'codgru': codgru,
      'filatu': filatu,
      'filbas': filbas,
      'filvga': filvga,
      'numvga': numvga,
      'filprv': filprv,
      'datprv': datprv,
      'horprv': horprv,
      'veloc': veloc,
      'libseg': libseg,
      'dtivsg': dtivsg,
      'dtfvsg': dtfvsg,
      'civ': civ,
      'cipp': cipp,
      'veiras': veiras,
      'custo1': custo1,
      'custo2': custo2,
      'custo3': custo3,
      'custo4': custo4,
      'custo5': custo5,
      'sertms': sertms,
      'tiptra': tiptra,
      'gstdmd': gstdmd,
      'intope': intope,
      'integr': integr,
      'mults': mults,
      'D_E_L_E_T_': dELet,
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
    };
  }
}
