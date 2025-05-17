import 'package:kutlu_solar_application/control_panel/Models/product_model.dart';
import 'package:kutlu_solar_application/control_panel/Models/product_related_models.dart';
import 'package:kutlu_solar_application/control_panel/Services/product_related_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:async';

class ProductService {
  final SupabaseClient _supabase = Supabase.instance.client;
  final String _tableName = 'products';

  // Get all products
  Stream<List<Product>> getProducts() {
    // Create a StreamController to convert Future to Stream
    final controller = StreamController<List<Product>>();
    
    // Initial fetch
    _fetchProducts().then(
      (products) => controller.add(products),
      onError: (error) => controller.addError(error),
    );
    
    // Set up a subscription to Supabase realtime changes
    final subscription = _supabase
        .channel('public:$_tableName')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: _tableName,
          callback: (payload) {
            // Refetch data when changes occur
            _fetchProducts().then(
              (products) => controller.add(products),
              onError: (error) => controller.addError(error),
            );
          },
        )
        .subscribe();
    
    // Clean up when the stream is cancelled
    controller.onCancel = () {
      subscription.unsubscribe();
      controller.close();
    };
    
    return controller.stream;
  }
  
  // Helper method to fetch products
  Future<List<Product>> _fetchProducts() async {
    final response = await _supabase
        .from(_tableName)
        .select()
        .order('name', ascending: true);
    
    return response.map((data) => Product.fromJson(data)).toList();
  }

  // Get products by category
  Stream<List<Product>> getProductsByCategory(String categoryId) {
    // Create a StreamController to convert Future to Stream
    final controller = StreamController<List<Product>>();
    
    // Initial fetch
    _fetchProductsByCategory(categoryId).then(
      (products) => controller.add(products),
      onError: (error) => controller.addError(error),
    );
    
    // Set up a subscription to Supabase realtime changes
    final subscription = _supabase
        .channel('public:$_tableName:category_id=eq.$categoryId')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: _tableName,
          callback: (payload) {
            // Refetch data when changes occur
            _fetchProductsByCategory(categoryId).then(
              (products) => controller.add(products),
              onError: (error) => controller.addError(error),
            );
          },
        )
        .subscribe();
    
    // Clean up when the stream is cancelled
    controller.onCancel = () {
      subscription.unsubscribe();
      controller.close();
    };
    
    return controller.stream;
  }
  
  // Helper method to fetch products by category
  Future<List<Product>> _fetchProductsByCategory(String categoryId) async {
    final response = await _supabase
        .from(_tableName)
        .select()
        .eq('category_id', categoryId)
        .order('name', ascending: true);
    
    return response.map((data) => Product.fromJson(data)).toList();
  }

  // Get a single product by ID with all related data
  Future<ProductWithRelatedData> getProductById(String id) async {
    final productData = await _supabase
        .from(_tableName)
        .select()
        .eq('id', id)
        .single();
    
    final product = Product.fromJson(productData);
    
    // Get all related data
    final productPhotoService = ProductPhotoService();
    final productionLinePhotoService = ProductionLinePhotoService();
    final productFeatureService = ProductFeatureService();
    final technicalResourceService = TechnicalResourceService();
    final productSpecificationService = ProductSpecificationService();
    final productPackagingService = ProductPackagingService();
    final productVideosService = ProductVideosService();
    final galleryPhotoService = GalleryPhotoService();
    
    final relatedData = await Future.wait([
      productPhotoService.getProductPhotos(id),
      productionLinePhotoService.getProductionLinePhotos(id),
      productFeatureService.getProductFeatures(id),
      technicalResourceService.getTechnicalResources(id),
      productSpecificationService.getProductSpecification(id),
      productPackagingService.getProductPackaging(id),
      productVideosService.getProductVideos(id),
      galleryPhotoService.getGalleryPhotos(id),
    ]);
    
    return ProductWithRelatedData(
      product: product,
      photos: relatedData[0] as List<ProductPhoto>,
      productionLinePhotos: relatedData[1] as List<ProductionLinePhoto>,
      features: relatedData[2] as List<ProductFeature>,
      technicalResources: relatedData[3] as List<TechnicalResource>,
      specification: relatedData[4] as ProductSpecification?,
      packaging: relatedData[5] as ProductPackaging?,
      videos: relatedData[6] as ProductVideos?,
      galleryPhotos: relatedData[7] as List<GalleryPhoto>,
    );
  }

  // Add a new product with all related data
  Future<String> addProduct(Product product, {
    List<ProductPhoto>? photos,
    List<ProductionLinePhoto>? productionLinePhotos,
    List<ProductFeature>? features,
    List<TechnicalResource>? technicalResources,
    ProductSpecification? specification,
    ProductPackaging? packaging,
    ProductVideos? videos,
    List<GalleryPhoto>? galleryPhotos,
  }) async {
    // First add the product
    final response = await _supabase
        .from(_tableName)
        .insert(product.toMap())
        .select('id')
        .single();
    
    final productId = response['id'] as String;
    
    // Then add all related data if provided
    if (photos != null) {
      final productPhotoService = ProductPhotoService();
      for (final photo in photos) {
        await productPhotoService.addProductPhoto(photo.copyWith(productId: productId));
      }
    }
    
    if (productionLinePhotos != null) {
      final productionLinePhotoService = ProductionLinePhotoService();
      for (final photo in productionLinePhotos) {
        await productionLinePhotoService.addProductionLinePhoto(photo.copyWith(productId: productId));
      }
    }
    
    if (features != null) {
      final productFeatureService = ProductFeatureService();
      for (final feature in features) {
        await productFeatureService.addProductFeature(feature.copyWith(productId: productId));
      }
    }
    
    if (technicalResources != null) {
      final technicalResourceService = TechnicalResourceService();
      for (final resource in technicalResources) {
        await technicalResourceService.addTechnicalResource(resource.copyWith(productId: productId));
      }
    }
    
    if (specification != null) {
      final productSpecificationService = ProductSpecificationService();
      await productSpecificationService.addProductSpecification(specification.copyWith(productId: productId));
    }
    
    if (packaging != null) {
      final productPackagingService = ProductPackagingService();
      await productPackagingService.addProductPackaging(packaging.copyWith(productId: productId));
    }
    
    if (videos != null) {
      final productVideosService = ProductVideosService();
      await productVideosService.addProductVideos(videos.copyWith(productId: productId));
    }
    
    if (galleryPhotos != null) {
      final galleryPhotoService = GalleryPhotoService();
      for (final photo in galleryPhotos) {
        await galleryPhotoService.addGalleryPhoto(photo.copyWith(productId: productId));
      }
    }
    
    return productId;
  }

  // Update a product
  Future<void> updateProduct(Product product) async {
    await _supabase
        .from(_tableName)
        .update(product.toMap())
        .eq('id', product.id ?? '');
  }

  // Delete a product
  Future<void> deleteProduct(String id) async {
    // First delete all related product data
    final productPhotoService = ProductPhotoService();
    final productionLinePhotoService = ProductionLinePhotoService();
    final productFeatureService = ProductFeatureService();
    final technicalResourceService = TechnicalResourceService();
    final productSpecificationService = ProductSpecificationService();
    final productPackagingService = ProductPackagingService();
    final productVideosService = ProductVideosService();
    final galleryPhotoService = GalleryPhotoService();
    
    // Delete all related records
    await Future.wait([
      productPhotoService.deleteProductPhoto(id),
      productionLinePhotoService.deleteProductionLinePhoto(id),
      productFeatureService.deleteProductFeature(id),
      technicalResourceService.deleteTechnicalResource(id),
      productSpecificationService.deleteProductSpecification(id),
      productPackagingService.deleteProductPackaging(id),
      productVideosService.deleteProductVideos(id),
      galleryPhotoService.deleteGalleryPhoto(id),
    ]);
    
    // Finally delete the product itself
    await _supabase
        .from(_tableName)
        .delete()
        .eq('id', id);
  }
}
