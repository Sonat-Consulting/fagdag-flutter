import 'package:animations_example/components/lottie_icon.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AnimatedListTile extends StatefulWidget {
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final String? icon;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const AnimatedListTile({
    Key? key,
    this.icon,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  _AnimatedListTileState createState() => _AnimatedListTileState();
}

class _AnimatedListTileState extends State<AnimatedListTile> {
  late bool isHovering = false;

  void handleEnter([dynamic event]) {
    setState(() {
      isHovering = true;
    });
  }

  void handleExit([dynamic event]) {
    setState(() {
      isHovering = false;
    });
  }

  Widget? get trailing {
    if (widget.trailing != null) {
      return widget.trailing;
    } else if (widget.onTap != null) {
      return LottieIcon(
        LottieIcons.arrow_right,
        animate: isHovering,
      );
    }
  }

  Widget? get leading {
    if (widget.icon != null) {
      return LottieIcon(widget.icon!, animate: isHovering);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: handleEnter,
      onExit: handleExit,
      child: GestureDetector(
        onTapDown: handleEnter,
        onTapUp: handleExit,
        onTapCancel: handleExit,
        child: ListTile(
          leading: leading,
          title: widget.title,
          subtitle: widget.subtitle,
          onTap: widget.onTap,
          onLongPress: widget.onLongPress,
          trailing: trailing,
        ),
      ),
    );
  }
}
