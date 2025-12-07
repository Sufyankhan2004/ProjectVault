// ==================== lib/models/resource_model.dart ====================
class ResourceModel {
  final String id;
  final String title;
  final String description;
  final String sectionId;
  final String sectionName;
  final String category;
  final String uploaderId;
  final String uploaderName;
  final List<String> fileUrls;
  final List<String> fileNames;
  final List<int> fileSizes;
  final int semester;
  final List<String> tags;
  final DateTime uploadedAt;
  final int downloads;
  final int views;
  final double rating;
  final int ratingCount;
  final bool isApproved;
  final String? thumbnail;
  final DateTime? approvedAt;
  final String? approvedBy;
  
  ResourceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.sectionId,
    required this.sectionName,
    required this.category,
    required this.uploaderId,
    required this.uploaderName,
    required this.fileUrls,
    required this.fileNames,
    required this.fileSizes,
    required this.semester,
    this.tags = const [],
    required this.uploadedAt,
    this.downloads = 0,
    this.views = 0,
    this.rating = 0.0,
    this.ratingCount = 0,
    this.isApproved = false,
    this.thumbnail,
    this.approvedAt,
    this.approvedBy,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'sectionId': sectionId,
      'sectionName': sectionName,
      'category': category,
      'uploaderId': uploaderId,
      'uploaderName': uploaderName,
      'fileUrls': fileUrls,
      'fileNames': fileNames,
      'fileSizes': fileSizes,
      'semester': semester,
      'tags': tags,
      'uploadedAt': uploadedAt.toIso8601String(),
      'downloads': downloads,
      'views': views,
      'rating': rating,
      'ratingCount': ratingCount,
      'isApproved': isApproved,
      'thumbnail': thumbnail,
      'approvedAt': approvedAt?.toIso8601String(),
      'approvedBy': approvedBy,
    };
  }
  
  factory ResourceModel.fromMap(Map<String, dynamic> map, String id) {
    return ResourceModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      sectionId: map['sectionId'] ?? '',
      sectionName: map['sectionName'] ?? '',
      category: map['category'] ?? '',
      uploaderId: map['uploaderId'] ?? '',
      uploaderName: map['uploaderName'] ?? '',
      fileUrls: List<String>.from(map['fileUrls'] ?? []),
      fileNames: List<String>.from(map['fileNames'] ?? []),
      fileSizes: List<int>.from(map['fileSizes'] ?? []),
      semester: map['semester'] ?? 1,
      tags: List<String>.from(map['tags'] ?? []),
      uploadedAt: map['uploadedAt'] != null 
          ? DateTime.parse(map['uploadedAt']) 
          : DateTime.now(),
      downloads: map['downloads'] ?? 0,
      views: map['views'] ?? 0,
      rating: (map['rating'] ?? 0).toDouble(),
      ratingCount: map['ratingCount'] ?? 0,
      isApproved: map['isApproved'] ?? false,
      thumbnail: map['thumbnail'],
      approvedAt: map['approvedAt'] != null 
          ? DateTime.parse(map['approvedAt']) 
          : null,
      approvedBy: map['approvedBy'],
    );
  }
  
  ResourceModel copyWith({
    String? title,
    String? description,
    int? downloads,
    int? views,
    double? rating,
    int? ratingCount,
    bool? isApproved,
    DateTime? approvedAt,
    String? approvedBy,
  }) {
    return ResourceModel(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      sectionId: sectionId,
      sectionName: sectionName,
      category: category,
      uploaderId: uploaderId,
      uploaderName: uploaderName,
      fileUrls: fileUrls,
      fileNames: fileNames,
      fileSizes: fileSizes,
      semester: semester,
      tags: tags,
      uploadedAt: uploadedAt,
      downloads: downloads ?? this.downloads,
      views: views ?? this.views,
      rating: rating ?? this.rating,
      ratingCount: ratingCount ?? this.ratingCount,
      isApproved: isApproved ?? this.isApproved,
      thumbnail: thumbnail,
      approvedAt: approvedAt ?? this.approvedAt,
      approvedBy: approvedBy ?? this.approvedBy,
    );
  }
}
