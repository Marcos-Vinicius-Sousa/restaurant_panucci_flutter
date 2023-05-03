import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/services.dart';

class CustomRemoteConfig {
  late FirebaseRemoteConfig firebaseRemoteConfig;

  CustomRemoteConfig._internal();
  static final CustomRemoteConfig _singleton = CustomRemoteConfig._internal();
  factory CustomRemoteConfig() => _singleton;

  Future<void> initialize() async {
    firebaseRemoteConfig = FirebaseRemoteConfig.instance;
    await firebaseRemoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: Duration.zero));
  }

  Future<void> forceFetch() async {
    try {
      await firebaseRemoteConfig.setConfigSettings(RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: Duration.zero));
      await firebaseRemoteConfig.fetchAndActivate();
    } on PlatformException catch (exception) {
      throw (exception.toString());
    } catch (exception) {
      throw ('Erro ao buscar os dados remotamente');
    }
  }

  getValueOrDefault({required String key, required dynamic defaultValue}) {
    switch (defaultValue.runtimeType) {
      case String:
        var _value = firebaseRemoteConfig.getString(key);
        return _value != '' ? _value : defaultValue;
      case int:
        var _value = firebaseRemoteConfig.getInt(key);
        return _value != 0 ? _value : defaultValue;
      case bool:
        var _value = firebaseRemoteConfig.getBool(key);
        return _value != false ? _value : defaultValue;
      case double:
        var _value = firebaseRemoteConfig.getDouble(key);
        return _value != 0.0 ? _value : defaultValue;
      default:
        return Exception('Implementation not found');
    }
  }
}
