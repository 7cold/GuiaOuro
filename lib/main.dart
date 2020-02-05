import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:teste2/pages/atracoes-page.dart';
import 'package:teste2/pages/gastronomia-page.dart';
import 'package:teste2/pages/noticias-page.dart';
import 'package:teste2/pages/sobre-page.dart';
import 'package:teste2/style/style.dart';
import 'package:teste2/style/widget-botao.dart';
import 'package:teste2/style/widget-efeito-rota.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

const localeList = [
  'en',
  'en_short',
  'es',
  'es_short',
  'de',
  'fr',
  'ja',
  'id',
  'pt_BR',
  'pt_BR_short',
  'zh',
  'zh_CN',
  'it',
  'fa',
  'ru',
  'tr',
  'pl',
  'th',
  'th_short',
  'nb_NO',
  'nb_NO_short',
  'nn_NO',
  'nn_NO_short',
  'ku',
  'ku_short',
  'ar',
  'ar_short',
  'ko',
  'en_custom',
  'ro',
  'ro_short'
];

main() async {
  // Add additional locales
  localeList.forEach((locale) {
    switch (locale) {
      case 'de':
        setLocaleMessages(locale, DeMessages());
        break;
      case 'fr':
        setLocaleMessages(locale, FrMessages());
        break;
      case 'ja':
        setLocaleMessages(locale, JaMessages());
        break;
      case 'id':
        setLocaleMessages(locale, IdMessages());
        break;
      case 'pt_BR':
        setLocaleMessages(locale, PtBrMessages());
        break;
      case 'pt_BR_short':
        setLocaleMessages(locale, PtBrShortMessages());
        break;
      case 'zh':
        setLocaleMessages(locale, ZhMessages());
        break;
      case 'zh_CN':
        setLocaleMessages(locale, ZhCnMessages());
        break;
      case 'it':
        setLocaleMessages(locale, ItMessages());
        break;
      case 'fa':
        setLocaleMessages(locale, FaMessages());
        break;
      case 'ru':
        setLocaleMessages(locale, RuMessages());
        break;
      case 'tr':
        setLocaleMessages(locale, TrMessages());
        break;
      case 'pl':
        setLocaleMessages(locale, PlMessages());
        break;
      case 'th':
        setLocaleMessages(locale, ThMessages());
        break;
      case 'th_short':
        setLocaleMessages(locale, ThShortMessages());
        break;
      case 'nb_NO':
        setLocaleMessages(locale, NbNoMessages());
        break;
      case 'nb_NO_short':
        setLocaleMessages(locale, NbNoShortMessages());
        break;
      case 'nn_NO':
        setLocaleMessages(locale, NnNoMessages());
        break;
      case 'nn_NO_short':
        setLocaleMessages(locale, NnNoShortMessages());
        break;
      case 'ku':
        setLocaleMessages(locale, KuMessages());
        break;
      case 'ku_short':
        setLocaleMessages(locale, KuShortMessages());
        break;
      case 'ar':
        setLocaleMessages(locale, ArMessages());
        break;
      case 'ar_short':
        setLocaleMessages(locale, ArShortMessages());
        break;
      case 'ko':
        setLocaleMessages(locale, KoMessages());
        break;
      case 'ro':
        setLocaleMessages(locale, RoMessages());
        break;
      case 'ro_short':
        setLocaleMessages(locale, RoShortMessages());
        break;
    }
  });
  return runApp(MyApp());
}

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
        const Locale('pt', 'BR'),
      ],
      title: 'GuiaOuro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
                          Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Image.asset(
                              "lib/style/images/logo.png",
                              scale: 25,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Seu guia em",
                                  style: subTituloMain2,
                                ),
                                Text(
                                  "Ouro Fino",
                                  style: subTituloMain2,
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
                    pagina: Noticias(),
                  ),
                  _Feed(
                    text: "Atrações",
                    foto: 'lib/style/images/atracoes.jpg',
                    pagina: Atracoes(),
                  ),
                  _Feed(
                      text: "Gastronomia",
                      foto: 'lib/style/images/gastronomia.jpg',
                      pagina: Gastronomia()),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 15),
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
        elevation: 5,
        shadowColor: corPrincipal2.withOpacity(0.5),
        borderRadius: BorderRadius.circular(7),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              ScaleRoute(
                page: pagina,
              ),
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
