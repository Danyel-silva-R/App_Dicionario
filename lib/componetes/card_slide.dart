import 'dart:async';
import 'package:flutter/material.dart';

class AutoCarousel extends StatefulWidget {
  final List<String> imagePaths;
  final double height;
  final Duration interval;
  final Duration animDuration;
  final Curve curve;

  const AutoCarousel({
    super.key,
    required this.imagePaths,
    this.height = 200,
    this.interval = const Duration(seconds: 3),
    this.animDuration = const Duration(milliseconds: 500),
    this.curve = Curves.easeInOut,
  });

  @override
  State<AutoCarousel> createState() => _AutoCarouselState();
}

class _AutoCarouselState extends State<AutoCarousel> {
  late final PageController _controller;
  late Timer _timer;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.92);

    // autoplay
    _timer = Timer.periodic(widget.interval, (_) {
      if (!mounted || !_controller.hasClients || widget.imagePaths.isEmpty)
        return;
      final next = (_current + 1) % widget.imagePaths.length;
      _controller.animateToPage(
        next,
        duration: widget.animDuration,
        curve: widget.curve,
      );
      _current = next;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.imagePaths.length,
            onPageChanged: (i) => setState(() => _current = i),
            itemBuilder: (context, i) {
              final path = widget.imagePaths[i];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    path,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              );
            },
          ),

          // indicadores (bolinhas)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(widget.imagePaths.length, (i) {
                final active = i == _current;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: active ? 18 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: active ? Colors.black54 : Colors.black26,
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
