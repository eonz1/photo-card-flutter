import 'package:flutter/material.dart';

class CustomChoiceChip extends StatelessWidget {
  final String label;
  final bool selected;

  const CustomChoiceChip({
    super.key,
    required this.label,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      selected: selected,
      label: Text(label),
      labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: selected == true ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
      selectedColor: Color(0xffFF5286),
      showCheckmark: false,
      shape: const StadiumBorder(),
    );
  }
}
