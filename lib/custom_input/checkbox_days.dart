import 'package:flutter/material.dart';

class CheckboxDay extends StatefulWidget {

  final bool isChecked;
  final double size;
  final double iconSize;
  final Color selectedColor;
  final Color selectedIconColor;

  const CheckboxDay({Key? key, required this.isChecked, required this.size, required this.iconSize, required this.selectedColor, required this.selectedIconColor}) : super(key: key);

  @override
  _CheckboxDayState createState() => _CheckboxDayState();
}

class _CheckboxDayState extends State<CheckboxDay> {

  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {

    //_isSelected = widget.isChecked ?? false;

    return GestureDetector(
      onTap: (){
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.fastLinearToSlowEaseIn,
        decoration: BoxDecoration(
          color: _isSelected ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(5.0),
          border: _isSelected ? null : Border.all(
            color: Colors.grey,
            width: 2.0
          )
        ),
        width: widget.size,
        height: widget.size,
        child: _isSelected ? Icon(
          Icons.check,
          color: Colors.white,
          size: widget.iconSize,
        ) : null,
      ),
    );
  }
}
