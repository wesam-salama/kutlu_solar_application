import 'product_related_models.dart';

class Product {
  final String? id;
  final String name;
  final String description;
  final double price;
  final String categoryId;
  final DateTime? createdAt;
  final List<String> imageUrls;
  final String headerSection;
  final String productionLineSection;
  final String featuresSection;
  final bool hasTechnicalResources;
  final bool hasVideos;
  
  // Related data
  final List<ProductPhoto>? photos;
  final List<ProductionLinePhoto>? productionLinePhotos;
  final List<ProductFeature>? features;
  final List<TechnicalResource>? technicalResources;
  final ProductSpecification? specifications;
  final ProductPackaging? packaging;
  final ProductVideos? videos;
  final List<GalleryPhoto>? galleryPhotos;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.imageUrls,
    required this.headerSection,
    required this.productionLineSection,
    required this.featuresSection,
    required this.hasTechnicalResources,
    required this.hasVideos,
    this.createdAt,
    this.photos,
    this.productionLinePhotos,
    this.features,
    this.technicalResources,
    this.specifications,
    this.packaging,
    this.videos,
    this.galleryPhotos,
  });

  // Convert Product object to a Map for Supabase
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'category_id': categoryId,
      'imageUrls': imageUrls,
      'headerSection': headerSection,
      'productionLineSection': productionLineSection,
      'featuresSection': featuresSection,
      'hasTechnicalResources': hasTechnicalResources,
      'hasVideos': hasVideos,
    };
  }

  // Create Product object from Supabase JSON data
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']?.toString(),
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: json['price']?.toDouble() ?? 0.0,
      categoryId: json['category_id'] ?? '',
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
      headerSection: json['headerSection'] ?? '',
      productionLineSection: json['productionLineSection'] ?? '',
      featuresSection: json['featuresSection'] ?? '',
      hasTechnicalResources: json['hasTechnicalResources'] ?? false,
      hasVideos: json['hasVideos'] ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }
  }

