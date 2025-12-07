// ==================== lib/providers/admin_provider.dart ====================
import 'package:flutter/material.dart';
// Import your models and services

class AdminProvider extends ChangeNotifier {
  List<dynamic> _pendingApprovals = [];
  List<dynamic> _allUsers = [];
  Map<String, dynamic> _analytics = {};
  bool _isLoading = false;
  String? _errorMessage;
  
  List<dynamic> get pendingApprovals => _pendingApprovals;
  List<dynamic> get allUsers => _allUsers;
  Map<String, dynamic> get analytics => _analytics;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  
  // Fetch pending approvals
  Future<void> fetchPendingApprovals() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      // _pendingApprovals = await DatabaseService.getPendingResources();
    } catch (e) {
      _errorMessage = e.toString();
    }
    
    _isLoading = false;
    notifyListeners();
  }
  
  // Approve resource
  Future<bool> approveResource(String resourceId, String adminId) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      // await DatabaseService.approveResource(resourceId, adminId);
      // Award points to uploader
      // Send notification
      
      _pendingApprovals.removeWhere((r) => r.id == resourceId);
      
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
  
  // Reject resource
  Future<bool> rejectResource(String resourceId, String reason) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      // await DatabaseService.deleteResource(resourceId);
      // Send notification with reason
      
      _pendingApprovals.removeWhere((r) => r.id == resourceId);
      
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
  
  // Create section
  Future<bool> createSection(Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      // await DatabaseService.createSection(data);
      
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
  
  // Update section
  Future<bool> updateSection(String sectionId, Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      // await DatabaseService.updateSection(sectionId, data);
      
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
  
  // Delete section
  Future<bool> deleteSection(String sectionId) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      // await DatabaseService.deleteSection(sectionId);
      
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
  
  // Add category to section
  Future<bool> addCategory(String sectionId, String category) async {
    try {
      // await DatabaseService.addCategory(sectionId, category);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }
  
  // Remove category from section
  Future<bool> removeCategory(String sectionId, String category) async {
    try {
      // await DatabaseService.removeCategory(sectionId, category);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }
  
  // Fetch all users
  Future<void> fetchAllUsers() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      // _allUsers = await DatabaseService.getAllUsers();
    } catch (e) {
      _errorMessage = e.toString();
    }
    
    _isLoading = false;
    notifyListeners();
  }
  
  // Toggle user admin status
  Future<bool> toggleAdminStatus(String userId, bool isAdmin) async {
    try {
      // await DatabaseService.updateUser(userId, {'isAdmin': isAdmin});
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }
  
  // Ban/Unban user
  Future<bool> toggleUserBan(String userId, bool isBanned) async {
    try {
      // await DatabaseService.updateUser(userId, {'isBanned': isBanned});
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }
  
  // Fetch analytics
  Future<void> fetchAnalytics() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      // _analytics = await DatabaseService.getAnalytics();
      _analytics = {
        'totalUsers': 150,
        'totalResources': 450,
        'totalDownloads': 1250,
        'pendingApprovals': 12,
        'activeUsers': 89,
      };
    } catch (e) {
      _errorMessage = e.toString();
    }
    
    _isLoading = false;
    notifyListeners();
  }
  
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}