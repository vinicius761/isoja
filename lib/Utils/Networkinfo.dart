import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  static final Connectivity _connectivity = Connectivity();

  static Future<bool> isConnected() async {
    final List<ConnectivityResult> connectivityResults =
        await _connectivity.checkConnectivity();

    if (connectivityResults.contains(ConnectivityResult.none)) {
      return false;
    }

    return await _hasInternetAccess();
  }

  static Future<bool> _hasInternetAccess() async {
    try {
      final result = await InternetAddress.lookup(
        'google.com',
      ).timeout(const Duration(seconds: 3));

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  static Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged;
}
