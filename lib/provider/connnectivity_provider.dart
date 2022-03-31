import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class ConnectivityProvider with ChangeNotifier {
  Connectivity _connectivity = new Connectivity();

  bool _isOnline = false;

  startMonitoring() async {
    await iniConnectivity();
    _connectivity.onConnectivityChanged.listen((result) async {
      if (result == ConnectivityResult.none) {
        print('TAHAP 1 MANTAP');
        _isOnline = false;

        notifyListeners();
      } else {
        await _updateConnectionStatus().then((bool isConnected) {
          print('TAHAP 2 MANTAP');
          _isOnline = isConnected;

          notifyListeners();
        });
      }
    });
  }

  bool get isOnline => _isOnline;

  Future<void> iniConnectivity() async {
    try {
      var status = await _connectivity.checkConnectivity();

      if (status == ConnectivityResult.none) {
        print('TAHAP 3 MANTAP');
        _isOnline = false;

        notifyListeners();
      } else {
        _isOnline = true;
        print('TAHAP 4 MANTAP');
        notifyListeners();
      }
    } on PlatformException catch (e) {
      print('PlatformExpenception: ' + e.toString());
    }
  }

  Future<bool> _updateConnectionStatus() async {
    bool isConnected = true;
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
        print('TAHAP 5 MANTAP');
      }
    } on SocketException catch (_) {
      isConnected = false;
      print('TAHAP 6 MANTAP');
    }
    return isConnected;
  }
}
