import 'package:flutter/material.dart';

typedef HoverWidgetBuilder = Widget Function(bool isHovered);

class HoverBuilder extends StatefulWidget {
  final HoverWidgetBuilder builder;
  const HoverBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  State<HoverBuilder> createState() => _HoverBuilderState();
}

class _HoverBuilderState extends State<HoverBuilder> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: widget.builder(_isHovered),
    );
  }
}
