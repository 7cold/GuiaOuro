import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:teste2/pages/atracoes.dart';
import 'package:teste2/pages/gastronomia.dart';
import 'package:teste2/pages/lazyloader.dart';
import 'package:teste2/pages/noticiasCategorias.dart';
import 'package:teste2/pages/sobre.dart';
import 'package:teste2/style/style.dart';
import 'package:teste2/style/widget-botao.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt'), // PT
      ],
      title: 'Guia Ouro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: white,
        brightness: Brightness.light,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corFundo,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: AnimationConfiguration.toStaggeredList(
                duration: Duration(milliseconds: 800),
                childAnimationBuilder: (widget) => SlideAnimation(
                  horizontalOffset: MediaQuery.of(context).size.width / 2,
                  child: FadeInAnimation(child: widget),
                ),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 40),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "lib/style/images/logo.png",
                            scale: 25,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Seu guia em",
                                  style: subTitulo3,
                                ),
                                Text(
                                  "Ouro Fino",
                                  style: subTitulo3,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  _Feed(
                    text: "Notícias",
                    foto: 'lib/style/images/noticias.jpg',
                    pagina: NoticiasCategorias(),
                  ),
                  _Feed(
                    text: "Atrações",
                    foto: 'lib/style/images/atracoes.jpg',
                    pagina: Atracoes(),
                  ),
                  _Feed(
                    text: "Gastronomia",
                    foto: 'lib/style/images/gastronomia.jpg',
                    pagina: Gastronomia(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //botao sobre app
                        BotaoRota(
                          corBotao: corPrincipal2,
                          rota: Sobre(),
                          icone: LineAwesomeIcons.info_circle,
                          height: 50,
                          texto: "Sobre",
                          width: 150,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Feed extends StatelessWidget {
  final String text;
  final String foto;
  final Object pagina;

  const _Feed({Key key, this.text, this.foto, this.pagina}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20, left: 30, right: 30),
      child: Material(
        elevation: 3,
        shadowColor: corPrincipal2.withOpacity(0.3),
        borderRadius: BorderRadius.circular(7),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => pagina),
            );
          },
          child: Container(
            height: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              image: DecorationImage(
                image: AssetImage(foto),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(7),
                          bottomRight: Radius.circular(7),
                        ),
                        color: Colors.white.withOpacity(0.6)),
                    height: 40,
                  ),
                ),
                Positioned(
                  bottom: 2,
                  left: 10,
                  child: Text(text, style: card22),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
