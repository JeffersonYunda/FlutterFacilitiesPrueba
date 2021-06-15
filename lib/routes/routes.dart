
import 'package:facilities_v1/pages/home_page.dart';
import 'package:facilities_v1/pages/reservarpuesto_page.dart';
import 'package:flutter/cupertino.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'reservar_puesto': ( _ ) => ReservarPuestoPage(),
  'home': ( _ ) => HomePage(),
};