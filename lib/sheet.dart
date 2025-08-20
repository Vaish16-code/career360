import 'package:flutter/material.dart';

enum SheetSide { top, bottom, left, right }

class Sheet extends StatefulWidget {
  final Widget child;
  final bool isOpen;
  final SheetSide side;
  final VoidCallback? onClose;

  const Sheet({
    super.key,
    required this.child,
    required this.isOpen,
    this.side = SheetSide.right,
    this.onClose,
  });

  @override
  State<Sheet> createState() => _SheetState();
}

class _SheetState extends State<Sheet> with SingleTickerProviderStateMixin {
  Duration get _duration => widget.isOpen
      ? const Duration(milliseconds: 500)
      : const Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        // Overlay
        if (widget.isOpen)
          GestureDetector(
            onTap: widget.onClose,
            child: AnimatedOpacity(
              opacity: widget.isOpen ? 1 : 0,
              duration: _duration,
              child: Container(
                width: size.width,
                height: size.height,
                color: Colors.black.withValues(alpha: 0.8),
              ),
            ),
          ),

        // Sheet Content
        AnimatedPositioned(
          duration: _duration,
          curve: Curves.easeInOut,
          top: widget.side == SheetSide.top
              ? (widget.isOpen ? 0 : -size.height)
              : (widget.side == SheetSide.bottom ? null : 0),
          bottom: widget.side == SheetSide.bottom
              ? (widget.isOpen ? 0 : -size.height)
              : (widget.side == SheetSide.top ? null : 0),
          left: widget.side == SheetSide.left
              ? (widget.isOpen ? 0 : -size.width * 0.75)
              : 0,
          right: widget.side == SheetSide.right
              ? (widget.isOpen ? 0 : -size.width * 0.75)
              : 0,
          child: Container(
            width:
                (widget.side == SheetSide.left ||
                    widget.side == SheetSide.right)
                ? size.width * 0.75
                : size.width,
            height:
                (widget.side == SheetSide.top ||
                    widget.side == SheetSide.bottom)
                ? size.height * 0.5
                : size.height,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Stack(
              children: [
                widget.child,

                // Close Button (Top-right)
                Positioned(
                  top: 16,
                  right: 16,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: widget.onClose,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SheetHeader extends StatelessWidget {
  final Widget? child;
  const SheetHeader({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(16), child: child);
  }
}

class SheetFooter extends StatelessWidget {
  final Widget? child;
  const SheetFooter({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [if (child != null) child!],
      ),
    );
  }
}

class SheetTitle extends StatelessWidget {
  final String text;
  const SheetTitle(this.text, {super.key});

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

class SheetDescription extends StatelessWidget {
  final String text;
  const SheetDescription(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).hintColor),
    );
  }
}
