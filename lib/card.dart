import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final double elevation;
  final ShapeBorder? shape;

  const AppCard({
    super.key,
    this.child,
    this.margin,
    this.color,
    this.elevation = 1,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin ?? const EdgeInsets.all(8),
      elevation: elevation,
      color: color ?? Theme.of(context).cardColor,
      shape:
          shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Theme.of(context).dividerColor, width: 1),
          ),
      child: child,
    );
  }
}

class CardHeader extends StatelessWidget {
  final Widget? child;

  const CardHeader({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [if (child != null) child!],
      ),
    );
  }
}

class CardTitle extends StatelessWidget {
  final String text;

  const CardTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
    );
  }
}

class CardDescription extends StatelessWidget {
  final String text;

  const CardDescription(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.bodySmall?.copyWith(color: Theme.of(context).hintColor),
    );
  }
}

class CardContent extends StatelessWidget {
  final Widget? child;

  const CardContent({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: child,
    );
  }
}

class CardFooter extends StatelessWidget {
  final Widget? child;

  const CardFooter({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(children: [if (child != null) child!]),
    );
  }
}
