import 'package:flutter/material.dart';
import 'package:o_soja/model/carga_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw; // Alias para não confundir com Widgets do Flutter
import 'package:printing/printing.dart';
import 'package:intl/intl.dart'; // Para formatar datas

class HistoricoController extends ChangeNotifier {
  // --- MOCK DE DADOS (Simulando banco de dados) ---
  final List<CargaModel> todasCargas = [
    CargaModel(id: "IARE-901", placa: "ABC-1234", motorista: "Ozielton", talhao: "Talhão 01", peso: 32500, dataHora: DateTime.now().subtract(Duration(hours: 2)), status: StatusCarga.emTransito),
    CargaModel(id: "IARE-902", placa: "QWE-9876", motorista: "Rodrigues Dias", talhao: "Talhão 02", peso: 45000, dataHora: DateTime.now().subtract(Duration(days: 1)), status: StatusCarga.finalizada),
    CargaModel(id: "IARE-903", placa: "XYZ-5555", motorista: "Dias Rodrigues", talhao: "Talhão 06", peso: 31200, dataHora: DateTime.now().subtract(Duration(days: 2)), status: StatusCarga.finalizada),
  ];

  // Getters filtrados
  List<CargaModel> get emTransito => todasCargas.where((c) => c.status == StatusCarga.emTransito).toList();
  List<CargaModel> get finalizadas => todasCargas.where((c) => c.status == StatusCarga.finalizada).toList();

  // --- GERADOR DE PDF ---
  Future<void> gerarPdf(BuildContext context, CargaModel carga) async {
    final doc = pw.Document();

    // Carrega uma fonte padrão (opcional, mas recomendado)
    final fontBold = await PdfGoogleFonts.robotoBold();
    final fontRegular = await PdfGoogleFonts.robotoRegular();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // 1. CABEÇALHO
              pw.Header(
                level: 0,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("IARE - O_Soja", style: pw.TextStyle(font: fontBold, fontSize: 24, color: PdfColors.blue600)),
                    pw.Text("TICKET #${carga.id}", style: pw.TextStyle(font: fontBold, fontSize: 18,color: PdfColors.blue600)),
                  ]
                )
              ),
              pw.SizedBox(height: 20),

              // 2. DETALHES EM GRID
              pw.Container(
                decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey400), borderRadius: pw.BorderRadius.circular(4)),
                padding: const pw.EdgeInsets.all(10),
                child: pw.Column(
                  children: [
                    _buildPdfRow("Data de Emissão", DateFormat('dd/MM/yyyy HH:mm').format(carga.dataHora), fontBold, fontRegular),
                    pw.Divider(),
                    _buildPdfRow("Origem", "Fazenda Teste - ${carga.talhao}", fontBold, fontRegular),
                    pw.Divider(),
                    _buildPdfRow("Destino", "Silo Armazém Teste", fontBold, fontRegular),
                  ]
                )
              ),
              pw.SizedBox(height: 20),

              // 3. DADOS DO TRANSPORTE
              pw.Text("DADOS DO TRANSPORTE", style: pw.TextStyle(font: fontBold, fontSize: 14)),
              pw.SizedBox(height: 5),
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.grey),
                children: [
                  pw.TableRow(children: [
                    _buildTableCell("Motorista", carga.motorista, fontBold),
                    _buildTableCell("Placa", carga.placa, fontBold),
                  ]),
                  pw.TableRow(children: [
                    _buildTableCell("Peso Líquido", "${carga.peso} kg", fontBold),
                    _buildTableCell("Produto", "Soja a Granel", fontBold),
                  ]),
                ]
              ),

              pw.SizedBox(height: 50),

              // 4. ASSINATURAS
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  _buildSignatureLine("Assinatura do Motorista"),
                  _buildSignatureLine("Assinatura do Balanceiro"),
                ]
              ),

              // 5. RODAPÉ
              pw.Spacer(),
              pw.Center(child: pw.Text("Gerado automaticamente pelo sistema O_Soja App", style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey))),
            ],
          );
        },
      ),
    );

    // Abre a tela de pré-visualização/compartilhamento do PDF
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save(),
      name: 'Ticket_${carga.id}.pdf',
    );
  }

  // --- Helpers de Layout PDF ---
  pw.Widget _buildPdfRow(String label, String value, pw.Font fontB, pw.Font fontR) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label, style: pw.TextStyle(font: fontB)),
          pw.Text(value, style: pw.TextStyle(font: fontR)),
        ]
      )
    );
  }

  pw.Widget _buildTableCell(String label, String value, pw.Font font) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(label, style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600)),
          pw.Text(value, style: pw.TextStyle(font: font, fontSize: 12)),
        ]
      )
    );
  }

  pw.Widget _buildSignatureLine(String label) {
    return pw.Column(
      children: [
        pw.Container(width: 150, height: 1, color: PdfColors.black),
        pw.SizedBox(height: 5),
        pw.Text(label, style: const pw.TextStyle(fontSize: 10)),
      ]
    );
  }
}