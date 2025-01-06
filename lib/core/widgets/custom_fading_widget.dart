import 'package:flutter/material.dart';

class CustomFadingSnackBar extends StatefulWidget {
  const CustomFadingSnackBar({super.key, required this.child});

  final Widget child;

  @override
  State<CustomFadingSnackBar> createState() => _CustomFadingWidgetState();
}

class _CustomFadingWidgetState extends State<CustomFadingSnackBar>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    animation = Tween<double>(begin: .2, end: .8).animate(animationController);

    animationController.addListener(() {
      setState(() {});
    });
    animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: animation.value,
      child: widget.child,
    );
  }
}
