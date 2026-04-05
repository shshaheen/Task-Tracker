import 'dart:async';
import 'package:flutter/material.dart';
import 'board_scroll_provider.dart';

// ---------------------------------------------------------------------------
// ResponsiveBoard
// ---------------------------------------------------------------------------

class ResponsiveBoard extends StatefulWidget {
  final List<Widget> columns;

  const ResponsiveBoard({super.key, required this.columns});

  @override
  State<ResponsiveBoard> createState() => _ResponsiveBoardState();
}

class _ResponsiveBoardState extends State<ResponsiveBoard> {
  late final ScrollController _scrollController;
  Timer? _scrollTimer;
  double _currentScrollSpeed = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _startAutoScroll(double speed) {
    _currentScrollSpeed = speed;
    if (_scrollTimer != null && _scrollTimer!.isActive) return;

    _scrollTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (!_scrollController.hasClients) return;
      
      final maxExtent = _scrollController.position.maxScrollExtent;
      final newOffset = _scrollController.offset + _currentScrollSpeed;

      if (newOffset <= 0) {
        _scrollController.jumpTo(0);
      } else if (newOffset >= maxExtent) {
        _scrollController.jumpTo(maxExtent);
      } else {
        _scrollController.jumpTo(newOffset);
      }
    });
  }

  void _stopAutoScroll() {
    _scrollTimer?.cancel();
    _scrollTimer = null;
  }

  @override
  Widget build(BuildContext context) {
    // Provide the scroll controller down the tree for drag-to-scroll features
    return BoardScrollProvider(
      startAutoScroll: _startAutoScroll,
      stopAutoScroll: _stopAutoScroll,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Mobile layout: Smoothly scrolling horizontal list
          if (constraints.maxWidth < 600) {
            return SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.columns.map((col) => SizedBox(
                  width: constraints.maxWidth * 0.85, // Fill most of screen but tease next column
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: col,
                  ),
                )).toList(),
              ),
            );
          }
          
          // Tablet layout: Scrollable row showing ~2 columns side-by-side
          else if (constraints.maxWidth < 1000) {
            return SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.columns.map((col) => SizedBox(
                  width: constraints.maxWidth / 1.8,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: col,
                  ),
                )).toList(),
              ),
            );
          }
          
          // Desktop/Web layout: Static Row with Expanded columns
          else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.columns.map((col) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: col,
                  ),
                )).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
