class Category {
  final String? id;
  final String name;
  final DateTime? createdAt;

  Category({
    this.id,
    required this.name,
    this.createdAt,
  });

  // Convert Category object to a Map for Supabase
  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  // Create Category object from Supabase JSON data
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id']?.toString(),
      name: json['name'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }
}
