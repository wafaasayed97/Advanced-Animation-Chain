import 'package:flutter/material.dart';

class LoadingDotsAnimation extends StatefulWidget {
  final Color dotColor;
  final double dotSize;
  final Duration animationDuration;
  final double spacing;

  const LoadingDotsAnimation({
    super.key,
    this.dotColor = Colors.blue,
    this.dotSize = 12.0,
    this.animationDuration = const Duration(milliseconds: 1500),
    this.spacing = 10.0,
  });

  @override
  _LoadingDotsAnimationState createState() => _LoadingDotsAnimationState();
}

class _LoadingDotsAnimationState extends State<LoadingDotsAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _scaleAnimation1;
  late Animation<double> _scaleAnimation2;
  late Animation<double> _scaleAnimation3;

  late Animation<double> _opacityAnimation1;
  late Animation<double> _opacityAnimation2;
  late Animation<double> _opacityAnimation3;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimation();
  }

  void _initializeAnimations() {
    // Create the main animation controller
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    const double animationOffset = 0.2;
    const double animationDuration = 0.4;

    _scaleAnimation1 = Tween<double>(begin: 1.0, end: 2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, animationDuration, curve: Curves.elasticOut),
      ),
    );

    _scaleAnimation2 = Tween<double>(begin: 1.0, end: 2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          animationOffset,
          animationOffset + animationDuration,
          curve: Curves.elasticOut,
        ),
      ),
    );

    _scaleAnimation3 = Tween<double>(begin: 1.0, end: 2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          animationOffset * 2,
          animationOffset * 2 + animationDuration,
          curve: Curves.elasticOut,
        ),
      ),
    );

    _opacityAnimation1 = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, animationDuration, curve: Curves.easeInOut),
      ),
    );

    _opacityAnimation2 = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          animationOffset,
          animationOffset + animationDuration,
          curve: Curves.easeInOut,
        ),
      ),
    );

    _opacityAnimation3 = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          animationOffset * 2,
          animationOffset * 2 + animationDuration,
          curve: Curves.easeInOut,
        ),
      ),
    );
  }

  void _startAnimation() {
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildAnimatedDot(
              scale: _scaleAnimation1.value,
              opacity: _opacityAnimation1.value,
            ),
            SizedBox(width: widget.spacing),

            _buildAnimatedDot(
              scale: _scaleAnimation2.value,
              opacity: _opacityAnimation2.value,
            ),

            SizedBox(width: widget.spacing),

            // Third dot
            _buildAnimatedDot(
              scale: _scaleAnimation3.value,
              opacity: _opacityAnimation3.value,
            ),
          ],
        );
      },
    );
  }

  Widget _buildAnimatedDot({required double scale, required double opacity}) {
    return Transform.scale(
      scale: scale,
      child: Opacity(
        opacity: opacity,
        child: Container(
          width: widget.dotSize,
          height: widget.dotSize,
          decoration: BoxDecoration(
            color: widget.dotColor,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

class AdvancedLoadingDemo extends StatelessWidget {
  const AdvancedLoadingDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Sequential Loading Dots'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: const Center(
        child: LoadingDotsAnimation(
          dotColor: Colors.blue,
          dotSize: 12.0,
          animationDuration: Duration(milliseconds: 1500),
          spacing: 10.0,
        ),
      ),
    );
  }
}
