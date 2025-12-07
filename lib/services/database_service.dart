// ==================== lib/services/database_service.dart ====================
import 'package:cloud_firestore/cloud_firestore.dart';
// import '../models/user_model.dart';
// import '../models/section_model.dart';
// import '../models/resource_model.dart';
// import '../models/comment_model.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // ========== USERS ==========
  
  // Get user by ID
  Future<DocumentSnapshot> getUser(String userId) async {
    return await _firestore.collection('users').doc(userId).get();
  }
  
  // Get all users (Admin only)
  Future<QuerySnapshot> getAllUsers() async {
    return await _firestore.collection('users').get();
  }
  
  // Update user
  Future<void> updateUser(String userId, Map<String, dynamic> data) async {
    await _firestore.collection('users').doc(userId).update(data);
  }
  
  // Add points to user
  Future<void> addPoints(String userId, int points) async {
    await _firestore.collection('users').doc(userId).update({
      'points': FieldValue.increment(points),
    });
  }
  
  // Get leaderboard
  Future<QuerySnapshot> getLeaderboard({int limit = 20}) async {
    return await _firestore
        .collection('users')
        .orderBy('points', descending: true)
        .limit(limit)
        .get();
  }
  
  // ========== SECTIONS ==========
  
  // Get all sections
  Future<QuerySnapshot> getSections() async {
    return await _firestore
        .collection('sections')
        .orderBy('order')
        .get();
  }
  
  // Get section by ID
  Future<DocumentSnapshot> getSection(String sectionId) async {
    return await _firestore.collection('sections').doc(sectionId).get();
  }
  
  // Create section
  Future<String> createSection(Map<String, dynamic> data) async {
    final docRef = await _firestore.collection('sections').add(data);
    return docRef.id;
  }
  
  // Update section
  Future<void> updateSection(String sectionId, Map<String, dynamic> data) async {
    await _firestore.collection('sections').doc(sectionId).update(data);
  }
  
  // Delete section
  Future<void> deleteSection(String sectionId) async {
    await _firestore.collection('sections').doc(sectionId).delete();
  }
  
  // Add category to section
  Future<void> addCategory(String sectionId, String category) async {
    await _firestore.collection('sections').doc(sectionId).update({
      'categories': FieldValue.arrayUnion([category]),
    });
  }
  
  // Remove category from section
  Future<void> removeCategory(String sectionId, String category) async {
    await _firestore.collection('sections').doc(sectionId).update({
      'categories': FieldValue.arrayRemove([category]),
    });
  }
  
  // ========== RESOURCES ==========
  
  // Get all approved resources
  Future<QuerySnapshot> getApprovedResources() async {
    return await _firestore
        .collection('resources')
        .where('isApproved', isEqualTo: true)
        .orderBy('uploadedAt', descending: true)
        .get();
  }
  
  // Get pending resources (Admin only)
  Future<QuerySnapshot> getPendingResources() async {
    return await _firestore
        .collection('resources')
        .where('isApproved', isEqualTo: false)
        .orderBy('uploadedAt', descending: true)
        .get();
  }
  
  // Get resources by section
  Future<QuerySnapshot> getResourcesBySection(String sectionId) async {
    return await _firestore
        .collection('resources')
        .where('sectionId', isEqualTo: sectionId)
        .where('isApproved', isEqualTo: true)
        .orderBy('uploadedAt', descending: true)
        .get();
  }
  
  // Get resources by category
  Future<QuerySnapshot> getResourcesByCategory(String category) async {
    return await _firestore
        .collection('resources')
        .where('category', isEqualTo: category)
        .where('isApproved', isEqualTo: true)
        .orderBy('uploadedAt', descending: true)
        .get();
  }
  
  // Get trending resources
  Future<QuerySnapshot> getTrendingResources({int limit = 10}) async {
    return await _firestore
        .collection('resources')
        .where('isApproved', isEqualTo: true)
        .orderBy('downloads', descending: true)
        .limit(limit)
        .get();
  }
  
  // Search resources
  Future<QuerySnapshot> searchResources(String query) async {
    // Note: Firestore doesn't support full-text search
    // You might want to use Algolia or implement your own search
    return await _firestore
        .collection('resources')
        .where('isApproved', isEqualTo: true)
        .get();
  }
  
  // Get resource by ID
  Future<DocumentSnapshot> getResource(String resourceId) async {
    return await _firestore.collection('resources').doc(resourceId).get();
  }
  
  // Upload resource
  Future<String> uploadResource(Map<String, dynamic> data) async {
    final docRef = await _firestore.collection('resources').add(data);
    
    // Increment user uploads
    await _firestore.collection('users').doc(data['uploaderId']).update({
      'uploads': FieldValue.arrayUnion([docRef.id]),
    });
    
    return docRef.id;
  }
  
  // Update resource
  Future<void> updateResource(String resourceId, Map<String, dynamic> data) async {
    await _firestore.collection('resources').doc(resourceId).update(data);
  }
  
  // Delete resource
  Future<void> deleteResource(String resourceId) async {
    await _firestore.collection('resources').doc(resourceId).delete();
  }
  
  // Approve resource
  Future<void> approveResource(String resourceId, String adminId) async {
    await _firestore.collection('resources').doc(resourceId).update({
      'isApproved': true,
      'approvedAt': DateTime.now().toIso8601String(),
      'approvedBy': adminId,
    });
    
    // Get resource data to award points to uploader
    final resource = await getResource(resourceId);
    final uploaderId = resource.get('uploaderId');
    
    // Award 50 points
    await addPoints(uploaderId, 50);
  }
  
  // Increment download count
  Future<void> incrementDownload(String resourceId) async {
    await _firestore.collection('resources').doc(resourceId).update({
      'downloads': FieldValue.increment(1),
    });
  }
  
  // Increment view count
  Future<void> incrementView(String resourceId) async {
    await _firestore.collection('resources').doc(resourceId).update({
      'views': FieldValue.increment(1),
    });
  }
  
  // ========== BOOKMARKS ==========
  
  // Add bookmark
  Future<void> addBookmark(String userId, String resourceId) async {
    await _firestore.collection('users').doc(userId).update({
      'bookmarks': FieldValue.arrayUnion([resourceId]),
    });
  }
  
  // Remove bookmark
  Future<void> removeBookmark(String userId, String resourceId) async {
    await _firestore.collection('users').doc(userId).update({
      'bookmarks': FieldValue.arrayRemove([resourceId]),
    });
  }
  
  // Get user bookmarks
  Future<List<DocumentSnapshot>> getUserBookmarks(String userId) async {
    final userDoc = await getUser(userId);
    final bookmarks = List<String>.from(userDoc.get('bookmarks') ?? []);
    
    if (bookmarks.isEmpty) return [];
    
    final resources = await Future.wait(
      bookmarks.map((id) => getResource(id)),
    );
    
    return resources;
  }
  
  // ========== DOWNLOADS ==========
  
  // Add to user downloads
  Future<void> addToUserDownloads(String userId, String resourceId) async {
    await _firestore.collection('users').doc(userId).update({
      'downloads': FieldValue.arrayUnion([resourceId]),
    });
  }
  
  // Get user downloads
  Future<List<DocumentSnapshot>> getUserDownloads(String userId) async {
    final userDoc = await getUser(userId);
    final downloads = List<String>.from(userDoc.get('downloads') ?? []);
    
    if (downloads.isEmpty) return [];
    
    final resources = await Future.wait(
      downloads.map((id) => getResource(id)),
    );
    
    return resources;
  }
  
  // ========== COMMENTS & RATINGS ==========
  
  // Add comment/rating
  Future<String> addComment(Map<String, dynamic> data) async {
    final docRef = await _firestore.collection('comments').add(data);
    
    // Update resource rating
    if (data['rating'] != null) {
      await _updateResourceRating(data['resourceId']);
    }
    
    return docRef.id;
  }
  
  // Get comments for resource
  Future<QuerySnapshot> getComments(String resourceId) async {
    return await _firestore
        .collection('comments')
        .where('resourceId', isEqualTo: resourceId)
        .orderBy('createdAt', descending: true)
        .get();
  }
  
  // Update resource rating
  Future<void> _updateResourceRating(String resourceId) async {
    final comments = await getComments(resourceId);
    
    double totalRating = 0;
    int count = 0;
    
    for (var doc in comments.docs) {
      final rating = doc.get('rating');
      if (rating != null) {
        totalRating += rating;
        count++;
      }
    }
    
    final avgRating = count > 0 ? totalRating / count : 0.0;
    
    await _firestore.collection('resources').doc(resourceId).update({
      'rating': avgRating,
      'ratingCount': count,
    });
  }
  
  // ========== NOTIFICATIONS ==========
  
  // Create notification
  Future<String> createNotification(Map<String, dynamic> data) async {
    final docRef = await _firestore.collection('notifications').add(data);
    return docRef.id;
  }
  
  // Get user notifications
  Future<QuerySnapshot> getUserNotifications(String userId) async {
    return await _firestore
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .limit(50)
        .get();
  }
  
  // Mark notification as read
  Future<void> markNotificationAsRead(String notificationId) async {
    await _firestore.collection('notifications').doc(notificationId).update({
      'isRead': true,
    });
  }
  
  // Delete notification
  Future<void> deleteNotification(String notificationId) async {
    await _firestore.collection('notifications').doc(notificationId).delete();
  }
  
  // ========== ANALYTICS ==========
  
  // Get analytics data
  Future<Map<String, dynamic>> getAnalytics() async {
    final users = await _firestore.collection('users').get();
    final resources = await _firestore.collection('resources').get();
    final pending = await _firestore
        .collection('resources')
        .where('isApproved', isEqualTo: false)
        .get();
    
    int totalDownloads = 0;
    for (var doc in resources.docs) {
      totalDownloads += (doc.get('downloads') ?? 0) as int;
    }
    
    return {
      'totalUsers': users.size,
      'totalResources': resources.size,
      'pendingApprovals': pending.size,
      'totalDownloads': totalDownloads,
      'approvedResources': resources.size - pending.size,
    };
  }
}