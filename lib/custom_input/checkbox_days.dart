import 'package:facilities_v1/utils/utils.dart';
import 'package:flutter/material.dart';

class CheckboxDay extends StatefulWidget {

   bool isChecked;
   double size;
   double iconSize;
   bool disabled;
   String text;
  
  CheckboxDay({
    required this.isChecked,
    required this.size,
    required this.iconSize,
    required this.disabled,
    required this.text
  }) ;

  
  @override
  _CheckboxDayState createState() => _CheckboxDayState();
}

class _CheckboxDayState extends State<CheckboxDay> {

  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {

    //_isSelected = widget.isChecked ?? false;
    print("${widget.isChecked} 1" ) ;

    return !widget.disabled ? GestureDetector(
      onTap: (){

        setState(() {
          _isSelected = !_isSelected;
          print("${widget.isChecked} 2");
          widget.isChecked = !widget.isChecked;
          print("${widget.isChecked} 3");
        });

      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.fastLinearToSlowEaseIn,
        decoration: BoxDecoration(
          color: _isSelected ? Theme.of(context).accentColor : Colors.transparent,
          borderRadius: BorderRadius.circular(10.0),
          border: _isSelected ? null : Border.all(
            color: Theme.of(context).accentColor,
            width: 2.0
          )
        ),
        width: widget.size,
        height: widget.size,
        child:  _isSelected ? Center(
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black54
            ),
          ),
        )
            :
        Center(
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              color: Colors.black54
            ),
          ),
        ),
      ),
    )
    :
    AnimatedContainer(
      duration: Duration(milliseconds: 200),
      curve: Curves.fastLinearToSlowEaseIn,
      decoration: BoxDecoration(
          color:  Color(colorHexadecimal("#ededed")),
          borderRadius: BorderRadius.circular(10.0),

      ),
      width: widget.size,
      height: widget.size,
      child:  Center(
        child: Text(
          widget.text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey[400]
          ),
        ),
      )
    );
  }
}
