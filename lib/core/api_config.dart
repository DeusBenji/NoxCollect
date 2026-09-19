import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class ApiConfig {
  static String? _cachedBaseUrl;

  /// Returns the appropriate backend URL based on the environment.
  /// Uses dart-define NOX_BACKEND_URL if provided.
  /// Otherwise, dynamically determines if running on a physical Android device
  /// or an emulator to route localhost properly.
  static Future<String> getBaseUrl() async {
    if (_cachedBaseUrl != null) return _cachedBaseUrl!;

    const String envUrl = String.fromEnvironment('NOX_BACKEND_URL');
    if (envUrl.isNotEmpty) {
      _cachedBaseUrl = envUrl;
      return _cachedBaseUrl!;
    }

    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      
      // If it's a physical device, use 127.0.0.1 (assumes adb reverse is active)
      // If it's an emulator, use 10.0.2.2
      if (androidInfo.isPhysicalDevice) {
        _cachedBaseUrl = 'http://127.0.0.1:8000';
      } else {
        _cachedBaseUrl = 'http://10.0.2.2:8000';
      }
    } else {
      // Fallback for iOS simulator or other platforms
      _cachedBaseUrl = 'http://127.0.0.1:8000';
    }

    return _cachedBaseUrl!;
  }
}
