import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// BoardScrollProvider
//
// An InheritedWidget that passes down callbacks to start and stop smooth
// auto-scrolling using a Timer on the parent layout loop.
// ---------------------------------------------------------------------------

class BoardScrollProvider extends InheritedWidget {
  final void Function(double speed) startAutoScroll;
  final void Function() stopAutoScroll;

  const BoardScrollProvider({
    super.key,
    required this.startAutoScroll,
    required this.stopAutoScroll,
    required super.child,
  });

  static BoardScrollProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BoardScrollProvider>();
  }

  @override
  bool updateShouldNotify(BoardScrollProvider oldWidget) {
    return true; // Simple approach, functions are bound to state
  }
}
