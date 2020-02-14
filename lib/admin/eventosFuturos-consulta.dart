import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:teste2/style/style.dart';

Firestore db = Firestore.instance;

class ConsultaEventosFuturos extends StatefulWidget {
  @override
  _ConsultaEventosFuturosState createState() => _ConsultaEventosFuturosState();
}

class _ConsultaEventosFuturosState extends State<ConsultaEventosFuturos> {
  String id;
  @override
  Widget build(BuildContext context) {
    Padding buildAtracoes(DocumentSnapshot doc) {
      return Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          actions: <Widget>[],
          secondaryActions: <Widget>[
            IconSlideAction(
              color: redDelete,
              icon: LineAwesomeIcons.trash,
              caption: "Excluir",
              onTap: () => deleteEventosFuturos(doc),
            ),
          ],
          child: Container(
            decoration: BoxDecoration(
                color: corPrincipal2.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10)),
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.only(left: 0, bottom: 10, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      doc.data['evento'],
                      style: subTitulo3white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      '(${formatDate(doc.data['data'].toDate(), [
                        dd,
                        '/',
                        mm,
                        '/',
                        yyyy,
                      ])})',
                      style: subTitulo5whiteReg,
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      doc.data['atracao'],
                      style: subTitulo5whiteReg,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: corFundo,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        "Eventos Futuros",
                        style: tituloPrincipal,
                      ),
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
                        .collection('proximosEventos')
                        .orderBy('data')
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

  void deleteEventosFuturos(DocumentSnapshot doc) async {
    await db.collection('proximosEventos').document(doc.documentID).delete();

    setState(() => id = null);
    Flushbar(
      margin: EdgeInsets.all(20),
      borderRadius: 7,
      backgroundColor: greenAcept,
      title: "Evento Apagadado",
      message: "Evento Apagado com Sucesso",
      duration: Duration(seconds: 5),
    )..show(context);
  }
}
