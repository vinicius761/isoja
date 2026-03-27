import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:o_soja/controller/relatorio_control.dart';
import 'package:o_soja/model/carga_model.dart';



class HistoricoScreen extends StatefulWidget {
  const HistoricoScreen({super.key});

  @override
  State<HistoricoScreen> createState() => _HistoricoScreenState();
}

class _HistoricoScreenState extends State<HistoricoScreen> {
  final HistoricoController _controller = HistoricoController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // 2 Abas
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Gestão de Cargas"),
          backgroundColor: const Color(0xFF1B5E20),
          foregroundColor: Colors.white,
          bottom: const TabBar(
            indicatorColor: Colors.amber, // Cor de destaque na aba ativa
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(icon: Icon(Icons.local_shipping), text: "EM TRÂNSITO"),
              Tab(icon: Icon(Icons.check_circle), text: "FINALIZADAS"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // ABA 1: EM TRÂNSITO
            _buildListaCargas(_controller.emTransito, isFinalizada: false),
            
            // ABA 2: FINALIZADAS
            _buildListaCargas(_controller.finalizadas, isFinalizada: true),
          ],
        ),
      ),
    );
  }

  Widget _buildListaCargas(List<CargaModel> lista, {required bool isFinalizada}) {
    if (lista.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(isFinalizada ? Icons.assignment_turned_in : Icons.commute, size: 60, color: Colors.grey[300]),
            const SizedBox(height: 10),
            Text("Nenhuma carga encontrada.", style: TextStyle(color: Colors.grey[500])),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: lista.length,
      itemBuilder: (context, index) {
        final carga = lista[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            // Ícone lateral
            leading: CircleAvatar(
              backgroundColor: isFinalizada ? Colors.blue[100] : Colors.orange[100],
              child: Icon(
                isFinalizada ? Icons.warehouse : Icons.fire_truck, 
                color: isFinalizada ? Colors.blue[800] : Colors.orange[800]
              ),
            ),
            // Título (Placa)
            title: Text(
              carga.placa, 
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
            ),
            // Subtítulo (Detalhes)
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text("${carga.motorista} • ${carga.talhao}"),
                Text(
                  DateFormat('dd/MM HH:mm').format(carga.dataHora),
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
            // Ação (PDF ou Detalhes)
            trailing: isFinalizada
                ? IconButton(
                    icon: const Icon(Icons.picture_as_pdf, color: Colors.red),
                    onPressed: () => _controller.gerarPdf(context, carga),
                    tooltip: "Gerar Ticket PDF",
                  )
                : const Chip(
                    label: Text("Aberto", style: TextStyle(color: Colors.white, fontSize: 10)),
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.zero,
                  ),
            onTap: () {
              // Teste
            },
          ),
        );
      },
    );
  }
}