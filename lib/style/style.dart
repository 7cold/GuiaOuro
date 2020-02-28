import 'package:flutter/material.dart';

final String bold = 'Gilroy-Bold';
final String reg = 'Gilroy-Regular';
final String light = 'Gilroy-Light';
final String semi = 'Gilroy-Medium';
final String heavy = 'Gilroy-Heavy';
final String textoReg = 'SourceSansPro-Regular';
final String textoLight = 'SourceSansPro-Light';

// Cor principal
const MaterialColor white = const MaterialColor(
  0xFFFFFFFF,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
    100: const Color(0xFFFFFFFF),
    200: const Color(0xFFFFFFFF),
    300: const Color(0xFFFFFFFF),
    400: const Color(0xFFFFFFFF),
    500: const Color(0xFFFFFFFF),
    600: const Color(0xFFFFFFFF),
    700: const Color(0xFFFFFFFF),
    800: const Color(0xFFFFFFFF),
    900: const Color(0xFFFFFFFF),
  },
);

const MaterialColor corPrincipal = const MaterialColor(
  0xFF0F6CFB,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
  },
);
const MaterialColor corFundo = const MaterialColor(
  0xFFeef4fe,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
  },
);

const MaterialColor corPrincipal2 = const MaterialColor(
  0xFF5798FC,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
  },
);

const MaterialColor corSplashScreen = const MaterialColor(
  0xFFddeafe,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
  },
);

const MaterialColor corSecundaria = const MaterialColor(
  0xFF1F4A77,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
  },
);

const MaterialColor corFundoDark = const MaterialColor(
  0xFF0B1824,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
  },
);

const MaterialColor corFundoLight = const MaterialColor(
  0xFFFAFAFA,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
  },
);

const MaterialColor redDelete = const MaterialColor(
  0xFFe74c3c,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
  },
);

const MaterialColor greenAcept = const MaterialColor(
  0xFF2ecc71,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
  },
);

//------FONTES-----

TextStyle tituloPrincipal = TextStyle(
  fontFamily: heavy,
  color: corFundoDark,
  fontSize: 50,
);

TextStyle tituloPrincipal2 = TextStyle(
  fontFamily: heavy,
  color: corFundoDark,
  fontSize: 40,
);

TextStyle tituloPrincipal2white = TextStyle(
  fontFamily: heavy,
  color: corFundoLight,
  fontSize: 40,
);

TextStyle subTitulo = TextStyle(
  fontFamily: heavy,
  color: corFundoDark,
  fontSize: 35,
);

TextStyle subTitulo2 = TextStyle(
  fontFamily: bold,
  color: corFundoDark,
  fontSize: 25,
);

TextStyle subTituloMain1 = TextStyle(
  fontFamily: semi,
  color: corSecundaria,
  fontSize: 25,
);

TextStyle subTituloMain2 = TextStyle(
  fontFamily: heavy,
  color: corSecundaria,
  fontSize: 28,
);

TextStyle subTitulo3 = TextStyle(
  fontFamily: semi,
  color: corFundoDark,
  fontSize: 20,
);

TextStyle subTitulo2white = TextStyle(
  fontFamily: bold,
  color: corFundoLight,
  fontSize: 25,
);

TextStyle subTitulo3white = TextStyle(
  fontFamily: semi,
  color: corFundoLight,
  fontSize: 22,
);

TextStyle subTitulo4white = TextStyle(
  fontFamily: reg,
  color: corFundoLight,
  fontSize: 20,
);

TextStyle subTitulo4 = TextStyle(
  fontFamily: bold,
  color: corFundoDark,
  fontSize: 18,
);

TextStyle subTitulo4Reg = TextStyle(
  fontFamily: reg,
  color: corFundoDark,
  fontSize: 18,
);

TextStyle subTitulo4RegRed = TextStyle(
  fontFamily: reg,
  color: redDelete,
  fontSize: 18,
);

TextStyle subTitulo4RegGreen = TextStyle(
  fontFamily: reg,
  color: greenAcept,
  fontSize: 18,
);

TextStyle subTitulo5white = TextStyle(
  fontFamily: bold,
  color: corFundoLight,
  fontSize: 20,
);

TextStyle subTitulo5whiteReg = TextStyle(
  fontFamily: reg,
  color: corFundoLight,
  fontSize: 18,
);

TextStyle textoPagina = TextStyle(
  fontFamily: textoReg,
  color: Colors.black54,
  fontSize: 20,
);

TextStyle textoPagina2 = TextStyle(
  fontFamily: textoReg,
  color: Colors.black45,
  fontSize: 14,
);

TextStyle textoPaginaLight = TextStyle(
  fontFamily: light,
  color: corFundoDark,
  fontSize: 22,
);

TextStyle textoCardwhite = TextStyle(
  fontFamily: textoReg,
  color: corFundoLight.withOpacity(0.8),
  fontSize: 22,
);

TextStyle fonteTag = TextStyle(
  fontFamily: reg,
  color: Colors.white,
  fontSize: 18,
);

TextStyle fonteTag2 = TextStyle(
  fontFamily: reg,
  color: corFundoDark,
  fontSize: 18,
);

TextStyle card22 = TextStyle(
  fontFamily: bold,
  color: Colors.white,
  fontSize: 22,
  shadows: [
    Shadow(
      blurRadius: 10.0,
      color: Colors.black87,
      offset: Offset(1.0, 1.0),
    ),
  ],
);

TextStyle card20 = TextStyle(
  fontFamily: bold,
  color: Colors.white,
  fontSize: 20,
  shadows: [
    Shadow(
      blurRadius: 10.0,
      color: Colors.black87,
      offset: Offset(1.0, 1.0),
    ),
  ],
);

TextStyle fonteData = TextStyle(
  fontFamily: semi,
  color: corFundoDark,
  fontSize: 15.5,
);

TextStyle fonteData2 = TextStyle(
  fontFamily: semi,
  color: corFundoDark,
  fontSize: 18,
);

TextStyle tituloCard = TextStyle(
  fontFamily: bold,
  color: Colors.white,
  fontSize: 20,
  shadows: [
    Shadow(blurRadius: 10.0, color: Colors.black, offset: Offset(3.0, 3.0)),
  ],
);

TextStyle fonteLink = TextStyle(
  fontFamily: reg,
  color: corPrincipal2,
  fontSize: 20,
);

TextStyle fonteBotao = TextStyle(
  fontFamily: bold,
  color: Colors.white,
  fontSize: 20,
);

TextStyle fonteCampoTexto = TextStyle(
  fontFamily: light,
  color: corFundoDark,
  fontSize: 22,
);

TextStyle fonteCampoTextoHint = TextStyle(
  fontFamily: reg,
  color: Colors.black45,
  fontSize: 22,
);

TextStyle fonteErroInput = TextStyle(
  fontFamily: reg,
  color: redDelete,
  fontSize: 13,
);

TextStyle fonteChip = TextStyle(
  fontFamily: bold,
  color: corFundoLight,
  fontSize: 14,
);

//-----------------
