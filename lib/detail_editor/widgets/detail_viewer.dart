import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:dart_quill_delta/dart_quill_delta.dart';

class ProductDetailViewer extends StatelessWidget {
  const ProductDetailViewer({super.key});

  @override
  Widget build(BuildContext context) {
    // Your test delta as JSON
    final testDeltaJson = [
      {"insert": "HIII"},
      {"insert": "\n", "attributes": {"header": 1}},
      {"insert": "wesam", "attributes": {"bold": true}},
      {"insert": "\nsalama\nqw"},
      {"insert": "\n", "attributes": {"list": "bullet"}},
      {"insert": "as"},
      {"insert": "\n", "attributes": {"list": "bullet"}},
      {"insert": "fg"},
      {"insert": "\n", "attributes": {"list": "bullet"}},
      {"insert": "\n"}
    ];

    final delta = Delta.fromJson(testDeltaJson);
    final controller = QuillController(
      document: Document.fromDelta(delta),
      selection: const TextSelection.collapsed(offset: 0),
      readOnly: true
    );
    // controller.readOnly = true; // Set the controller to read-only mode
    // controller.skipRequestKeyboard = true; // Skip keyboard request
    // controller.ignoreFocusOnTextChange = true; // Ignore focus on text change
    

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        height: 200,
        width: 200,
        color: Colors.red,
        child: QuillEditor.basic(
          controller: controller,
          config: const QuillEditorConfig(
            autoFocus: false,
            expands: false,
            showCursor: false,
            padding: EdgeInsets.zero,
            scrollable: true,
            // minHeight: 0,
            // maxHeight: 200,
            // maxContentWidth: 200
          ),
        ),
      ),
    );
  }
}
