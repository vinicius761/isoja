import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';

class DatePickerWidget extends StatelessWidget {
  final DateTime? dataInicio;
  final DateTime? dataFim;
  final Function(DateTime) onDataInicioChanged;
  final Function(DateTime) onDataFimChanged;
  final DateFormat _formatadorData = DateFormat('dd/MM/yyyy');

  DatePickerWidget({
    required this.dataInicio,
    required this.dataFim,
    required this.onDataInicioChanged,
    required this.onDataFimChanged,
  });

  void _mostrarSeletorData(BuildContext context, bool dataInicial) {
    DatePicker.showDatePicker(
      context,
      locale: DateTimePickerLocale.pt_br,
      dateFormat: 'dd-MMMM-yyyy',
      initialDateTime:
          dataInicial
              ? dataInicio ?? DateTime.now()
              : (dataFim ?? dataInicio ?? DateTime.now()),
      minDateTime: dataInicial ? null : dataInicio,
      maxDateTime: dataInicial ? dataFim : null,
      onConfirm: (DateTime dateTime, List<int> index) {
        if (dataInicial) {
          onDataInicioChanged(dateTime);
          if (dataFim == null || dataFim!.isBefore(dateTime)) {
            onDataFimChanged(dateTime.add(Duration(days: 1)));
          }
        } else {
          onDataFimChanged(dateTime);
        }
      },
      pickerTheme: DateTimePickerTheme(
        backgroundColor: Colors.white,
        itemTextStyle: TextStyle(color: Colors.black, fontSize: 18),
        confirm: Text('Confirmar', style: TextStyle(color: Colors.blue)),
        cancel: Text('Cancelar', style: TextStyle(color: Colors.grey)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => _mostrarSeletorData(context, true),
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dataInicio != null
                          ? _formatadorData.format(dataInicio!)
                          : 'Data inicial',
                      style: TextStyle(
                        color: dataInicio != null ? Colors.black : Colors.grey,
                      ),
                    ),
                    Icon(Icons.calendar_today, size: 20),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: InkWell(
              onTap: () => _mostrarSeletorData(context, false),
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dataFim != null
                          ? _formatadorData.format(dataFim!)
                          : 'Data final',
                      style: TextStyle(
                        color: dataFim != null ? Colors.black : Colors.grey,
                      ),
                    ),
                    Icon(Icons.calendar_today, size: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
