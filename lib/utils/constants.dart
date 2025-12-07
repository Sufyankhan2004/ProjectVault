// ==================== lib/utils/constants.dart ====================
import 'package:flutter/material.dart';

class AppConstants {
  // App Info
  static const String appName = 'ProjectVault';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Your Academic Resource Hub';
  
  // Points System
  static const int pointsPerUpload = 50;
  static const int pointsPerDownload = 5;
  static const int pointsPerRating = 2;
  
  // File Limits
  static const int maxFileSize = 50 * 1024 * 1024; // 50MB
  static const int maxFilesPerUpload = 10;
  static const List<String> allowedFileTypes = [
    'pdf',
    'zip',
    'rar',
    'jpg',
    'jpeg',
    'png',
    'doc',
    'docx',
    'ppt',
    'pptx',
  ];
  
  // Colors
  static const Color primaryColor = Color(0xFF6C63FF);
  static const Color secondaryColor = Color(0xFF5A52D5);
  static const Color accentColor = Color(0xFFFF6B9D);
  static const Color successColor = Color(0xFF4CAF50);
  static const Color errorColor = Color(0xFFF44336);
  static const Color warningColor = Color(0xFFFFA751);
  static const Color infoColor = Color(0xFF4FACFE);
  
  // Gradients
  static const List<Color> primaryGradient = [
    Color(0xFF6C63FF),
    Color(0xFF5A52D5),
    Color(0xFF4C42B0),
  ];
  
  static const List<Color> pinkGradient = [
    Color(0xFFFF6B9D),
    Color(0xFFC06C84),
  ];
  
  static const List<Color> blueGradient = [
    Color(0xFF4FACFE),
    Color(0xFF00F2FE),
  ];
  
  static const List<Color> orangeGradient = [
    Color(0xFFFFA751),
    Color(0xFFFFE259),
  ];
  
  // Durations
  static const Duration splashDuration = Duration(seconds: 3);
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration debounceDelay = Duration(milliseconds: 500);
  
  // Pagination
  static const int itemsPerPage = 20;
  
  // Cache
  static const Duration cacheExpiration = Duration(hours: 24);
  
  // Validation
  static const int minPasswordLength = 6;
  static const int maxTitleLength = 100;
  static const int maxDescriptionLength = 500;
  
  // URLs
  static const String supportEmail = 'support@projectvault.com';
  static const String privacyPolicyUrl = 'https://projectvault.com/privacy';
  static const String termsUrl = 'https://projectvault.com/terms';
}
