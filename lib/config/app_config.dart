// ==================== lib/config/app_config.dart ====================
class AppConfig {
  // Environment
  static const bool isProduction = false;
  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;
  
  // Features
  static const bool enableNotifications = true;
  static const bool enableOfflineMode = true;
  static const bool enableDarkMode = true;
  
  // API
  static const String baseUrl = 'https://api.projectvault.com';
  static const Duration timeout = Duration(seconds: 30);
  
  // Cache
  static const bool enableCache = true;
  static const int maxCacheSize = 100 * 1024 * 1024; // 100MB
  
  // Logging
  static const bool enableLogging = !isProduction;
  static const bool enableVerboseLogging = false;
}