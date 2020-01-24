import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:teste2/admin/atracoesConsulta.dart';
import 'package:teste2/admin/noticiasConsulta.dart';
import 'package:teste2/admin/sign_in.dart';
import 'package:teste2/style/style.dart';
import 'package:teste2/style/widget-botao.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class HomeAdm extends StatefulWidget {
  const HomeAdm({Key key, this.user}) : super(key: key);
  final FirebaseUser user;

  @override
  _HomeAdmState createState() => _HomeAdmState();
}

class _HomeAdmState extends State<HomeAdm> {
  void _signOut() async {
    await _auth.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignInPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corFundo,
      body: FeedHomeadmin(),
    );
  }
}

class FeedHomeadmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          "Administração",
          style: subTitulo2,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  BotaoRota(
                    corBotao: corPrincipal2,
                    height: 50,
                    icone: LineAwesomeIcons.newspaper_o,
                    rota: NoticiasConsulta(),
                    texto: "Notícias",
                    width: 180,
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              BotaoRota(
                corBotao: corPrincipal2,
                height: 50,
                icone: LineAwesomeIcons.map,
                rota: AtracoesConsulta(),
                texto: "Atrações",
                width: 180,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
