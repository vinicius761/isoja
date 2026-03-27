import 'package:drift/drift.dart';

@DataClassName('Producao')
@TableIndex(name: 'idx_producao_talhao', columns: {#talhao})
@TableIndex(name: 'idx_producao_data', columns: {#dataHora})
class Producoes extends Table {

  
  TextColumn get id => text()();


  @override
  Set<Column> get primaryKey => {id};

  // Dados de Origem
  TextColumn get talhao => text().withLength(min: 1, max: 50)();
  TextColumn get maquina => text().withLength(min: 1, max: 50)(); // Ex: "Colheitadeira 01" No ocntrole de Ativo iare
  
  // Dados Agronômicos
  TextColumn get cultura => text()(); // Ex: "Soja", "Milho"
  
  // Dados Quantitativos
  RealColumn get pesoEstimado => real().nullable()(); // Pode ser nulo se não tiver balança, somente 
  
  // Rastreabilidade (Opcional, pois o GPS pode falhar)
  TextColumn get gpsCoordenadas => text().nullable()(); 

  // Auditoria
  DateTimeColumn get dataHora => dateTime()();
  
  // Controle de Sincronização (Crucial para Offline First)
  // false = Salvo no tablet, precisa subir pra nuvem
  // true = Já enviado para o servidor
  BoolColumn get sincronizado => boolean().withDefault(const Constant(false))();
}