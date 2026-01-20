import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';

class ToggleButtonGroup extends StatefulWidget {
  final String option1;
  final String option2;
  final Function(String)? onSelectionChanged;
  final String? initialSelection;

  const ToggleButtonGroup({
    Key? key,
    required this.option1,
    required this.option2,
    this.onSelectionChanged,
    this.initialSelection,
  }) : super(key: key);

  @override
  State<ToggleButtonGroup> createState() => _ToggleButtonGroupState();
}

class _ToggleButtonGroupState extends State<ToggleButtonGroup> {
  late String selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.initialSelection ?? widget.option1;
  }

  void _onButtonPressed(String option) {
    setState(() {
      selectedOption = option;
    });
    widget.onSelectionChanged?.call(option);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 41,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildButton(widget.option1),
          const SizedBox(width: 8),
          _buildButton(widget.option2),
        ],
      ),
    );
  }

  Widget _buildButton(String label) {
    final isSelected = selectedOption == label;

    return GestureDetector(
      onTap: () => _onButtonPressed(label),
      child: Container(
        height: 41,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: ShapeDecoration(
          color: isSelected ? thirtyGreenColor : txtSecondary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? txtWhite : txtPrimary,
              fontSize: 14,
              fontFamily: 'Visby Round CF',
              fontWeight: medium,
              height: 1.43,
            ),
          ),
        ),
      ),
    );
  }
}
