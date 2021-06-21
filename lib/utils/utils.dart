
int fechaSegundos(String inicio) { 
  List<String> valoresInicio = <String>[];
  String sinInicio;
  sinInicio = inicio.replaceAll('-', ' ').replaceAll(':', ' ').replaceAll('.', ' ').replaceAll('T', ' ');
  valoresInicio = sinInicio.split(' ');
  int anoInicio = 0;
  int mesInicio = 0;
  int diaInicio = 0;
  int horaInicio = 0;
  int minutosInicio = 0;
  int segundosInicio = 0;
  for (var i = 0; i < valoresInicio.length; i++) {
    if(i == 0) {
      anoInicio = int.parse(valoresInicio[i]);
    }
    if(i == 1) {
      mesInicio = int.parse(valoresInicio[i]);
    }
    if(i == 2) {
      diaInicio = int.parse(valoresInicio[i]);
    }
    if(i == 3) {
      horaInicio = int.parse(valoresInicio[i]);
    }
    if(i == 4) {
      minutosInicio = int.parse(valoresInicio[i]);
    }
    if(i == 5) {
      segundosInicio = int.parse(valoresInicio[i]);
    }
  }

  final actual = DateTime.now();
  final prevista = DateTime(anoInicio, mesInicio, diaInicio, horaInicio, minutosInicio, segundosInicio);
  final diferenciaUno = actual.difference(prevista).inSeconds;
  
  return diferenciaUno * -1;
}


int fechaSegundosDos(String fechainicio, String fechafin) {
  List<String> valoresInicio = <String>[];
  String sinInicio;
  sinInicio = fechainicio.replaceAll('-', ' ').replaceAll(':', ' ').replaceAll('.', ' ').replaceAll('T', ' ');
  valoresInicio = sinInicio.split(' ');

  List<String> valoresFin = <String>[];
  String sinFin;
  sinFin = fechafin.replaceAll('-', ' ').replaceAll(':', ' ').replaceAll('.', ' ').replaceAll('T', ' ');
  valoresFin = sinFin.split(' ');

  int anoInicio = 0;
  int mesInicio = 0;
  int diaInicio = 0;
  int horaInicio = 0;
  int minutosInicio = 0;
  int segundosInicio = 0;

   int anoFin = 0;
  int mesFin = 0;
  int diaFin = 0;
  int horaFin = 0;
  int minutosFin = 0;
  int segundosFin = 0;


  for (var i = 0; i < valoresInicio.length; i++) {
    if(i == 0) {
      anoInicio = int.parse(valoresInicio[i]);
    }
    if(i == 1) {
      mesInicio = int.parse(valoresInicio[i]);
    }
    if(i == 2) {
      diaInicio = int.parse(valoresInicio[i]);
    }
    if(i == 3) {
      horaInicio = int.parse(valoresInicio[i]);
    }
    if(i == 4) {
      minutosInicio = int.parse(valoresInicio[i]);
    }
    if(i == 5) {
      segundosInicio = int.parse(valoresInicio[i]);
    }
  }


  for (var i = 0; i < valoresFin.length; i++) {
    if(i == 0) {
      anoFin = int.parse(valoresFin[i]);
    }
    if(i == 1) {
      mesFin = int.parse(valoresFin[i]);
    }
    if(i == 2) {
      diaFin = int.parse(valoresFin[i]);
    }
    if(i == 3) {
      horaFin = int.parse(valoresFin[i]);
    }
    if(i == 4) {
      minutosFin = int.parse(valoresFin[i]);
    }
    if(i == 5) {
      segundosFin = int.parse(valoresFin[i]);
    }
  }

  final inicio = DateTime(anoInicio, mesInicio, diaInicio, horaInicio, minutosInicio, segundosInicio);
  final fin = DateTime(anoFin, mesFin, diaFin, horaFin, minutosFin, segundosFin);
  final diferenciaDos = inicio.difference(fin).inSeconds;
  
  return diferenciaDos * -1;

}


int colorHexadecimal(String color) {
  var cortar = color.split('#');
  String numero = '0xFF' + cortar[1];

  print(numero);

  return int.parse(numero);
}
  