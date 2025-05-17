import 'package:flutter/material.dart';

import 'widgets/detail_editor.dart';
import 'widgets/detail_viewer.dart';


class ProductDetailScreen extends StatelessWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Product Details'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Edit'),
              Tab(text: 'View'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ProductDetailEditor(productId: productId),
            ProductDetailViewer(),
          ],
        ),
      ),
    );
  }
}
