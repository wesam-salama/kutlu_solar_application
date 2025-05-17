import 'package:kutlu_solar_application/control_panel/Models/product_related_models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:async';

// Service class for handling product photos
class ProductPhotoService {
  final SupabaseClient _supabase = Supabase.instance.client;
  final String _tableName = 'product_photos';

  // Add a new product photo
  Future<String> addProductPhoto(ProductPhoto photo) async {
    final response = await _supabase
        .from(_tableName)
        .insert(photo.toMap())
        .select('id')
        .single();
    
    return response['id'] as String;
  }

  // Get photos for a product
  Future<List<ProductPhoto>> getProductPhotos(String productId) async {
    final response = await _supabase
        .from(_tableName)
        .select()
        .eq('product_id', productId);
    
    return response.map((data) => ProductPhoto.fromJson(data)).toList();
  }

  // Delete a product photo
  Future<void> deleteProductPhoto(String id) async {
    await _supabase
        .from(_tableName)
        .delete()
        .eq('id', id);
  }

  // Update a product photo
  Future<void> updateProductPhoto(ProductPhoto photo) async {
    await _supabase
       .from(_tableName)
       .update(photo.toMap())
       .eq('id', photo.id?? '');
  }
}

// Service class for handling production line photos
class ProductionLinePhotoService {
  final SupabaseClient _supabase = Supabase.instance.client;
  final String _tableName = 'production_line_photos';

  // Add a new production line photo
  Future<String> addProductionLinePhoto(ProductionLinePhoto photo) async {
    final response = await _supabase
        .from(_tableName)
        .insert(photo.toMap())
        .select('id')
        .single();
    
    return response['id'] as String;
  }

  // Get production line photos for a product
  Future<List<ProductionLinePhoto>> getProductionLinePhotos(String productId) async {
    final response = await _supabase
        .from(_tableName)
        .select()
        .eq('product_id', productId);
    
    return response.map((data) => ProductionLinePhoto.fromJson(data)).toList();
  }

  // Delete a production line photo
  Future<void> deleteProductionLinePhoto(String id) async {
    await _supabase
        .from(_tableName)
        .delete()
        .eq('id', id);
  }
}

// Service class for handling product features
class ProductFeatureService {
  final SupabaseClient _supabase = Supabase.instance.client;
  final String _tableName = 'product_features';

  // Add a new product feature
  Future<String> addProductFeature(ProductFeature feature) async {
    final response = await _supabase
        .from(_tableName)
        .insert(feature.toMap())
        .select('id')
        .single();
    
    return response['id'] as String;
  }

  // Get features for a product
  Future<List<ProductFeature>> getProductFeatures(String productId) async {
    final response = await _supabase
        .from(_tableName)
        .select()
        .eq('product_id', productId);
    
    return response.map((data) => ProductFeature.fromJson(data)).toList();
  }

  // Update a product feature
  Future<void> updateProductFeature(ProductFeature feature) async {
    await _supabase
        .from(_tableName)
        .update(feature.toMap())
        .eq('id', feature.id ?? '');
  }

  // Delete a product feature
  Future<void> deleteProductFeature(String id) async {
    await _supabase
        .from(_tableName)
        .delete()
        .eq('id', id);
  }
}

// Service class for handling technical resources
class TechnicalResourceService {
  final SupabaseClient _supabase = Supabase.instance.client;
  final String _tableName = 'technical_resources';

  // Add a new technical resource
  Future<String> addTechnicalResource(TechnicalResource resource) async {
    final response = await _supabase
        .from(_tableName)
        .insert(resource.toMap())
        .select('id')
        .single();
    
    return response['id'] as String;
  }

  // Get technical resources for a product
  Future<List<TechnicalResource>> getTechnicalResources(String productId) async {
    final response = await _supabase
        .from(_tableName)
        .select()
        .eq('product_id', productId);
    
    return response.map((data) => TechnicalResource.fromJson(data)).toList();
  }

  // Update a technical resource
  Future<void> updateTechnicalResource(TechnicalResource resource) async {
    await _supabase
        .from(_tableName)
        .update(resource.toMap())
        .eq('id', resource.id ?? '');
  }

  // Delete a technical resource
  Future<void> deleteTechnicalResource(String id) async {
    await _supabase
        .from(_tableName)
        .delete()
        .eq('id', id);
  }
}

// Service class for handling product specifications
class ProductSpecificationService {
  final SupabaseClient _supabase = Supabase.instance.client;
  final String _tableName = 'product_specifications';

  // Add product specifications
  Future<String> addProductSpecification(ProductSpecification spec) async {
    final response = await _supabase
        .from(_tableName)
        .insert(spec.toMap())
        .select('id')
        .single();
    
    return response['id'] as String;
  }

