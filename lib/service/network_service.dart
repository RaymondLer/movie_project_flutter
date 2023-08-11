import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  Future<bool> isConnected() async {
    final result = await Connectivity().checkConnectivity();
    bool isConnected = false;

    switch (result) {
      case ConnectivityResult.wifi:
        isConnected = await _hasConnection();
        return isConnected;
      case ConnectivityResult.mobile:
        isConnected = await _hasConnection();
        return isConnected;
      default:
        return isConnected;
    }
  }

  Future<bool> _hasConnection() async {
    try {
      final result = await InternetAddress.lookup('1.1.1.1');

      if (result.isNotEmpty) {
        log('connected');
        return true;
      }

      return false;
    } on SocketException catch (_) {
      return false;
    }
  }
}
