import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {

  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;
  final double widthPercentage;
  final String title;

  const CustomInput({
    Key? key,
    required this.icon,
    required this.placeholder,
    required this.textController,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    required this.widthPercentage,
    required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [


        Container(
          child: Text(
      title,
            style: TextStyle(
                letterSpacing: 0.5,
              color: Colors.grey
            ),
          ),
        ),

        Container(
          width: MediaQuery.of(context).size.width * widthPercentage,
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
            style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
            controller: this.textController,
            autocorrect: false,
            keyboardType: this.keyboardType,
            obscureText: this.isPassword,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 5, top: 15),
                suffixIcon: Icon(this.icon),
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                hintText: this.placeholder
            ),
          ),
        )
      ],
    );
  }
}
