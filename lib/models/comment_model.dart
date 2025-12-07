// ==================== lib/models/comment_model.dart ====================
class CommentModel {
  final String id;
  final String resourceId;
  final String userId;
  final String userName;
  final String? userPhoto;
  final String comment;
  final double? rating;
  final DateTime createdAt;
  final int likes;
  
  CommentModel({
    required this.id,
    required this.resourceId,
    required this.userId,
    required this.userName,
    this.userPhoto,
    required this.comment,
    this.rating,
    required this.createdAt,
    this.likes = 0,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'resourceId': resourceId,
      'userId': userId,
      'userName': userName,
      'userPhoto': userPhoto,
      'comment': comment,
      'rating': rating,
      'createdAt': createdAt.toIso8601String(),
      'likes': likes,
    };
  }
  
  factory CommentModel.fromMap(Map<String, dynamic> map, String id) {
    return CommentModel(
      id: id,
      resourceId: map['resourceId'] ?? '',
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      userPhoto: map['userPhoto'],
      comment: map['comment'] ?? '',
      rating: map['rating']?.toDouble(),
      createdAt: map['createdAt'] != null 
          ? DateTime.parse(map['createdAt']) 
          : DateTime.now(),
      likes: map['likes'] ?? 0,
    );
  }
}