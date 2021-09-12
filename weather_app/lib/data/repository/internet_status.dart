import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';

class InternetStatus {
  InternetStatus._private();

  static final InternetStatus _connection = InternetStatus._private();

  factory InternetStatus() {
    return _connection;
  }
  //static InternetStatus get connection => _connection;

  bool hasConnection = false;

  StreamController<bool> _connectivityController = StreamController.broadcast();

  final Connectivity _connectivity = Connectivity();

  void init() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkConnection();
    print('omo ${hasConnection}');
  }

  Stream<bool> get connectivityChange => _connectivityController.stream;

  void dispose() {
    _connectivityController.close();
  }

  void _connectionChange(ConnectivityResult result) {
    checkConnection();
  }

  Future<bool> checkConnection() async {
    bool previousConnection = hasConnection;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
        //print('omo ${hasConnection}');
      } else {
        hasConnection = false;
      }
    } on SocketException catch (_) {
      hasConnection = false;
    }

    if (previousConnection != hasConnection) {
      _connectivityController.add(hasConnection);
    }

    print('yo ${hasConnection}');
    return hasConnection;
  }
}
