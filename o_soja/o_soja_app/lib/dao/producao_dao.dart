import 'package:drift/drift.dart';
import 'package:o_soja/dao/database.dart';
import 'package:o_soja/model/producao_table.dart';
import 'package:uuid/uuid.dart';


part 'producao_dao.g.dart'; // O gerador vai criar este arquivo

@DriftAccessor(tables: [Producoes])
class ProducoesDao extends DatabaseAccessor<AppDatabase> with _$ProducoesDaoMixin {
  final _uuid = const Uuid();
  
  ProducoesDao(AppDatabase db) : super(db);

  // ===========================================================================
  // 1. CREATE (Inserir)
  // ===========================================================================
  
  /// Insere um novo registro de produção.
  /// Retorna o ID do registro criado.
Future<String> insertProducao(ProducoesCompanion entry) async {
  final idGerado = _uuid.v4(); 
  
  final entradaComId = entry.copyWith(
    id: Value(idGerado), 
  );

  await into(producoes).insert(entradaComId);
  return idGerado;
}


  Future<void> insertLote(List<ProducoesCompanion> lista) async {
    await batch((batch) {
      batch.insertAll(producoes, lista);
    });
  }

  // ===========================================================================
  // 2. READ (Ler / Consultar)
  // ===========================================================================


  /// Retorna Stream para a tela atualizar sozinha.
  Stream<List<Producao>> watchTodasProducoes() {
    return (select(producoes)
      ..orderBy([(t) => OrderingTerm(expression: t.dataHora, mode: OrderingMode.desc)]))
      .watch();
  }

  /// Retorna lista para relatórios (Sem Stream, apenas Future).
  Future<List<Producao>> getAllProducoes() {
    return (select(producoes)
      ..orderBy([(t) => OrderingTerm(expression: t.dataHora, mode: OrderingMode.desc)]))
      .get();
  }

  /// Filtra produções por Talhão (Usando o Índice criado).
  Future<List<Producao>> getPorTalhao(String talhaoAlvo) {
    return (select(producoes)..where((t) => t.talhao.equals(talhaoAlvo))).get();
  }

  /// Busca registros que ainda não foram enviados para o servidor (Sync).
  Future<List<Producao>> getPendentesSincronizacao() {
    return (select(producoes)..where((t) => t.sincronizado.equals(false))).get();
  }

  /// Relatório Rápido: Soma total de peso colhido hoje
  Future<double?> getTotalPesoHoje() {
    final hoje = DateTime.now();
    final inicioDia = DateTime(hoje.year, hoje.month, hoje.day);
    
    // Query de agregação SQL
    final somaPeso = producoes.pesoEstimado.sum();
    final query = selectOnly(producoes)
      ..addColumns([somaPeso])
      ..where(producoes.dataHora.isBiggerOrEqualValue(inicioDia));

    return query.map((row) => row.read(somaPeso)).getSingle();
  }

  // ===========================================================================
  // 3. UPDATE (Atualizar)
  // ===========================================================================

  /// Atualiza um registro existente.
  /// Útil se o operador errou o peso ou a máquina.
 // 3. UPDATE
  Future<bool> updateProducao(ProducoesCompanion entry) {
    return update(producoes).replace(entry);
  }

  /// Marca uma lista de IDs como Sincronizados (Após envio para API).
 Future<void> marcarComoSincronizado(List<String> ids) async { // <--- Mude para String
  await (update(producoes)..where((t) => t.id.isIn(ids)))
      .write(ProducoesCompanion(sincronizado: Value(true)));
}

  // ===========================================================================
  // 4. DELETE (Remover)
  // ===========================================================================

  /// Remove um registro pelo ID.
  Future<int> deleteProducao(String id) {
    return (delete(producoes)..where((t) => t.id.equals(id))).go();
  }
  
  /// Limpeza: Remove registros muito antigos (ex: mais de 1 ano) para liberar espaço
  Future<int> limparHistoricoAntigo() {
    final dataLimite = DateTime.now().subtract(const Duration(days: 365));
    return (delete(producoes)
      ..where((t) => t.dataHora.isSmallerThanValue(dataLimite))
      ..where((t) => t.sincronizado.equals(true)) // Só apaga se já subiu pra nuvem
    ).go();
  }
}