// lib/config.dart
class Config {
  // static const String _devBaseUrl = 'https://api-arutmin.up.railway.app';
  // static const String _prodBaseUrl = 'https://arutmin-api.up.railway.app';
  static const String _devBaseUrl = 'https://api-arutmin-prod.up.railway.app'; // url sama
  static const String _prodBaseUrl = 'https://api-arutmin-prod.up.railway.app'; // url sama

  static String get baseUrl {
    // Ubah ini untuk menentukan apakah Anda sedang dalam mode development atau production
    const bool isProduction = bool.fromEnvironment('dart.vm.product');

    if (isProduction) {
      return _prodBaseUrl;
    } else {
      return _devBaseUrl;
    }
  }
}
