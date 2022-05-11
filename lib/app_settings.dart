
import 'package:get_storage/get_storage.dart';
import '/constants.dart';
import 'models/UserModel.dart';

class AppSettings {
  static AppSettings _instance = AppSettings._internal();

  readStorage(GetStorage storageName, String key) => storageName.read(key);
  writeStorage (GetStorage storageName, Map<String, dynamic> save) => storageName.write(save.keys.toList()[0], save.values.toList()[0]);

  static get instance {
    // ignore: unnecessary_null_comparison
    if (_instance != null) {
      _instance = AppSettings._internal();
    }
    
    return _instance;
  }
  
  AppSettings._internal();

  initializeSettings() async {
    // app setting storage
    appStorage = GetStorage('Settings');
    final bool settingsInit = await GetStorage.init("Settings");
    //app user storage
    userStorage = GetStorage('User');
    final bool userInit = await GetStorage.init("User");
    
    if(settingsInit){
      if(readStorage(appStorage, "getx_app_settings") == null){
        appSettings = defaultSettings;
        writeStorage(appStorage, {"getx_app_settings": appSettings});
      }
      appSettings = readStorage(appStorage, "getx_app_settings");
    }
    
    if(userInit){
      if(readStorage(userStorage, "getx_user_data") != null){
        userModel = UserModel.fromJson(readStorage(userStorage, "getx_user_data"));
      }
    }

  }

  void updateUser({required Map<String, dynamic> user}) {
    writeStorage(userStorage, {"getx_user_data": user});
  }

  void updateSettings({required Map<String, dynamic> setting}){
    appSettings.addAll(setting);
    writeStorage(appStorage, {"getx_app_settings": appSettings});
  }
  
}