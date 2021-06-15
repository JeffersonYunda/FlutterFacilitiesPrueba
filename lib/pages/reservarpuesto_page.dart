import 'package:facilities_v1/custom_input/boton_azul.dart';
import 'package:facilities_v1/custom_input/checkbox_days.dart';
import 'package:facilities_v1/custom_input/custom_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReservarPuestoPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.clear, size: 40.0,),
                  SizedBox(width: 30,),
                  Text('Reservar puesto', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),),
                ],
              ),
            ),
          ),
        ),
        preferredSize: Size.fromHeight(100),
      ),

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          //Si tuviesemos que cortar la altura tiramos de aqui
          //height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            children: [
              //Formulario
              _FormularioReservasPuesto(),

              //Espacio entre el formulario y el boton
              //Este espacio deberia calcularse de otra manera o
              //si se usa un SizedBox la altura deberia estar expresada
              //en tanto por ciento
              SizedBox(
                height: 200,
              ),

              //Boton de reservar
              BotonAzul(
                  text: "Reservar puesto",
                  onPressed: (){}
              )

            ],
          ),
        ),
      )
    );
  }
}

class _FormularioReservasPuesto extends StatefulWidget{

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_FormularioReservasPuesto> {

  final emailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: [
          //Dia inicio y dia fin
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomInput(
                icon: Icons.calendar_today_outlined,
                placeholder: '31.05.2021',
                keyboardType: TextInputType.datetime,
                textController: emailCtrl,
                widthPercentage: 0.45,
                title: "Día inicio",
              ),

              CustomInput(
                icon: Icons.calendar_today_outlined,
                placeholder: '13.06.2021',
                keyboardType: TextInputType.datetime,
                textController: emailCtrl,
                widthPercentage: 0.45,
                title: "Día fin",
              ),
            ],
          ),

          //Espacio
          SizedBox(
            height: 10,
          ),

          //Edificio
          CustomInput(
              icon: Icons.arrow_right_outlined,
              placeholder: 'Edificio Espaitec II',
              textController: emailCtrl,
              widthPercentage: 0.94,
              title: "Edificio"
          ),

          //Espacio
          SizedBox(
            height: 10,
          ),

          //Numero de planta y zona
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomInput(
                icon: Icons.arrow_right_outlined,
                placeholder: 'Planta 4',
                keyboardType: TextInputType.datetime,
                textController: emailCtrl,
                widthPercentage: 0.45,
                title: "Nº de Planta",
              ),

              CustomInput(
                icon: Icons.arrow_right_outlined,
                placeholder: 'Zona B',
                keyboardType: TextInputType.datetime,
                textController: emailCtrl,
                widthPercentage: 0.45,
                title: "Zona",
              ),
            ],
          ),

          //Espacio
          SizedBox(
            height: 10,
          ),

          //Puesto y boton de mapa
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03,),
                child: CustomInput(
                    icon: Icons.arrow_right_outlined,
                    placeholder: 'Puesto número 45',
                    textController: emailCtrl,
                    widthPercentage: 0.65,
                    title: "Puesto"
                ),
              ),

              //Boton circular
              Container(
                margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.03),
                decoration: BoxDecoration(color: Colors.greenAccent, shape: BoxShape.circle),
                width: 60,
                height: 60,
                child: IconButton(
                  icon: Icon(Icons.map),
                  enableFeedback: true,
                  onPressed: (){},
                ),
              )
            ],
          ),

          //Dias de la semana
          CheckboxDay(
            isChecked: true,
            size: 50,
            iconSize: 50,
            selectedColor: Colors.black,
            selectedIconColor: Colors.black,
          )

        ],
      ),
    );

  }
}