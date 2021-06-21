import 'package:facilities_v1/blocs/theme.dart';
import 'package:facilities_v1/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider(
      create: ( _ ) => ThemeChanger( ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.blue,
        secondaryHeaderColor: Colors.green,
        fontFamily: 'anext'
      )),
      child: MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final theme = Provider.of<ThemeChanger>(context);

    return MaterialApp(
      theme: theme.getTheme(),
      debugShowCheckedModeBanner: false,
      title: 'Reservas',
      initialRoute: 'espacios_page',
      routes: appRoutes,
    );
  }
}
