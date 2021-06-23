import 'package:facilities_v1/models/ReservaModel.dart';
import 'package:facilities_v1/pages/reservas/reservas_actuales_page.dart';
import 'package:facilities_v1/pages/reservas/reservas_historico_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ReservasPage extends StatefulWidget {
  const ReservasPage({Key? key}) : super(key: key);

  @override
  State<ReservasPage> createState() => _ReservasPageState();
}

class _ReservasPageState extends State<ReservasPage> with SingleTickerProviderStateMixin {
  
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final List<Reservation> argumento = ModalRoute.of(context)!.settings.arguments as List<Reservation>;
    
    return Scaffold(
      appBar: AppBar(
        // Icono retroceder
        leading:  IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 30),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
        title: Text('Mis reservas'),
        actions: [
          Row(
            children: <Widget> [
              // Icono ajustes
              IconButton(
                icon: Icon(Icons.add_road, color: Colors.black, size: 30),
                onPressed: (){},
              ),
              // Icono buscar
              IconButton(
                icon: Icon(Icons.search, size: 30),
                onPressed: (){},
              ),
            ],
          )
        ],
        bottom: getTabBar()
      ),
      body: getTabBarView(<Widget> [
        ReservasActuales(reservas: argumento),
        ReservasHistorico(reservas: argumento)
      ]
        
      )
    );
  }

  TabBar getTabBar() {  
    
    return TabBar(
      isScrollable: false,
      labelStyle:TextStyle(fontSize: 16),
      unselectedLabelStyle:TextStyle(fontSize: 16),
      indicatorColor:Colors.greenAccent,
      unselectedLabelColor: Colors.grey[500],
      labelColor:Colors.black,

      tabs: <Tab> [
        Tab(text: 'ACTUALES'),
        Tab(text: 'HISTÓRICO'),
      ],
      controller: _controller,
    );
  }

  TabBarView getTabBarView(var displays) {
    return TabBarView(
     // physics: NeverScrollableScrollPhysics(),
      dragStartBehavior: DragStartBehavior.down,
      children: displays,
      controller: _controller,
    );
  }
}


