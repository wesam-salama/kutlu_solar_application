import 'package:kutlu_solar_application/control_panel/Models/category_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:async';

class CategoryService {
  final SupabaseClient _supabase = Supabase.instance.client;
  final String _tableName = 'categories';

  // Get all categories
  Stream<List<Category>> getCategories() {
    final controller = StreamController<List<Category>>.broadcast(); // <-- make it broadcast

    // Initial fetch
    _fetchCategories().then(
      (categories) => controller.add(categories),
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
            _fetchCategories().then(
              (categories) => controller.add(categories),
              onError: (error) => controller.addError(error),
            );
          },
        )
        .subscribe();

    controller.onCancel = () {
      subscription.unsubscribe();
      controller.close();
    };

    return controller.stream;
  }

  // Helper method to fetch categories
  Future<List<Category>> _fetchCategories() async {
    final response = await _supabase
        .from(_tableName)
        .select()
        .order('name', ascending: true);

    return response.map((data) => Category.fromJson(data)).toList();
  }

  // Get a single category by ID
  Future<Category> getCategoryById(String id) async {
    final data = await _supabase
        .from(_tableName)
        .select()
        .eq('id', id)
        .single();

    return Category.fromJson(data);
  }

  // Add a new category
  Future<String> addCategory(Category category) async {
    final response = await _supabase
        .from(_tableName)
        .insert(category.toMap())
        .select('id')
        .single();

    return response['id'] as String;
  }

  // Update a category
  Future<void> updateCategory(Category category) async {
    await _supabase
        .from(_tableName)
        .update(category.toMap())
        .eq('id', category.id ?? '');
  }

  // Delete a category
  Future<void> deleteCategory(String id) async {
    await _supabase
        .from(_tableName)
        .delete()
        .eq('id', id);
  }
}
