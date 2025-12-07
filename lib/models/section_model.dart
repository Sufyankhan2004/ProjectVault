// ==================== lib/models/section_model.dart ====================
class SectionModel {
  final String id;
  final String name;
  final String icon;
  final List<String> categories;
  final int order;
  final bool isActive;
  final DateTime createdAt;
  final int resourceCount;
  
  SectionModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.categories,
    required this.order,
    this.isActive = true,
    required this.createdAt,
    this.resourceCount = 0,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'categories': categories,
      'order': order,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'resourceCount': resourceCount,
    };
  }
  
  factory SectionModel.fromMap(Map<String, dynamic> map, String id) {
    return SectionModel(
      id: id,
      name: map['name'] ?? '',
      icon: map['icon'] ?? '📁',
      categories: List<String>.from(map['categories'] ?? []),
      order: map['order'] ?? 0,
      isActive: map['isActive'] ?? true,
      createdAt: map['createdAt'] != null 
          ? DateTime.parse(map['createdAt']) 
          : DateTime.now(),
      resourceCount: map['resourceCount'] ?? 0,
    );
  }
  
  SectionModel copyWith({
    String? name,
    String? icon,
    List<String>? categories,
    int? order,
    bool? isActive,
    int? resourceCount,
  }) {
    return SectionModel(
      id: id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      categories: categories ?? this.categories,
      order: order ?? this.order,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt,
      resourceCount: resourceCount ?? this.resourceCount,
    );
  }
}