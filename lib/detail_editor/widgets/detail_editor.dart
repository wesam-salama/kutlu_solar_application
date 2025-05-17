
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailEditor extends StatefulWidget {
  final String productId;
  final String collectionPath;

  const ProductDetailEditor({
    super.key,
    required this.productId,
    this.collectionPath = 'products',
  });

  @override
  _ProductDetailEditorState createState() => _ProductDetailEditorState();
}

class _ProductDetailEditorState extends State<ProductDetailEditor> {
  late final QuillController _controller;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadDocument();
  }

  Future<void> _loadDocument() async {
    // final snap = await FirebaseFirestore.instance
    //     .collection(widget.collectionPath)
    //     .doc(widget.productId)
    //     .get();
    // if (snap.exists && snap.data()!.containsKey('detail')) {
    //   final delta = Delta.fromJson(snap.get('detail') as List<dynamic>);
    //   _controller = QuillController(
    //     document: Document.fromDelta(delta),
    //     selection: const TextSelection.collapsed(offset: 0),
    //   );
    // } else {
      _controller = QuillController.basic();
    // }
    setState(() => _loading = false);
  }

  Future<void> _saveDocument() async {
    final deltaJson = _controller.document.toDelta().toJson();
    print(deltaJson);
    // await FirebaseFirestore.instance
    //     .collection(widget.collectionPath)
    //     .doc(widget.productId)
    //     .set({'detail': deltaJson}, SetOptions(merge: true));
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Saved')));
  }

  @override
  void dispose() {
    _controller.dispose();  // recommended in v11.x :contentReference[oaicite:2]{index=2}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Column(
        
        children: [
          // use the new simple toolbar API :contentReference[oaicite:3]{index=3}
          QuillSimpleToolbar(
            controller: _controller,
            config: const QuillSimpleToolbarConfig(),
          ),
          Expanded(
            child: QuillEditor.basic(
              
              controller: _controller,
              // readOnly: false,
              config: const QuillEditorConfig(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: _saveDocument,
              icon: const Icon(Icons.save),
              label: const Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}
