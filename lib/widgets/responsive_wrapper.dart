import 'package:flutter/material.dart';

/// Widget yang membuat child menjadi responsif terhadap berbagai ukuran layar handphone.
/// Gunakan ResponsiveWrapper di root widget setiap screen.
class ResponsiveWrapper extends StatelessWidget {
  final Widget child;
  final double minWidth;
  final double maxWidth;
  final double minHeight;
  final double maxHeight;

  const ResponsiveWrapper({
    Key? key,
    required this.child,
    this.minWidth = 320,
    this.maxWidth = 600,
    this.minHeight = 480,
    this.maxHeight = 1200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final double width = screenWidth.clamp(minWidth, maxWidth);
    final double height = screenHeight.clamp(minHeight, maxHeight);

    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: child,
      ),
    );
  }
}