  // Get specifications for a product
  Future<ProductSpecification?> getProductSpecification(String productId) async {
    final response = await _supabase
        .from(_tableName)
        .select()
        .eq('product_id', productId)
        .maybeSingle();
    
    if (response == null) return null;
    return ProductSpecification.fromJson(response);
  }

  // Update product specifications
  Future<void> updateProductSpecification(ProductSpecification spec) async {
    await _supabase
        .from(_tableName)
        .update(spec.toMap())
        .eq('id', spec.id ?? '');
  }

  // Delete product specifications
  Future<void> deleteProductSpecification(String id) async {
    await _supabase
        .from(_tableName)
        .delete()
        .eq('id', id);
  }
}

// Service class for handling product packaging
class ProductPackagingService {
  final SupabaseClient _supabase = Supabase.instance.client;
  final String _tableName = 'product_packaging';

  // Add product packaging
  Future<String> addProductPackaging(ProductPackaging packaging) async {
    final response = await _supabase
        .from(_tableName)
        .insert(packaging.toMap())
        .select('id')
        .single();
    
    return response['id'] as String;
  }

  // Get packaging for a product
  Future<ProductPackaging?> getProductPackaging(String productId) async {
    final response = await _supabase
        .from(_tableName)
        .select()
        .eq('product_id', productId)
        .maybeSingle();
    
    if (response == null) return null;
    return ProductPackaging.fromJson(response);
  }

  // Update product packaging
  Future<void> updateProductPackaging(ProductPackaging packaging) async {
    await _supabase
        .from(_tableName)
        .update(packaging.toMap())
        .eq('id', packaging.id ?? '');
  }

  // Delete product packaging
  Future<void> deleteProductPackaging(String id) async {
    await _supabase
        .from(_tableName)
        .delete()
        .eq('id', id);
  }
}

// Service class for handling product videos
class ProductVideosService {
  final SupabaseClient _supabase = Supabase.instance.client;
  final String _videosTableName = 'product_videos';
  final String _videoLinksTableName = 'product_video_links';

  // Add product videos section
  Future<String> addProductVideos(ProductVideos videos) async {
    final response = await _supabase
        .from(_videosTableName)
        .insert(videos.toMap())
        .select('id')
        .single();
    
    return response['id'] as String;
  }

  // Get videos section for a product
  Future<ProductVideos?> getProductVideos(String productId) async {
    final response = await _supabase
        .from(_videosTableName)
        .select()
        .eq('product_id', productId)
        .maybeSingle();
    
    if (response == null) return null;
    
    // Get video links for this section
    final videoLinks = await getVideoLinks(response['id']);
    
    final videos = ProductVideos.fromJson(response);
    return ProductVideos(
      id: videos.id,
      productId: videos.productId,
      sectionTitle: videos.sectionTitle,
      enabled: videos.enabled,
      videoLinks: videoLinks,
      createdAt: videos.createdAt,
    );
  }

  // Update product videos section
  Future<void> updateProductVideos(ProductVideos videos) async {
    await _supabase
        .from(_videosTableName)
        .update(videos.toMap())
        .eq('id', videos.id ?? '');
  }

  // Delete product videos section
  Future<void> deleteProductVideos(String id) async {
    await _supabase
        .from(_videosTableName)
        .delete()
        .eq('id', id);
  }

  // Add a video link
  Future<String> addVideoLink(VideoLink videoLink) async {
    final response = await _supabase
        .from(_videoLinksTableName)
        .insert(videoLink.toMap())
        .select('id')
        .single();
    
    return response['id'] as String;
  }

  // Get video links for a video section
  Future<List<VideoLink>> getVideoLinks(String videoSectionId) async {
    final response = await _supabase
        .from(_videoLinksTableName)
        .select()
        .eq('video_section_id', videoSectionId);
    
    return response.map((data) => VideoLink.fromJson(data)).toList();
  }

  // Delete a video link
  Future<void> deleteVideoLink(String id) async {
    await _supabase
        .from(_videoLinksTableName)
        .delete()
        .eq('id', id);
  }
}

// Service class for handling gallery photos
class GalleryPhotoService {
  final SupabaseClient _supabase = Supabase.instance.client;
  final String _tableName = 'product_gallery_photos';

  // Add a new gallery photo
  Future<String> addGalleryPhoto(GalleryPhoto photo) async {
    final response = await _supabase
        .from(_tableName)
        .insert(photo.toMap())
        .select('id')
        .single();
    
    return response['id'] as String;
  }

  // Get gallery photos for a product
  Future<List<GalleryPhoto>> getGalleryPhotos(String productId) async {
    final response = await _supabase
        .from(_tableName)
        .select()
        .eq('product_id', productId);
    
    return response.map((data) => GalleryPhoto.fromJson(data)).toList();
  }

  // Delete a gallery photo
  Future<void> deleteGalleryPhoto(String id) async {
    await _supabase
        .from(_tableName)
        .delete()
        .eq('id', id);
  }
}