import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:teste2/admin/sign-in.dart';
import 'package:teste2/style/style.dart';
import 'package:intl/intl.dart';
import 'package:teste2/style/widget-botao.dart';

class Sobre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corFundo,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 20),
                    child: Image.asset(
                      "lib/style/images/sobre.png",
                      scale: 5,
                    ),
                  ),
                  Text("Sobre", style: tituloPrincipal2),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(15),
                      shadowColor: corPrincipal.withOpacity(0.7),
                      child: Container(
                        decoration: BoxDecoration(
                            color: corPrincipal.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Aplicativo desenvolvido para aqueles que tem interesse nas notícias, eventos e gastronomia da cidade de Ouro Fino - MG.",
                            style: subTitulo3white,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 40),
                    child: Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(15),
                      shadowColor: corPrincipal.withOpacity(0.2),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: corPrincipal.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Contato: 7cold.co@gmail.com",
                                style: subTitulo3white,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "Todos os Direitos Reservados - " +
                                    formatDate(DateTime.now(), [yyyy]),
                                style: subTitulo3white,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 40),
                    child: BotaoRota(
                      corBotao: corPrincipal.withOpacity(0.7),
                      rota: SignInPage(),
                      height: 50,
                      icone: LineAwesomeIcons.key,
                      texto: "Administração",
                      width: 100,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
