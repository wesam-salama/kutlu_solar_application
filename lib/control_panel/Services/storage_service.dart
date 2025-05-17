import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  final SupabaseClient _supabase = Supabase.instance.client;
  final ImagePicker _picker = ImagePicker();
  
  // Pick multiple images from gallery
  Future<List<XFile>> pickImages({int maxImages = 3}) async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.length > maxImages) {
      return images.sublist(0, maxImages);
    }
    return images;
  }
  
  // Pick a single image from gallery
  Future<XFile?> pickImage() async {
    return await _picker.pickImage(source: ImageSource.gallery);
  }
  
  // Upload a single image to Supabase Storage
  Future<String> uploadImage(File imageFile, String folder) async {
    final String fileName = '${const Uuid().v4()}.jpg';
    final String filePath = '$folder/$fileName';
    
    // Upload file to Supabase Storage
    await _supabase.storage.from('images').upload(
      filePath,
      imageFile,
      fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
    );
    
    // Get the public URL
    final String imageUrl = _supabase.storage.from('images').getPublicUrl(filePath);
    
    return imageUrl;
  }
  
  // Upload multiple images to Supabase Storage
  Future<List<String>> uploadImages(List<File> imageFiles, String folder) async {
    List<String> downloadUrls = [];
    
    for (var imageFile in imageFiles) {
      String url = await uploadImage(imageFile, folder);
      downloadUrls.add(url);
    }
    
    return downloadUrls;
  }
  
  // Delete an image from Supabase Storage
  Future<void> deleteImage(String imageUrl) async {
    try {
      // Extract the file path from the URL
      // The URL format is typically like: https://[project-ref].supabase.co/storage/v1/object/public/images/[folder]/[filename]
      final Uri uri = Uri.parse(imageUrl);
      final List<String> pathSegments = uri.pathSegments;
      
      // Find the 'images' bucket in the path and extract the remaining path
      int imagesIndex = pathSegments.indexOf('images');
      if (imagesIndex != -1 && imagesIndex < pathSegments.length - 1) {
        final String filePath = pathSegments.sublist(imagesIndex + 1).join('/');
        await _supabase.storage.from('images').remove([filePath]);
      } else {
        throw Exception('Invalid image URL format');
      }
    } catch (e) {
      debugPrint('Error deleting image: $e');
    }
  }
  }

