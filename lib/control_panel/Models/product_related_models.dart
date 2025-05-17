// Models for product-related tables based on the database schema
import 'package:kutlu_solar_application/control_panel/Models/product_model.dart';

// Class to hold a product with all its related data
class ProductWithRelatedData {
  final Product product;
  final List<ProductPhoto> photos;
  final List<ProductionLinePhoto> productionLinePhotos;
  final List<ProductFeature> features;
  final List<TechnicalResource> technicalResources;
  final ProductSpecification? specification;
  final ProductPackaging? packaging;
  final ProductVideos? videos;
  final List<GalleryPhoto> galleryPhotos;

  ProductWithRelatedData({
    required this.product,
    required this.photos,
    required this.productionLinePhotos,
    required this.features,
    required this.technicalResources,
    this.specification,
    this.packaging,
    this.videos,
    required this.galleryPhotos,
  });
}

// Product Photos model
class ProductPhoto {
  final String? id;
  final String productId;
  final String photoUrl;
  final DateTime? createdAt;

  ProductPhoto({
    this.id,
    required this.productId,
    required this.photoUrl,
    this.createdAt,
  });

  ProductPhoto copyWith({
    String? id,
    String? productId,
    String? photoUrl,
    DateTime? createdAt,
  }) {
    return ProductPhoto(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'photo_url': photoUrl,
    };
  }

