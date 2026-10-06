class Motorista {
  String? da4Filial;
  int? da4Cod;
  String? da4Nome;
  String? da4Tipmot;
  String? da4Fornec;
  String? da4Loja;
  String? da4Filbas;
  String? da4Mat;
  String? da4Nreduz;
  String? da4End;
  String? da4Bairro;
  String? da4Mun;
  String? da4Est;
  String? da4Cep;
  String? da4Ddd;
  String? da4Cgc;
  String? da4Tel;
  String? da4Ajuda1;
  String? da4Ajuda2;
  String? da4Ajuda3;
  String? da4Numcnh;
  String? da4Regcnh;
  String? da4Dtecnh;
  String? da4Dtvcnh;
  String? da4Muncnh;
  String? da4Estcnh;
  String? da4Catcnh;
  String? da4Pai;
  String? da4Mae;
  String? da4Telrec;
  String? da4Falcom;
  String? da4Rg;
  String? da4Rgorg;
  String? da4Rgest;
  String? da4Corpel;
  String? da4Corcab;
  String? da4Corbar;
  String? da4Corolh;
  String? da4Sinais;
  double? da4Altura;
  double? da4Peso;
  String? da4Datnas;
  String? da4Estciv;
  String? da4Numseg;
  String? da4Libseg;
  String? da4Dtivsg;
  String? da4Dtfvsg;
  double? da4Valseg;
  String? da4Carper;
  String? da4Blqmot;
  String? da4Comiss;
  String? da4Bitmap;
  String? da4Rgdt;
  String? da4Idope;
  String? da4Pais;
  String? da4Codmun;
  String? da4Filatu;
  String? da4Status;
  String? da4Applog;
  String? da4Email;
  String? da4Codcli;
  String? da4Lojcli;

  Motorista({
    this.da4Filial,
    this.da4Cod,
    this.da4Nome,
    this.da4Tipmot,
    this.da4Fornec,
    this.da4Loja,
    this.da4Filbas,
    this.da4Mat,
    this.da4Nreduz,
    this.da4End,
    this.da4Bairro,
    this.da4Mun,
    this.da4Est,
    this.da4Cep,
    this.da4Ddd,
    this.da4Cgc,
    this.da4Tel,
    this.da4Ajuda1,
    this.da4Ajuda2,
    this.da4Ajuda3,
    this.da4Numcnh,
    this.da4Regcnh,
    this.da4Dtecnh,
    this.da4Dtvcnh,
    this.da4Muncnh,
    this.da4Estcnh,
    this.da4Catcnh,
    this.da4Pai,
    this.da4Mae,
    this.da4Telrec,
    this.da4Falcom,
    this.da4Rg,
    this.da4Rgorg,
    this.da4Rgest,
    this.da4Corpel,
    this.da4Corcab,
    this.da4Corbar,
    this.da4Corolh,
    this.da4Sinais,
    this.da4Altura,
    this.da4Peso,
    this.da4Datnas,
    this.da4Estciv,
    this.da4Numseg,
    this.da4Libseg,
    this.da4Dtivsg,
    this.da4Dtfvsg,
    this.da4Valseg,
    this.da4Carper,
    this.da4Blqmot,
    this.da4Comiss,
    this.da4Bitmap,
    this.da4Rgdt,
    this.da4Idope,
    this.da4Pais,
    this.da4Codmun,
    this.da4Filatu,
    this.da4Status,
    this.da4Applog,
    this.da4Email,
    this.da4Codcli,
    this.da4Lojcli,
  });

  factory Motorista.fromJson(Map<String, dynamic> json) {
    return Motorista(
      da4Filial: json['da4Filial'] as String?,
      da4Cod: json['da4Cod'],
      da4Nome: json['da4Nome'] as String?,
      da4Tipmot: json['da4Tipmot'] as String?,
      da4Fornec: json['da4Fornec'] as String?,
      da4Loja: json['da4Loja'] as String?,
      da4Filbas: json['da4Filbas'] as String?,
      da4Mat: json['da4Mat'] as String?,
      da4Nreduz: json['da4Nreduz'] as String?,
      da4End: json['da4End'] as String?,
      da4Bairro: json['da4Bairro'] as String?,
      da4Mun: json['da4Mun'] as String?,
      da4Est: json['da4Est'] as String?,
      da4Cep: json['da4Cep'] as String?,
      da4Ddd: json['da4Ddd'] as String?,
      da4Cgc: json['da4Cgc'] as String?,
      da4Tel: json['da4Tel'] as String?,
      da4Ajuda1: json['da4Ajuda1'] as String?,
      da4Ajuda2: json['da4Ajuda2'] as String?,
      da4Ajuda3: json['da4Ajuda3'] as String?,
      da4Numcnh: json['da4Numcnh'] as String?,
      da4Regcnh: json['da4Regcnh'] as String?,
      da4Dtecnh: json['da4Dtecnh'] as String?,
      da4Dtvcnh: json['da4Dtvcnh'] as String?,
      da4Muncnh: json['da4Muncnh'] as String?,
      da4Estcnh: json['da4Estcnh'] as String?,
      da4Catcnh: json['da4Catcnh'] as String?,
      da4Pai: json['da4Pai'] as String?,
      da4Mae: json['da4Mae'] as String?,
      da4Telrec: json['da4Telrec'] as String?,
      da4Falcom: json['da4Falcom'] as String?,
      da4Rg: json['da4Rg'] as String?,
      da4Rgorg: json['da4Rgorg'] as String?,
      da4Rgest: json['da4Rgest'] as String?,
      da4Corpel: json['da4Corpel'] as String?,
      da4Corcab: json['da4Corcab'] as String?,
      da4Corbar: json['da4Corbar'] as String?,
      da4Corolh: json['da4Corolh'] as String?,
      da4Sinais: json['da4Sinais'] as String?,
      da4Altura: (json['da4Altura'] as num?)?.toDouble(),
      da4Peso: (json['da4Peso'] as num?)?.toDouble(),
      da4Datnas: json['da4Datnas'] as String?,
      da4Estciv: json['da4Estciv'] as String?,
      da4Numseg: json['da4Numseg'] as String?,
      da4Libseg: json['da4Libseg'] as String?,
      da4Dtivsg: json['da4Dtivsg'] as String?,
      da4Dtfvsg: json['da4Dtfvsg'] as String?,
      da4Valseg: (json['da4Valseg'] as num?)?.toDouble(),
      da4Carper: json['da4Carper'] as String?,
      da4Blqmot: json['da4Blqmot'] as String?,
      da4Comiss: json['da4Comiss'] as String?,
      da4Bitmap: json['da4Bitmap'] as String?,
      da4Rgdt: json['da4Rgdt'] as String?,
      da4Idope: json['da4Idope'] as String?,
      da4Pais: json['da4Pais'] as String?,
      da4Codmun: json['da4Codmun'] as String?,
      da4Filatu: json['da4Filatu'] as String?,
      da4Status: json['da4Status'] as String?,
      da4Applog: json['da4Applog'] as String?,
      da4Email: json['da4Email'] as String?,
      da4Codcli: json['da4Codcli'] as String?,
      da4Lojcli: json['da4Lojcli'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'da4Filial': da4Filial,
      'da4Cod': da4Cod,
      'da4Nome': da4Nome,
      'da4Tipmot': da4Tipmot,
      'da4Fornec': da4Fornec,
      'da4Loja': da4Loja,
      'da4Filbas': da4Filbas,
      'da4Mat': da4Mat,
      'da4Nreduz': da4Nreduz,
      'da4End': da4End,
      'da4Bairro': da4Bairro,
      'da4Mun': da4Mun,
      'da4Est': da4Est,
      'da4Cep': da4Cep,
      'da4Ddd': da4Ddd,
      'da4Cgc': da4Cgc,
      'da4Tel': da4Tel,
      'da4Ajuda1': da4Ajuda1,
      'da4Ajuda2': da4Ajuda2,
      'da4Ajuda3': da4Ajuda3,
      'da4Numcnh': da4Numcnh,
      'da4Regcnh': da4Regcnh,
      'da4Dtecnh': da4Dtecnh,
      'da4Dtvcnh': da4Dtvcnh,
      'da4Muncnh': da4Muncnh,
      'da4Estcnh': da4Estcnh,
      'da4Catcnh': da4Catcnh,
      'da4Pai': da4Pai,
      'da4Mae': da4Mae,
      'da4Telrec': da4Telrec,
      'da4Falcom': da4Falcom,
      'da4Rg': da4Rg,
      'da4Rgorg': da4Rgorg,
      'da4Rgest': da4Rgest,
      'da4Corpel': da4Corpel,
      'da4Corcab': da4Corcab,
      'da4Corbar': da4Corbar,
      'da4Corolh': da4Corolh,
      'da4Sinais': da4Sinais,
      'da4Altura': da4Altura,
      'da4Peso': da4Peso,
      'da4Datnas': da4Datnas,
      'da4Estciv': da4Estciv,
      'da4Numseg': da4Numseg,
      'da4Libseg': da4Libseg,
      'da4Dtivsg': da4Dtivsg,
      'da4Dtfvsg': da4Dtfvsg,
      'da4Valseg': da4Valseg,
      'da4Carper': da4Carper,
      'da4Blqmot': da4Blqmot,
      'da4Comiss': da4Comiss,
      'da4Bitmap': da4Bitmap,
      'da4Rgdt': da4Rgdt,
      'da4Idope': da4Idope,
      'da4Pais': da4Pais,
      'da4Codmun': da4Codmun,
      'da4Filatu': da4Filatu,
      'da4Status': da4Status,
      'da4Applog': da4Applog,
      'da4Email': da4Email,
      'da4Codcli': da4Codcli,
      'da4Lojcli': da4Lojcli,
    };
  }
}
