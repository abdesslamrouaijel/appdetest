import 'dart:async';
import 'package:flutter/material.dart';

class AnimatedTextHighlight extends StatefulWidget {
  final String text;
  final TextStyle normalStyle;
  final TextStyle highlightStyle;
  final Duration duration;

  const AnimatedTextHighlight({
    super.key,
    required this.text,
    required this.normalStyle,
    required this.highlightStyle,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  State<AnimatedTextHighlight> createState() =>
      _AnimatedTextHighlightState();
}

class _AnimatedTextHighlightState extends State<AnimatedTextHighlight> {
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(widget.duration, (timer) {
      if (!mounted) return;

      setState(() {
        _currentIndex = (_currentIndex + 1) % widget.text.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: List.generate(widget.text.length, (index) {
          return TextSpan(
            text: widget.text[index],
            style: index == _currentIndex
                ? widget.highlightStyle
                : widget.normalStyle,
          );
        }),
      ),
    );
  }
}
