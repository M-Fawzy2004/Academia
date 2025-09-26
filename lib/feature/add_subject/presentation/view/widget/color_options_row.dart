import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/theme/app_color.dart';

class ColorOptionsRow extends StatefulWidget {
  final Color? initialSelectedColor;
  final Function(Color selectedColor)? onColorSelected;

  const ColorOptionsRow({
    super.key,
    this.initialSelectedColor,
    this.onColorSelected,
  });

  @override
  State<ColorOptionsRow> createState() => _ColorOptionsRowState();
}

class _ColorOptionsRowState extends State<ColorOptionsRow> {
  Color? selectedColor;

  final List<Color> availableColors = [
    AppColors.primaryColor,
    const Color(0xFF7B68EE),
    const Color(0xFF50C878),
    const Color(0xFFFF6B6B),
    const Color(0xFFFFB347),
  ];

  @override
  void initState() {
    super.initState();
    selectedColor = widget.initialSelectedColor ?? availableColors.first;
  }

  void _selectColor(Color color) {
    setState(() {
      selectedColor = color;
    });
    widget.onColorSelected?.call(color);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: availableColors.map((color) {
        final isSelected = selectedColor == color;
        return GestureDetector(
          onTap: () => _selectColor(color),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: isSelected
                  ? Border.all(
                      color: color,
                      width: 3.w,
                    )
                  : null,
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: color.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            padding: EdgeInsets.all(isSelected ? 4.w : 0),
            child: CircleAvatar(
              radius: 25.r,
              backgroundColor: color,
              child: isSelected
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 20.sp,
                    )
                  : null,
            ),
          ),
        );
      }).toList(),
    );
  }
}
