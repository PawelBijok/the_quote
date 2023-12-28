import 'dart:math';

import 'package:flutter/material.dart';

class QuoteMarker extends StatefulWidget {
  const QuoteMarker({required this.plainText, required this.onSelectionChanged, super.key});

  final String plainText;
  final ValueChanged<String> onSelectionChanged;
  @override
  State<QuoteMarker> createState() => _QuoteMarkerState();
}

class _QuoteMarkerState extends State<QuoteMarker> {
  late TextEditingController controller;
  late FocusNode focusNode;
  bool readOnly = false;

  void changeListener() {
    final frontOffset = min(controller.selection.extentOffset, controller.selection.baseOffset);
    final rearOffset = max(controller.selection.extentOffset, controller.selection.baseOffset);
    final newText = widget.plainText.substring(frontOffset, rearOffset);
    widget.onSelectionChanged(newText);
  }

  @override
  void initState() {
    controller = TextEditingController(text: widget.plainText);
    focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.selection = TextSelection(baseOffset: 0, extentOffset: controller.text.length);

        setState(() {
          readOnly = true;
        });
      });
    });
    controller.addListener(changeListener);
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(changeListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15).copyWith(bottom: 60),
        child: TextField(
          controller: controller,
          showCursor: true,
          maxLines: null,
          readOnly: readOnly,
          enableInteractiveSelection: true,
          contextMenuBuilder: (context, editableTextState) {
            return AdaptiveTextSelectionToolbar.buttonItems(
              anchors: editableTextState.contextMenuAnchors,
              buttonItems: const [],
            );
          },
          focusNode: focusNode,
        ),
      ),
    );
  }
}
