import 'package:facilities_v1/common/HttpHandler.dart';
import 'package:facilities_v1/custom_input/boton_azul.dart';
import 'package:facilities_v1/custom_input/checkbox_days.dart';
import 'package:facilities_v1/custom_input/custom_input.dart';
import 'package:facilities_v1/models/BuildingModel.dart';
import 'package:facilities_v1/models/FacilityModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<Widget> listaWidget = [];
var listaEdificios;
var lista_temp;
late BuildingModel model;

class ReservarPuestoPage extends StatefulWidget {
  @override
  _ReservarPuestoPageState createState() => _ReservarPuestoPageState();
}

class _ReservarPuestoPageState extends State<ReservarPuestoPage> {
  var listaEdificios;
  var lista_temp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListaEdificios();
  }


  Future<Null> getListaEdificios() async {


    lista_temp = HttpHandler().getFacilitiesAvailables();
    model = await HttpHandler().getFacilitiesAvailables();

    setState(() {

      listaWidget.add(DropdownCustom(building: model));

      //print("Obteniendo: ${model.facility_name}");

     // print(moderl.facility_name);
      listaEdificios =  lista_temp;
    });



      //listaWidget.add(Text("Hila desde arriba"));
      //Ahora en vez de un Text, añadimos un dropdown
      //BuildingModel buildingModel = listaEdificios;

      //listaWidget.add(DropdownCustom(building: buildingModel));

      //listaEdificios = lista_temp;


  }

  late FacilityModel facilitySelected;

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
                    Icon(
                      Icons.clear,
                      size: 40.0,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Reservar puesto',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
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
                FutureBuilder(
                    future: listaEdificios,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child:
                              Text("Ha ocurrido un error: ${snapshot.error}"),
                        );
                      } else if (snapshot.hasData) {
                        BuildingModel building = snapshot.data as BuildingModel;

                        //Cambiamos la opcion por defecto para que no nos pete.
                        //Asignamos siempre el primer edificio del listado.
                        facilitySelected = building.facilities[0];


                        return Column(
                          //children: listaWidget

                          children: [

                            DropdownButton<FacilityModel>(
                              value: facilitySelected,
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 24,

                              items: building.facilities
                                  .map<DropdownMenuItem<FacilityModel>>(
                                      (FacilityModel facility) {
                                return DropdownMenuItem<FacilityModel>(
                                    value: facility,
                                    child: Text(facility.name));
                              }).toList(),

                              onChanged: (FacilityModel? newFacility){

                                print("El edificio elegido es: ${newFacility!.name}");

                                //Hacemos una peticion aqui
                                listaEdificios = HttpHandler().getEntityFacility("/facility/" + newFacility.id +  "/search");

                                setState(() {

                                });
                              },
                            ),

                          ],



                        );
                      }

                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    })

                //_FormularioReservasPuesto(),

                //Espacio entre el formulario y el boton
                //Este espacio deberia calcularse de otra manera o
                //si se usa un SizedBox la altura deberia estar expresada
                //en tanto por ciento
                /*
              SizedBox(
                height: 200,
              ),
*/
                //Boton de reservar
                /*
              BotonAzul(
                  text: "Reservar puesto",
                  onPressed: (){}
              )

               */
              ],
            ),
          ),
        ),

        floatingActionButton: FloatingActionButton(
        onPressed: () async {

          //Desde aqui hacemos una peticion web
          lista_temp = HttpHandler().getEntityFacility("/facility/" + model.facilities.last.id +  "/search");
          model = await HttpHandler().getEntityFacility("/facility/" + model.facilities.last.id  + "/search");

          setState(() {
            listaWidget.add(DropdownCustom(building: model));
            listaEdificios =  lista_temp;
          });

        },
    child: Container(),
    ),

    );
  }
}






class DropdownCustom extends StatefulWidget {
  final BuildingModel building;

  const DropdownCustom({Key? key, required this.building}) : super(key: key);

  @override
  _DropdownCustomState createState() => _DropdownCustomState();
}

class _DropdownCustomState extends State<DropdownCustom> {
  @override
  Widget build(BuildContext context) {
    FacilityModel facilitySelected = widget.building.facilities[0];

    // TODO: implement build
    return DropdownButton<FacilityModel>(
      value: facilitySelected,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurple,
      ),
      onChanged: (FacilityModel? newFacility) {
        setState(() async {
          facilitySelected = newFacility!;

          print("El siguiente elemento a llamar es ${newFacility.id}");
          //Aqui hay que hacer listaWidget.add

          lista_temp = HttpHandler().getEntityFacility("/facility/" + facilitySelected.id +  "/search");
          model = await HttpHandler().getEntityFacility("/facility/" + facilitySelected.id  + "/search");

          setState(() {
            listaWidget.add(DropdownCustom(building: model));
            listaEdificios =  lista_temp;

          });

        });
      },
      items: widget.building.facilities
          .map<DropdownMenuItem<FacilityModel>>((FacilityModel facility) {
        return DropdownMenuItem<FacilityModel>(
            value: facility, child: Text(facility.name));
      }).toList(),
    );
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class _FormularioReservasPuesto extends StatefulWidget {
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
              title: "Edificio"),

          //Espacio
          /*
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
*/
        ],
      ),
    );
  }
}
