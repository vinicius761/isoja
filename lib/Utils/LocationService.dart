import 'package:geolocator/geolocator.dart';

class LocationService {
  /// Obtém a posição atual do dispositivo.
  /// Retorna uma [Position] ou lança um erro com a mensagem explicativa.
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 1. Verifica se os serviços de localização estão habilitados.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Os serviços de localização estão desativados.');
    }

    // 2. Verifica o status da permissão.
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('As permissões de localização foram negadas.');
      }
    }

    // 3. Verifica se as permissões foram negadas permanentemente.
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'As permissões de localização estão permanentemente negadas. '
        'Não podemos solicitar permissões.',
      );
    }

    // 4. Se tudo estiver ok, retorna a posição atual.
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
