// ==================== lib/models/notification_model.dart ====================
class NotificationModel {
  final String id;
  final String userId;
  final String title;
  final String body;
  final String type; // 'approval', 'download', 'comment', 'achievement'
  final String? resourceId;
  final DateTime createdAt;
  final bool isRead;
  
  NotificationModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.type,
    this.resourceId,
    required this.createdAt,
    this.isRead = false,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
      'type': type,
      'resourceId': resourceId,
      'createdAt': createdAt.toIso8601String(),
      'isRead': isRead,
    };
  }
  
  factory NotificationModel.fromMap(Map<String, dynamic> map, String id) {
    return NotificationModel(
      id: id,
      userId: map['userId'] ?? '',
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      type: map['type'] ?? 'info',
      resourceId: map['resourceId'],
      createdAt: map['createdAt'] != null 
          ? DateTime.parse(map['createdAt']) 
          : DateTime.now(),
      isRead: map['isRead'] ?? false,
    );
  }
  
  NotificationModel copyWith({
    bool? isRead,
  }) {
    return NotificationModel(
      id: id,
      userId: userId,
      title: title,
      body: body,
      type: type,
      resourceId: resourceId,
      createdAt: createdAt,
      isRead: isRead ?? this.isRead,
    );
  }
}