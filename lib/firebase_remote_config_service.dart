import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_remote_enverioments_firebase/Firebase_remote_config_keys.dart';

/// Responsavel por fornecer acesso aos serviços do Remote Conf
class FirebaseRemoteConfigServe {
  FirebaseRemoteConfigServe._() : _remoteConfig = FirebaseRemoteConfig.instance;

  /// Padrão de design Singleton para garantir que exista apenas uma instância da classe FirebaseRemoteConfigServe durante a execução do aplicativo.
  /// O método factory é usado para criar a instância da classe e retorna a instância existente se já tiver sido criada anteriormente.
  static FirebaseRemoteConfigServe? _instance;
  factory FirebaseRemoteConfigServe() =>
      _instance ??= FirebaseRemoteConfigServe._();

  final FirebaseRemoteConfig _remoteConfig;

  ///Obter um valor de configuração remota do Firebase com base em uma chave fornecida.
  ///Ele recebe uma string key como argumento e chama o método getString da instância _remoteConfig para obter o valor correspondente.
  ///Em seguida, retorna esse valor como uma string.
  String getString(String key) => _remoteConfig.getString(key);
}
