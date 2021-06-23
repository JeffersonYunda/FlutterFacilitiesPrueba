import 'package:flutter/material.dart';

class CajaReservaFechaWidget extends StatefulWidget {

  final TextEditingController dateController;
  final String placeHolder;
  final IconData icon;
  final String title;

  const CajaReservaFechaWidget({
    Key? key,
    required this.dateController,
    required this.placeHolder,
    required this.icon,
    required this.title
  }) : super(key: key);

  @override
  _CajaReservaFechaWidgetState createState() => _CajaReservaFechaWidgetState();
}

class _CajaReservaFechaWidgetState extends State<CajaReservaFechaWidget> {

  DateTime startDate = DateTime.now();

  Future<Null> selectTimePicker(BuildContext context) async{
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: DateTime(1940),
        lastDate: DateTime(2030)
    );

    if(picked != null && picked != startDate){
      setState(() {
        startDate = picked;
        widget.dateController.text = "${startDate.day.toString()}.${startDate.month.toString()}.${startDate.year.toString()}";;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Titulo de la etiqueta
        Container(
          child: Text(
            widget.title,
            style: TextStyle(
                letterSpacing: 0.5,
                color: Colors.grey
            ),
          ),
        ),
        //Campo de texto para la fecha
        Container(
          width: MediaQuery.of(context).size.width * 0.45,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: Offset(0, 3)
                )
              ]
          ),

          child: TextField(
            onTap: (){
              selectTimePicker(context);
            },
            keyboardType: TextInputType.datetime,
            style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
            autocorrect: false,
            controller: widget.dateController,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 5, top: 15),
                suffixIcon: Icon(widget.icon),
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                hintText: widget.placeHolder
            ),
          ),
        ),

      ],
    );
  }
}
