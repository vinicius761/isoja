class UserFilialModel {
  final String codFilial;
  final String filialDesc;
  final String codUser;
  final String user;

  UserFilialModel({
    required this.codFilial,
    required this.filialDesc,
    required this.codUser,
    required this.user,
  });

  factory UserFilialModel.fromJson(Map<String, dynamic> json) {
    return UserFilialModel(
      codFilial: json['COD_FILIAL']?.toString() ?? '',
      filialDesc: json['FILIAL_DESC']?.trim().toString() ?? '',
      codUser: json['COD_USER']?.toString() ?? '',
      user: json['USER']?.toString() ?? '',
    );
  }

  factory UserFilialModel.fromMap(Map<String, dynamic> map) {
    return UserFilialModel(
      codFilial: map['COD_FILIAL']?.toString() ?? '',
      filialDesc: map['FILIAL_DESC']?.toString() ?? '',
      codUser: map['COD_USER']?.toString() ?? '',
      user: map['USER']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'COD_FILIAL': codFilial,
      'FILIAL_DESC': filialDesc,
      'COD_USER': codUser,
      'USER': user,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'cod_filial': codFilial,
      'filial_desc': filialDesc,
      'cod_user': codUser,
      'user': user,
    };
  }

  UserFilialModel copyWith({
    String? codFilial,
    String? filialDesc,
    String? codUser,
    String? user,
  }) {
    return UserFilialModel(
      codFilial: codFilial ?? this.codFilial,
      filialDesc: filialDesc ?? this.filialDesc,
      codUser: codUser ?? this.codUser,
      user: user ?? this.user,
    );
  }
}
