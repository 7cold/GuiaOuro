import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:teste2/style/style.dart';

final db = Firestore.instance;

Padding buildEmprego(DocumentSnapshot doc, BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(bottom: 15, left: 15, right: 15),
    child: Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      shadowColor: corPrincipal2.withOpacity(0.5),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Stack(children: [
            Positioned(
              right: 10,
              bottom: 2,
              child: "${doc.data['fonte']}" == "Observatório de Ouro Fino"
                  ? Image.asset(
                      'lib/style/images/icones_fonte/observatorio.png',
                      height: 20,
                    )
                  : "${doc.data['fonte']}" == "Difusora Ouro Fino"
                      ? Image.asset(
                          'lib/style/images/icones_fonte/difusora.png',
                          height: 18,
                        )
                      : "${doc.data['fonte']}" == "Tonogiro"
                          ? Image.asset(
                              'lib/style/images/icones_fonte/tonogiro.png',
                              height: 30,
                            )
                          : "${doc.data['fonte']}" == "Jornal Folha de Ouro"
                              ? Image.asset(
                                  'lib/style/images/icones_fonte/folhadeouro.png',
                                  height: 20,
                                )
                              : "${doc.data['fonte']}" == "G1 Sul de Minas"
                                  ? Image.asset(
                                      'lib/style/images/icones_fonte/g1.png',
                                      height: 20,
                                    )
                                  : SizedBox(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 6),
                  child: Text(
                    doc.data['vaga'],
                    style: subTitulo4,
                  ),
                ),
                Text(
                  "Descrição: ",
                  style: subTitulo4,
                ),
                Text(
                  doc.data['descricao'],
                  style: subTitulo4Reg,
                ),
                Text(
                  "Local: ",
                  style: subTitulo4,
                ),
                Text(
                  doc.data['local'],
                  style: subTitulo4Reg,
                ),
                Text(
                  "Contato: ",
                  style: subTitulo4,
                ),
                Text(
                  doc.data['contato'],
                  style: subTitulo4Reg,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Cadastrado: ",
                      style: subTitulo4,
                    ),
                    Text(
                      '${formatDate(doc.data['data'].toDate(), [
                        dd,
                        '/',
                        mm,
                        '/',
                        yyyy,
                      ])}',
                      style: subTitulo4,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: doc.data['disponibilidade'] == "0"
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
                        ),
                )
              ],
            ),
          ]),
        ),
      ),
    ),
  );
}

class Emprego extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corFundo,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 20, top: 20),
                  child: Hero(
                    tag: "emprego",
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        "Vagas de Emprego",
                        style: tituloPrincipal,
                      ),
                    ),
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: db
                      .collection("emprego")
                      .orderBy("data", descending: true)
                      .limit(20)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: snapshot.data.documents
                            .map((doc) => buildEmprego(doc, context))
                            .toList(),
                      );
                    } else {
                      return Text("");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
