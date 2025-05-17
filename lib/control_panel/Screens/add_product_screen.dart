import 'package:flutter/material.dart';
import 'package:kutlu_solar_application/control_panel/Models/category_model.dart';
import 'package:kutlu_solar_application/control_panel/Services/category_service.dart';
import 'package:kutlu_solar_application/control_panel/Models/product_model.dart';
import 'package:kutlu_solar_application/control_panel/Services/product_service.dart';
import 'package:kutlu_solar_application/control_panel/Services/storage_service.dart';
import 'package:kutlu_solar_application/control_panel/Services/product_related_services.dart';
import 'package:kutlu_solar_application/control_panel/Models/product_related_models.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormBuilderState>();
  final ProductService _productService = ProductService();
  final CategoryService _categoryService = CategoryService();
  final StorageService _storageService = StorageService();
  final ProductPhotoService _productPhotoService = ProductPhotoService();
  final GalleryPhotoService _galleryPhotoService = GalleryPhotoService();
  
  bool _isLoading = false;
  String _errorMessage = '';
  List<File> _selectedImages = [];
  List<String> _imageUrls = [];
  
  // Tab controller for different sections
  late TabController _tabController;
  late final Stream<List<Category>> _categoriesStream;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _categoriesStream = _categoryService.getCategories(); // cache the stream
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    final List<XFile> pickedImages = await _storageService.pickImages(maxImages: 3);
    
    if (pickedImages.isNotEmpty) {
      setState(() {
        _selectedImages = pickedImages.map((image) => File(image.path)).toList();
      });
    }
  }

  Future<void> _saveProduct() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      if (_selectedImages.isEmpty) {
        setState(() {
          _errorMessage = 'Please select at least one image';
        });
        return;
      }
      
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      try {
        // Upload images to Supabase Storage
        _imageUrls = await _storageService.uploadImages(_selectedImages, 'products');
        
        // Get form values
        final formValues = _formKey.currentState!.value;
        
        // Create product object
        final product = Product(
          name: formValues['name'],
          description: formValues['description'],
          price: double.parse(formValues['price']),
          categoryId: formValues['categoryId'],
          imageUrls: _imageUrls,
          headerSection: formValues['headerSection'],
          productionLineSection: formValues['productionLineSection'],
          featuresSection: formValues['featuresSection'],
          hasTechnicalResources: formValues['hasTechnicalResources'] ?? false,
          hasVideos: formValues['hasVideos'] ?? false,
        );
        
        // Save product to Supabase and get its ID
        final String productId = await _productService.addProduct(product);
        
        // Add product photos
        for (String imageUrl in _imageUrls) {
          final productPhoto = ProductPhoto(
            productId: productId,
            photoUrl: imageUrl,
            // isMainPhoto: _imageUrls.indexOf(imageUrl) == 0,
          );
          await _productPhotoService.addProductPhoto(productPhoto);
        }

        // Add gallery photos
        for (String imageUrl in _imageUrls) {
          final galleryPhoto = GalleryPhoto(
            productId: productId,
            photoUrl: imageUrl,
            // description: '',
          );
          await _galleryPhotoService.addGalleryPhoto(galleryPhoto);
        }
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Product added successfully'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        setState(() {
          _errorMessage = 'Failed to add product: ${e.toString()}';
        });
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Basic Info'),
            Tab(text: 'Header'),
            Tab(text: 'Features'),
            Tab(text: 'Resources'),
            Tab(text: 'Gallery'),
          ],
        ),
      ),
      body: FormBuilder(
        key: _formKey,
        child: TabBarView(
          controller: _tabController,
          children: [
            // Basic Info Tab
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FormBuilderTextField(
                    name: 'name',
                    decoration: const InputDecoration(
                      labelText: 'Product Name',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.inventory),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  const SizedBox(height: 16),
                  FormBuilderTextField(
                    name: 'description',
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.description),
                    ),
                    maxLines: 3,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  const SizedBox(height: 16),
                  FormBuilderTextField(
                    name: 'price',
                    decoration: const InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                    keyboardType: TextInputType.number,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                    ]),
                  ),
                  const SizedBox(height: 16),
                  StreamBuilder<List<Category>>(
                    stream: _categoriesStream, // use the cached stream here
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      
                      final categories = snapshot.data ?? [];
                      
                      if (categories.isEmpty) {
                        return const Text(
                          'No categories available. Please add categories first.',
                          style: TextStyle(color: Colors.red),
                        );
                      }
                      
                      return FormBuilderDropdown<String>(
                        name: 'categoryId', // Field name in form (kept as is for backward compatibility)
                        decoration: const InputDecoration(
                          labelText: 'Category',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.category),
                        ),
                        items: categories
                            .map((category) => DropdownMenuItem(
                                  value: category.id,
                                  child: Text(category.name),
                                ))
                            .toList(),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Product Images (Max 3)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: _selectedImages.isEmpty
                        ? Center(
                            child: TextButton.icon(
                              icon: const Icon(Icons.add_photo_alternate),
                              label: const Text('Add Images'),
                              onPressed: _pickImages,
                            ),
                          )
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _selectedImages.length + 1,
                            itemBuilder: (context, index) {
                              if (index == _selectedImages.length) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon: const Icon(Icons.add_photo_alternate),
                                    onPressed: _selectedImages.length < 3
                                        ? _pickImages
                                        : null,
                                  ),
                                );
                              }
                              return Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.file(
                                      _selectedImages[index],
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.remove_circle,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _selectedImages.removeAt(index);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
            
            // Header Tab
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FormBuilderTextField(
                    name: 'headerSection',
                    decoration: const InputDecoration(
                      labelText: 'Header Section Content',
                      border: OutlineInputBorder(),
                      helperText: 'Enter content for the header section',
                    ),
                    maxLines: 10,
                  ),
                ],
              ),
            ),
            
            // Features Tab
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FormBuilderTextField(
                    name: 'featuresSection',
                    decoration: const InputDecoration(
                      labelText: 'Features Section Content',
                      border: OutlineInputBorder(),
                      helperText: 'Enter product features (one per line)',
                    ),
                    maxLines: 10,
                  ),
                  const SizedBox(height: 16),
                  FormBuilderTextField(
                    name: 'productionLineSection',
                    decoration: const InputDecoration(
                      labelText: 'Production Line Section',
                      border: OutlineInputBorder(),
                      helperText: 'Enter production line details',
                    ),
                    maxLines: 5,
                  ),
                ],
              ),
            ),
            
            // Resources Tab
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FormBuilderSwitch(
                    name: 'hasTechnicalResources',
                    title: const Text('Has Technical Resources'),
                    initialValue: false,
                  ),
                  const SizedBox(height: 16),
                  FormBuilderSwitch(
                    name: 'hasVideos',
                    title: const Text('Has Videos'),
                    initialValue: false,
                  ),
                ],
              ),
            ),
            
            // Gallery Tab
            const SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Gallery images will be added from the main product images',
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveProduct,
                child: _isLoading
                    ? const SpinKitThreeBounce(
                        color: Colors.white,
                        size: 24,
                      )
                    : const Text(
                        'Save Product',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
