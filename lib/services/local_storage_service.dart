// ==================== lib/services/local_storage_service.dart ====================
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorageService {
  static SharedPreferences? _prefs;
  
  // Initialize
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  
  // ========== USER PREFERENCES ==========
  
  // Save user data
  static Future<bool> saveUserData(Map<String, dynamic> userData) async {
    try {
      final jsonString = jsonEncode(userData);
      return await _prefs!.setString('user_data', jsonString);
    } catch (e) {
      print('Save user data error: $e');
      return false;
    }
  }
  
  // Get user data
  static Map<String, dynamic>? getUserData() {
    try {
      final jsonString = _prefs!.getString('user_data');
      if (jsonString != null) {
        return jsonDecode(jsonString);
      }
      return null;
    } catch (e) {
      print('Get user data error: $e');
      return null;
    }
  }
  
  // Clear user data
  static Future<bool> clearUserData() async {
    return await _prefs!.remove('user_data');
  }
  
  // ========== APP SETTINGS ==========
  
  // Save theme mode
  static Future<bool> saveThemeMode(bool isDarkMode) async {
    return await _prefs!.setBool('is_dark_mode', isDarkMode);
  }
  
  // Get theme mode
  static bool getThemeMode() {
    return _prefs!.getBool('is_dark_mode') ?? false;
  }
  
  // Save language
  static Future<bool> saveLanguage(String languageCode) async {
    return await _prefs!.setString('language', languageCode);
  }
  
  // Get language
  static String getLanguage() {
    return _prefs!.getString('language') ?? 'en';
  }
  
  // ========== OFFLINE DATA ==========
  
  // Save bookmarks
  static Future<bool> saveBookmarks(List<String> bookmarks) async {
    return await _prefs!.setStringList('bookmarks', bookmarks);
  }
  
  // Get bookmarks
  static List<String> getBookmarks() {
    return _prefs!.getStringList('bookmarks') ?? [];
  }
  
  // Add bookmark
  static Future<bool> addBookmark(String resourceId) async {
    final bookmarks = getBookmarks();
    if (!bookmarks.contains(resourceId)) {
      bookmarks.add(resourceId);
      return await saveBookmarks(bookmarks);
    }
    return false;
  }
  
  // Remove bookmark
  static Future<bool> removeBookmark(String resourceId) async {
    final bookmarks = getBookmarks();
    if (bookmarks.contains(resourceId)) {
      bookmarks.remove(resourceId);
      return await saveBookmarks(bookmarks);
    }
    return false;
  }
  
  // Save downloads
  static Future<bool> saveDownloads(List<String> downloads) async {
    return await _prefs!.setStringList('downloads', downloads);
  }
  
  // Get downloads
  static List<String> getDownloads() {
    return _prefs!.getStringList('downloads') ?? [];
  }
  
  // Add download
  static Future<bool> addDownload(String resourceId) async {
    final downloads = getDownloads();
    if (!downloads.contains(resourceId)) {
      downloads.add(resourceId);
      return await saveDownloads(downloads);
    }
    return false;
  }
  
  // ========== SEARCH HISTORY ==========
  
  // Save search history
  static Future<bool> saveSearchHistory(List<String> searches) async {
    return await _prefs!.setStringList('search_history', searches);
  }
  
  // Get search history
  static List<String> getSearchHistory() {
    return _prefs!.getStringList('search_history') ?? [];
  }
  
  // Add search query
  static Future<bool> addSearchQuery(String query) async {
    final history = getSearchHistory();
    
    // Remove if exists (to add at beginning)
    history.remove(query);
    
    // Add at beginning
    history.insert(0, query);
    
    // Keep only last 20 searches
    if (history.length > 20) {
      history.removeRange(20, history.length);
    }
    
    return await saveSearchHistory(history);
  }
  
  // Clear search history
  static Future<bool> clearSearchHistory() async {
    return await _prefs!.remove('search_history');
  }
  
  // ========== CACHE ==========
  
  // Save cached data
  static Future<bool> saveCachedData(String key, Map<String, dynamic> data) async {
    try {
      final jsonString = jsonEncode(data);
      return await _prefs!.setString('cache_$key', jsonString);
    } catch (e) {
      print('Save cache error: $e');
      return false;
    }
  }
  
  // Get cached data
  static Map<String, dynamic>? getCachedData(String key) {
    try {
      final jsonString = _prefs!.getString('cache_$key');
      if (jsonString != null) {
        return jsonDecode(jsonString);
      }
      return null;
    } catch (e) {
      print('Get cache error: $e');
      return null;
    }
  }
  
  // Clear cache
  static Future<bool> clearCache(String key) async {
    return await _prefs!.remove('cache_$key');
  }
  
  // Clear all cache
  static Future<void> clearAllCache() async {
    final keys = _prefs!.getKeys();
    for (var key in keys) {
      if (key.startsWith('cache_')) {
        await _prefs!.remove(key);
      }
    }
  }
  
  // ========== FILE DOWNLOADS ==========
  
  // Get downloads directory
  static Future<Directory> getDownloadsDirectory() async {
    if (Platform.isAndroid) {
      return Directory('/storage/emulated/0/Download/ProjectVault');
    } else {
      final appDir = await getApplicationDocumentsDirectory();
      return Directory('${appDir.path}/Downloads');
    }
  }
  
  // Save downloaded file info
  static Future<bool> saveDownloadedFileInfo({
    required String resourceId,
    required String resourceName,
    required List<String> filePaths,
  }) async {
    try {
      final downloads = getCachedData('downloaded_files') ?? {};
      downloads[resourceId] = {
        'resourceName': resourceName,
        'filePaths': filePaths,
        'downloadedAt': DateTime.now().toIso8601String(),
      };
      return await saveCachedData('downloaded_files', downloads);
    } catch (e) {
      print('Save download info error: $e');
      return false;
    }
  }
  
  // Get downloaded file info
  static Map<String, dynamic>? getDownloadedFileInfo(String resourceId) {
    final downloads = getCachedData('downloaded_files');
    if (downloads != null && downloads.containsKey(resourceId)) {
      return downloads[resourceId];
    }
    return null;
  }
  
  // Check if resource is downloaded
  static bool isResourceDownloaded(String resourceId) {
    return getDownloadedFileInfo(resourceId) != null;
  }
  
  // Delete downloaded files
  static Future<bool> deleteDownloadedFiles(String resourceId) async {
    try {
      final info = getDownloadedFileInfo(resourceId);
      if (info != null) {
        final filePaths = List<String>.from(info['filePaths'] ?? []);
        
        // Delete physical files
        for (var filePath in filePaths) {
          final file = File(filePath);
          if (await file.exists()) {
            await file.delete();
          }
        }
        
        // Remove from cache
        final downloads = getCachedData('downloaded_files') ?? {};
        downloads.remove(resourceId);
        await saveCachedData('downloaded_files', downloads);
      }
      
      return true;
    } catch (e) {
      print('Delete downloaded files error: $e');
      return false;
    }
  }
  
  // Get total downloaded size
  static Future<int> getTotalDownloadedSize() async {
    try {
      final downloads = getCachedData('downloaded_files') ?? {};
      int totalSize = 0;
      
      for (var entry in downloads.values) {
        final filePaths = List<String>.from(entry['filePaths'] ?? []);
        for (var filePath in filePaths) {
          final file = File(filePath);
          if (await file.exists()) {
            totalSize += await file.length();
          }
        }
      }
      
      return totalSize;
    } catch (e) {
      print('Get total size error: $e');
      return 0;
    }
  }
  
  // ========== ONBOARDING ==========
  
  // Mark onboarding as completed
  static Future<bool> setOnboardingCompleted() async {
    return await _prefs!.setBool('onboarding_completed', true);
  }
  
  // Check if onboarding is completed
  static bool isOnboardingCompleted() {
    return _prefs!.getBool('onboarding_completed') ?? false;
  }
  
  // ========== CLEAR ALL ==========
  
  // Clear all local data
  static Future<void> clearAll() async {
    await _prefs!.clear();
  }
}