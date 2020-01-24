import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:teste2/admin/atracoesCad.dart';
import 'package:teste2/style/style.dart';
import 'package:teste2/style/widget-botao.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flushbar/flushbar.dart';

Firestore db = Firestore.instance;

class AtracoesConsulta extends StatefulWidget {
  @override
  _AtracoesConsultaState createState() => _AtracoesConsultaState();
}

class _AtracoesConsultaState extends State<AtracoesConsulta> {
  Slidable buildAtracoes(DocumentSnapshot doc) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      actions: <Widget>[],
      secondaryActions: <Widget>[
        IconSlideAction(
          color: corPrincipal2,
          icon: LineAwesomeIcons.calendar,
          caption: "Eventos",
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EventosAtracoes(
                      atracao: doc.data['atracao'],
                      idAtracao: doc.documentID,
                    )),
          ),
        ),
      ],
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 20,
                      top: 20,
                      child: SizedBox(
                        height: 10,
                        width: 10,
                        child: CircularProgressIndicator(
                          backgroundColor: corPrincipal2,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                    FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: doc.data['img'],
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  doc.data['atracao'],
                  style: subTitulo3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corFundoLight,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      "Atrações",
                      style: tituloPrincipal,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, bottom: 20),
                child: Text("Arraste para ver as ações", style: textoPagina),
              ),
              Row(
                children: <Widget>[
                  StreamBuilder<QuerySnapshot>(
                    stream: db
                        .collection('atracoes')
                        .orderBy('atracao')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                            children: snapshot.data.documents
                                .map((doc) => buildAtracoes(doc))
                                .toList());
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//----------Eventos das Atracoes ----------

class EventosAtracoes extends StatefulWidget {
  final String atracao;
  final String idAtracao;

  const EventosAtracoes({Key key, this.atracao, this.idAtracao})
      : super(key: key);

  @override
  _EventosAtracoesState createState() =>
      _EventosAtracoesState(atracao, idAtracao);
}

class _EventosAtracoesState extends State<EventosAtracoes> {
  final _formKey = GlobalKey<FormState>();
  final format = new DateFormat.yMMMd().add_Hm();

  final String atracao;
  final String idAtracao;
  _EventosAtracoesState(this.atracao, this.idAtracao);

  String id;
  String idEvento;
  String evento;
  String descricao;
  DateTime data;

  TextEditingController controllerEvento = TextEditingController();
  TextEditingController controllerData = TextEditingController();
  TextEditingController controllerDescricao = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Container buildEventos(DocumentSnapshot docEventos, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: corPrincipal2,
        borderRadius: BorderRadius.circular(7),
      ),
      width: MediaQuery.of(context).size.width * 0.90,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
            child: Material(
              elevation: 3,
              shadowColor: corPrincipal.withOpacity(0.4),
              borderRadius: BorderRadius.circular(7),
              child: Container(
                decoration: BoxDecoration(
                  color: corPrincipal,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.737,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "${docEventos.data['evento']}",
                                  style: subTitulo3white,
                                ),
                                Text(
                                  '${formatDate(docEventos.data['data'].toDate(), [
                                    dd,
                                    '/',
                                    mm,
                                    '/',
                                    yyyy,
                                  ])}',
                                  style: subTitulo4white,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.737,
                              child: Text(
                                "${docEventos.data['descricao']}",
                                style: textoCardwhite,
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Botao(
                corBotao: corPrincipal,
                width: 150,
                funcao: null,
                height: 35,
                icone: LineAwesomeIcons.edit,
                texto: "Editar",
              ),
              InkWell(
                onTap: () {
                  deleteEvento(docEventos);

                  Flushbar(
                    margin: EdgeInsets.all(20),
                    borderRadius: 7,
                    backgroundColor: greenAcept,
                    title: "Apagado",
                    message: "Evento Apagado com sucesso",
                    duration: Duration(seconds: 5),
                  )..show(context);
                },
                child: BotaoSingle(
                  corBotao: corFundoLight,
                  width: 150,
                  height: 35,
                  icone: LineAwesomeIcons.trash,
                  texto: "Excluir",
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corFundo,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(atracao, style: tituloPrincipal2),
                Padding(
                  padding: EdgeInsets.only(left: 10, top: 40, bottom: 10),
                  child: BotaoRota(
                    corBotao: corPrincipal2,
                    rota: AtracoesCad(
                      atracao: atracao,
                      idAtracao: idAtracao,
                    ),
                    height: 45,
                    icone: LineAwesomeIcons.plus_circle,
                    texto: "Add Evento",
                    width: 0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 10),
                  child: Text(
                    "Eventos",
                    style: subTitulo,
                  ),
                ),
                Row(
                  children: <Widget>[
                    StreamBuilder<QuerySnapshot>(
                      stream: db
                          .collection('atracoes')
                          .document(idAtracao)
                          .collection('eventos')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                              children: snapshot.data.documents
                                  .map((docEventos) => Padding(
                                        padding: EdgeInsets.only(bottom: 20),
                                        child:
                                            buildEventos(docEventos, context),
                                      ))
                                  .toList());
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void deleteEvento(DocumentSnapshot docEventos) async {
    await db
        .collection('atracoes')
        .document(idAtracao)
        .collection('eventos')
        .document(docEventos.documentID)
        .delete();
    setState(() => idEvento = null);
  }
}
