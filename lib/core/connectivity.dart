import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityInfo {
  final InternetConnectionChecker _checker = InternetConnectionChecker();
  Future<bool> get isConnected async => await _checker.hasConnection;
}

ConnectivityInfo connectivityInfo = ConnectivityInfo();