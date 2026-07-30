import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:o_soja/View/Carga.dart';
import 'package:o_soja/View/descarga.dart';
import 'package:o_soja/View/producao_view.dart';
import 'package:o_soja/View/relatorio.dart';
import 'package:o_soja/widgets/menu_card.dart';
  // Import do Widget isolado

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Configura StatusBar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 174, 229),
      body: Stack(
        children: [
          // --- HEADER ---
          Container(
            height: size.height * 0.35,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 6, 39, 59),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
          ),

          // --- CONTEÚDO ---
          SafeArea(
            child: Column(
              children: [
                _buildHeaderInfo(), // Método privado para limpar o build
                const SizedBox(height: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.95,
                      children: [
                        MenuCardWidget(
                          title: "Produção",
                          subtitle: "Apontamento",
                          icon: Icons.grass,
                          color: const Color(0xFF2E7D32),
                         onTap: () => _navegar(context, const FormProducaoScreen()),// Adicionar tela depois
                        ),
                        MenuCardWidget(
                          title: "Nova Carga",
                          subtitle: "Expedição",
                          icon: Icons.local_shipping_outlined,
                          color: const Color(0xFFE65100),
                          onTap: () => _navegar(context, const FormCargaScreen()),
                        ),
                        MenuCardWidget(
                          title: "Descarga",
                          subtitle: "Recebimento",
                          icon: Icons.warehouse_outlined,
                          color: const Color(0xFF1565C0),
                          onTap: () => _navegar(context, const FormDescargaScreen()),
                        ),
                        MenuCardWidget(
                          title: "Controle",
                          subtitle: "Relatorio",
                          icon: Icons.speed,
                          color: const Color(0xFF455A64),
                          onTap: () => _navegar(context, const HistoricoScreen()),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navegar(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  Widget _buildHeaderInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Olá, Ozielton", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  Text("Fazenda Teste", style: TextStyle(color: Colors.white70, fontSize: 14)),
                ],
              ),
              CircleAvatar(radius: 24, backgroundColor: Colors.white24, child: const Icon(Icons.person, color: Colors.white)),
            ],
          ),
          const SizedBox(height: 20),
          // Status Offline
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white30),
            ),
            child: const Row(
              children: [
                Icon(Icons.cloud_off, color: Colors.amber, size: 28),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Modo Offline", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Text("Pronto para operar sem sinal", style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}