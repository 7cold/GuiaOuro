import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:teste2/admin/emprego-cadastro.dart';
import 'package:teste2/style/style.dart';
import 'package:date_format/date_format.dart';
import 'package:teste2/style/widget-botao.dart';
import 'package:teste2/style/widget-campo-texto.dart';

final db = Firestore.instance;

class EmpregoConsulta extends StatefulWidget {
  @override
  EmpregoConsultaState createState() {
    return EmpregoConsultaState();
  }
}

class EmpregoConsultaState extends State<EmpregoConsulta> {
  final format = new DateFormat.yMMMd().add_Hm();
  DocumentSnapshot _currentDocument;

  String id;
  TextEditingController controllerUpdateDisp = TextEditingController();

  Slidable _buildEmprego(DocumentSnapshot doc) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      actions: <Widget>[],
      secondaryActions: <Widget>[
        IconSlideAction(
            color: corPrincipal2,
            icon: LineAwesomeIcons.edit,
            caption: "Editar",
            onTap: () {
              _currentDocument = doc;
              controllerUpdateDisp.text = doc.data['disponibilidade'];
              showDialog(
                context: context,
                builder: (BuildContext context) => Dialog(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                "Editar Notícia",
                                style: subTitulo2,
                              ),
                            ),
                            CampoTexto(
                              controller: controllerUpdateDisp,
                              icone: Icons.check,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 20, bottom: 20),
                                  child: RaisedButton(
                                    color: corPrincipal,
                                    child: Text(
                                      "Editar",
                                      style: fonteBotao,
                                    ),
                                    onPressed: () {
                                      updateData();
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 20, bottom: 20, left: 20),
                                  child: RaisedButton(
                                      color: corFundoDark,
                                      child: Text(
                                        "Cancelar",
                                        style: fonteBotao,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
        IconSlideAction(
          color: redDelete,
          icon: LineAwesomeIcons.trash_o,
          caption: "Apagar",
          onTap: () => deleteEmprego(doc),
        ),
      ],
      child: Container(
          color: corFundoLight,
          width: MediaQuery.of(context).size.width,
          child: Padding(
              padding: EdgeInsets.only(left: 20, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    doc.data['vaga'],
                    style: subTitulo4,
                  ),
                  Text(
                    doc.data['descricao'],
                    style: subTitulo4Reg,
                  ),
                  Text(
                    doc.data['local'],
                    style: subTitulo4Reg,
                  ),
                  Text(
                    doc.data['contato'],
                    style: subTitulo4Reg,
                  ),
                  Text(
                    '${formatDate(doc.data['data'].toDate(), [
                      dd,
                      '/',
                      mm,
                      '/',
                      yyyy,
                    ])}',
                    style: subTitulo4Reg,
                  ),
                  Text(
                    doc.data['fonte'],
                    style: subTitulo4Reg,
                  ),
                  doc.data['disponibilidade'] == "0"
                      ? Row(
                          children: <Widget>[
                            Icon(
                              LineAwesomeIcons.ban,
                              color: redDelete,
                              size: 18,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 4, left: 4),
                              child: Text(
                                "Indisponível",
                                style: subTitulo4RegRed,
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: <Widget>[
                            Icon(
                              LineAwesomeIcons.check,
                              color: greenAcept,
                              size: 18,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 4, left: 4),
                              child: Text(
                                "Disponível",
                                style: subTitulo4RegGreen,
                              ),
                            ),
                          ],
                        )
                ],
              ))),
    );
  }

  //______________________________________________________________________________________

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corFundo,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Text(
                  "Empregos",
                  style: tituloPrincipal,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, bottom: 20),
                child: Text("Arraste para ver as ações", style: textoPagina),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                child: BotaoRota(
                  corBotao: corPrincipal2,
                  rota: EmpregoCad(),
                  height: 45,
                  icone: LineAwesomeIcons.plus_circle,
                  texto: "Add Emprego",
                  width: 10,
                ),
              ),
// -------------------------------- Lista de Noticias --------------------------------
              StreamBuilder<QuerySnapshot>(
                stream: db
                    .collection('emprego')
                    .orderBy("data", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                        children: snapshot.data.documents
                            .map((doc) => _buildEmprego(doc))
                            .toList());
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  //______________________________________________________________________________________

  void deleteEmprego(DocumentSnapshot doc) async {
    await db.collection('emprego').document(doc.documentID).delete();

    setState(() => id = null);
    Flushbar(
      margin: EdgeInsets.all(20),
      borderRadius: 7,
      backgroundColor: greenAcept,
      title: "Emprego Apagado",
      message: "Emprego Apagado com sucesso",
      duration: Duration(seconds: 5),
    )..show(context);
  }

  //______________________________________________________________________________________

  updateData() async {
    await db
        .collection('emprego')
        .document(_currentDocument.documentID)
        .updateData({
      'disponibilidade': controllerUpdateDisp.text,
    });

    Navigator.of(context).pop();
    Flushbar(
      margin: EdgeInsets.all(20),
      borderRadius: 7,
      backgroundColor: greenAcept,
      title: "Emprego Editado",
      message: "Emprego Editado com sucesso",
      duration: Duration(seconds: 5),
    )..show(context);
  }

  //______________________________________________________________________________________

  //______________________________________________________________________________________
}
