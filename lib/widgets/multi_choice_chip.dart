import 'package:flutter/material.dart';
import '../theme.dart';

class MultiChoiceChip extends StatefulWidget {
  final List<String> options;
  final List<String> initial;
  final ValueChanged<List<String>> onChanged;

  const MultiChoiceChip({
    super.key,
    required this.options,
    this.initial = const [],
    required this.onChanged,
  });

  @override
  State<MultiChoiceChip> createState() => _MultiChoiceChipState();
}

class _MultiChoiceChipState extends State<MultiChoiceChip> {
  late List<String> selected;

  @override
  void initState() {
    super.initState();
    selected = [...widget.initial];
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: widget.options.map((o) {
        final sel = selected.contains(o);
        return ChoiceChip(
          label: Text(o),
          selected: sel,
          labelStyle: TextStyle(
            color: sel ? Colors.white : const Color(0xFF5E5A7D),
            fontWeight: FontWeight.w500,
          ),
          selectedColor: kGradientStart,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(
              color: sel ? kGradientStart : const Color(0xFFE5E0FF),
            ),
          ),
          onSelected: (_) {
            setState(() {
              sel ? selected.remove(o) : selected.add(o);
            });
            widget.onChanged(selected);
          },
        );
      }).toList(),
    );
  }
}
