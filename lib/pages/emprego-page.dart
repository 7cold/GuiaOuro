import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:teste2/style/style.dart';

final db = Firestore.instance;

Padding buildEmprego(DocumentSnapshot doc, BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10, left: 15, right: 15),
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
              doc.data['disponibilidade'] == 0
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
          ),
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
                  padding: EdgeInsets.only(left: 10, bottom: 20),
                  child: Text(
                    "Vaga de Emprego",
                    style: tituloPrincipal,
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: db.collection("emprego").snapshots(),
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
