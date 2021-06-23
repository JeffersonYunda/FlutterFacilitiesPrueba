import 'package:facilities_v1/pages/espacios_page.dart';
import 'package:facilities_v1/pages/home_page.dart';
import 'package:facilities_v1/pages/login_page.dart';
import 'package:facilities_v1/pages/reserva_detalle_page.dart';
import 'package:facilities_v1/pages/reservarpuesto_page.dart';
import 'package:facilities_v1/pages/reservas/reservas_page.dart';
import 'package:flutter/cupertino.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'espacios_page': ( _ ) => EspaciosPage(),
  'reservar_puesto': ( _ ) => ReservarPuestoPage(),
  'home': ( _ ) => HomePage(),
  'reserva_detalle': ( _ ) => ReservaDetallePage(),
  'reservas': ( _ ) => ReservasPage(),
  'login': ( _ ) => LoginPage()
};