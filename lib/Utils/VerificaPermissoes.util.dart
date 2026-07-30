import 'package:permission_handler/permission_handler.dart';

Future<bool> solicitarPermissoes() async {
  // 1. Dispara a requisição em lote direto na API nativa
  final Map<Permission, PermissionStatus> statuses = await [
    Permission.camera,
    Permission.locationWhenInUse,
    Permission.bluetoothScan,
    Permission.bluetoothConnect,
    Permission.bluetoothAdvertise,
  ].request();

  // 2. Retorna imediatamente se todas foram aceitas ou não
  return statuses[Permission.camera]?.isGranted == true &&
      statuses[Permission.locationWhenInUse]?.isGranted == true &&
      statuses[Permission.bluetoothScan]?.isGranted == true &&
      statuses[Permission.bluetoothConnect]?.isGranted == true;
}
