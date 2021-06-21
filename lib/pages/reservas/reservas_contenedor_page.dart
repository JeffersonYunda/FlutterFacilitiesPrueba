import 'package:flutter/material.dart';

class DisplayWidget extends StatelessWidget  {
  final texto;
  DisplayWidget(this.texto);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(texto)
      ),
    );
  }
}