  factory ProductPhoto.fromJson(Map<String, dynamic> json) {
    return ProductPhoto(
      id: json['id']?.toString(),
      productId: json['product_id'] ?? '',
      photoUrl: json['photo_url'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }
}

// Production Line Photos model
class ProductionLinePhoto {
  final String? id;
  final String productId;
  final String title;
  final String photoUrl;
  final DateTime? createdAt;

  ProductionLinePhoto({
    this.id,
    required this.productId,
    required this.title,
    required this.photoUrl,
    this.createdAt,
  });

  ProductionLinePhoto copyWith({
    String? id,
    String? productId,
    String? title,
    String? photoUrl,
    DateTime? createdAt,
  }) {
    return ProductionLinePhoto(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      title: title ?? this.title,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'title': title,
      'photo_url': photoUrl,
    };
  }

  factory ProductionLinePhoto.fromJson(Map<String, dynamic> json) {
    return ProductionLinePhoto(
      id: json['id']?.toString(),
      productId: json['product_id'] ?? '',
      title: json['title'] ?? '',
      photoUrl: json['photo_url'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }
}

// Product Features model (rich text + optional photo)
class ProductFeature {
  final String? id;
  final String productId;
  final Map<String, dynamic> content; // Quill Delta JSON
  final String? photoUrl;
  final DateTime? createdAt;

  ProductFeature({
    this.id,
    required this.productId,
    required this.content,
    this.photoUrl,
    this.createdAt,
  });

  ProductFeature copyWith({
    String? id,
    String? productId,
    Map<String, dynamic>? content,
    String? photoUrl,
    DateTime? createdAt,
  }) {
    return ProductFeature(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      content: content ?? this.content,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'content': content,
      'photo_url': photoUrl,
    };
  }

  factory ProductFeature.fromJson(Map<String, dynamic> json) {
    return ProductFeature(
      id: json['id']?.toString(),
      productId: json['product_id'] ?? '',
      content: json['content'] ?? {},
      photoUrl: json['photo_url'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }
}

// Technical Resources model
class TechnicalResource {
  final String? id;
  final String productId;
  final String title;
  final String? description;
  final String fileUrl;
  final bool enabled;
  final DateTime? createdAt;

  TechnicalResource({
    this.id,
    required this.productId,
    required this.title,
    this.description,
    required this.fileUrl,
    this.enabled = true,
    this.createdAt,
  });

  TechnicalResource copyWith({
    String? id,
    String? productId,
    String? title,
    String? description,
    String? fileUrl,
    bool? enabled,
    DateTime? createdAt,
  }) {
    return TechnicalResource(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      title: title ?? this.title,
      description: description ?? this.description,
      fileUrl: fileUrl ?? this.fileUrl,
      enabled: enabled ?? this.enabled,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'title': title,
      'description': description,
      'file_url': fileUrl,
      'enabled': enabled,
    };
  }

  factory TechnicalResource.fromJson(Map<String, dynamic> json) {
    return TechnicalResource(
      id: json['id']?.toString(),
      productId: json['product_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'],
      fileUrl: json['file_url'] ?? '',
      enabled: json['enabled'] ?? true,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }
}

// Product Specifications model
class ProductSpecification {
  final String? id;
  final String productId;
  final Map<String, dynamic> specData; // { columns: [...], rows: [...] }
  final DateTime? createdAt;

  ProductSpecification({
    this.id,
    required this.productId,
    required this.specData,
    this.createdAt,
  });

  ProductSpecification copyWith({
    String? id,
    String? productId,
    Map<String, dynamic>? specData,
    DateTime? createdAt,
  }) {
    return ProductSpecification(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      specData: specData ?? this.specData,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'spec_data': specData,
    };
  }

  factory ProductSpecification.fromJson(Map<String, dynamic> json) {
    return ProductSpecification(
      id: json['id']?.toString(),
      productId: json['product_id'] ?? '',
      specData: json['spec_data'] ?? {},
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }
}

// Product Packaging model
class ProductPackaging {
  final String? id;
  final String productId;
  final Map<String, dynamic> packagingData; // { columns: [...], rows: [...] }
  final DateTime? createdAt;

  ProductPackaging({
    this.id,
    required this.productId,
    required this.packagingData,
    this.createdAt,
  });

  ProductPackaging copyWith({
    String? id,
    String? productId,
    Map<String, dynamic>? packagingData,
    DateTime? createdAt,
  }) {
    return ProductPackaging(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      packagingData: packagingData ?? this.packagingData,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'packaging_data': packagingData,
    };
  }

  factory ProductPackaging.fromJson(Map<String, dynamic> json) {
    return ProductPackaging(
      id: json['id']?.toString(),
      productId: json['product_id'] ?? '',
      packagingData: json['packaging_data'] ?? {},
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }
}

// Product Videos model
class ProductVideos {
  final String? id;
  final String productId;
  final String? sectionTitle;
  final bool enabled;
  final List<VideoLink>? videoLinks;
  final DateTime? createdAt;

  ProductVideos({
    this.id,
    required this.productId,
    this.sectionTitle,
    this.enabled = false,
    this.videoLinks,
    this.createdAt,
  });

  ProductVideos copyWith({
    String? id,
    String? productId,
    String? sectionTitle,
    bool? enabled,
    List<VideoLink>? videoLinks,
    DateTime? createdAt,
  }) {
    return ProductVideos(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      sectionTitle: sectionTitle ?? this.sectionTitle,
      enabled: enabled ?? this.enabled,
      videoLinks: videoLinks ?? this.videoLinks,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'section_title': sectionTitle,
      'enabled': enabled,
    };
  }

  factory ProductVideos.fromJson(Map<String, dynamic> json) {
    return ProductVideos(
      id: json['id']?.toString(),
      productId: json['product_id'] ?? '',
      sectionTitle: json['section_title'],
      enabled: json['enabled'] ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }
}

// Video Links model
class VideoLink {
  final String? id;
  final String videoSectionId;
  final String youtubeUrl;
  final DateTime? createdAt;

  VideoLink({
    this.id,
    required this.videoSectionId,
    required this.youtubeUrl,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'video_section_id': videoSectionId,
      'youtube_url': youtubeUrl,
    };
  }

  factory VideoLink.fromJson(Map<String, dynamic> json) {
    return VideoLink(
      id: json['id']?.toString(),
      videoSectionId: json['video_section_id'] ?? '',
      youtubeUrl: json['youtube_url'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }
}

// Gallery Photos model
class GalleryPhoto {
  final String? id;
  final String productId;
  final String photoUrl;
  final DateTime? createdAt;

  GalleryPhoto({
    this.id,
    required this.productId,
    required this.photoUrl,
    this.createdAt,
  });

  GalleryPhoto copyWith({
    String? id,
    String? productId,
    String? photoUrl,
    DateTime? createdAt,
  }) {
    return GalleryPhoto(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'photo_url': photoUrl,
    };
  }

  factory GalleryPhoto.fromJson(Map<String, dynamic> json) {
    return GalleryPhoto(
      id: json['id']?.toString(),
      productId: json['product_id'] ?? '',
      photoUrl: json['photo_url'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }
}