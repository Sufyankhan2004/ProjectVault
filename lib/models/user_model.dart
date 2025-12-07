// ==================== lib/models/user_model.dart ====================
class UserModel {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final int points;
  final bool isAdmin;
  final DateTime joinedAt;
  final List<String> uploads;
  final List<String> downloads;
  final List<String> bookmarks;
  
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    this.points = 0,
    this.isAdmin = false,
    required this.joinedAt,
    this.uploads = const [],
    this.downloads = const [],
    this.bookmarks = const [],
  });
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'points': points,
      'isAdmin': isAdmin,
      'joinedAt': joinedAt.toIso8601String(),
      'uploads': uploads,
      'downloads': downloads,
      'bookmarks': bookmarks,
    };
  }
  
  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'],
      points: map['points'] ?? 0,
      isAdmin: map['isAdmin'] ?? false,
      joinedAt: map['joinedAt'] != null 
          ? DateTime.parse(map['joinedAt']) 
          : DateTime.now(),
      uploads: List<String>.from(map['uploads'] ?? []),
      downloads: List<String>.from(map['downloads'] ?? []),
      bookmarks: List<String>.from(map['bookmarks'] ?? []),
    );
  }
  
  UserModel copyWith({
    String? name,
    String? email,
    String? photoUrl,
    int? points,
    bool? isAdmin,
    List<String>? uploads,
    List<String>? downloads,
    List<String>? bookmarks,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      points: points ?? this.points,
      isAdmin: isAdmin ?? this.isAdmin,
      joinedAt: joinedAt,
      uploads: uploads ?? this.uploads,
      downloads: downloads ?? this.downloads,
      bookmarks: bookmarks ?? this.bookmarks,
    );
  }
}