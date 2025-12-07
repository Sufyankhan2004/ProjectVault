// ==================== lib/providers/resource_provider.dart ====================
import 'package:flutter/material.dart';
// Import your models and services
// import '../models/resource_model.dart';
// import '../models/section_model.dart';
// import '../services/database_service.dart';

class ResourceProvider extends ChangeNotifier {
  List<dynamic> _sections = []; // List<SectionModel>
  List<dynamic> _resources = []; // List<ResourceModel>
  List<dynamic> _bookmarks = [];
  List<dynamic> _downloads = [];
  List<dynamic> _userUploads = [];
  bool _isLoading = false;
  String? _errorMessage;
  
  List<dynamic> get sections => _sections;
  List<dynamic> get resources => _resources;
  List<dynamic> get approvedResources => 
      _resources.where((r) => r.isApproved == true).toList();
  List<dynamic> get pendingResources => 
      _resources.where((r) => r.isApproved == false).toList();
  List<dynamic> get bookmarks => _bookmarks;
  List<dynamic> get downloads => _downloads;
  List<dynamic> get userUploads => _userUploads;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  
  // Fetch all sections
  Future<void> fetchSections() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      // _sections = await DatabaseService.getSections();
      // Mock data for now
      _sections = [];
    } catch (e) {
      _errorMessage = e.toString();
    }
    
    _isLoading = false;
    notifyListeners();
  }
  
  // Fetch all resources
  Future<void> fetchResources() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      // _resources = await DatabaseService.getResources();
      _resources = [];
    } catch (e) {
      _errorMessage = e.toString();
    }
    
    _isLoading = false;
    notifyListeners();
  }
  
  // Fetch resources by section
  Future<void> fetchResourcesBySection(String sectionId) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      // _resources = await DatabaseService.getResourcesBySection(sectionId);
    } catch (e) {
      _errorMessage = e.toString();
    }
    
    _isLoading = false;
    notifyListeners();
  }
  
  // Search resources
  Future<List<dynamic>> searchResources(String query) async {
    try {
      // return await DatabaseService.searchResources(query);
      return _resources.where((r) {
        return r.title.toLowerCase().contains(query.toLowerCase()) ||
            r.description.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } catch (e) {
      _errorMessage = e.toString();
      return [];
    }
  }
  
  // Upload resource
  Future<bool> uploadResource(Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      // await DatabaseService.uploadResource(data);
      await Future.delayed(Duration(seconds: 2)); // Simulate upload
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  
  // Download resource
  Future<bool> downloadResource(String resourceId, String userId) async {
    try {
      // await DatabaseService.incrementDownload(resourceId);
      // await DatabaseService.addToUserDownloads(userId, resourceId);
      
      if (!_downloads.contains(resourceId)) {
        _downloads.add(resourceId);
        notifyListeners();
      }
      
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }
  
  // Add/Remove bookmark
  Future<bool> toggleBookmark(String resourceId, String userId) async {
    try {
      if (_bookmarks.contains(resourceId)) {
        _bookmarks.remove(resourceId);
        // await DatabaseService.removeBookmark(userId, resourceId);
      } else {
        _bookmarks.add(resourceId);
        // await DatabaseService.addBookmark(userId, resourceId);
      }
      
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }
  
  // Rate resource
  Future<bool> rateResource(String resourceId, double rating, String? comment) async {
    try {
      // await DatabaseService.addRating(resourceId, rating, comment);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }
  
  // Fetch user uploads
  Future<void> fetchUserUploads(String userId) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      // _userUploads = await DatabaseService.getUserUploads(userId);
    } catch (e) {
      _errorMessage = e.toString();
    }
    
    _isLoading = false;
    notifyListeners();
  }
  
  bool isBookmarked(String resourceId) => _bookmarks.contains(resourceId);
  bool isDownloaded(String resourceId) => _downloads.contains(resourceId);
  
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}