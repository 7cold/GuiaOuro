import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:teste2/style/style.dart';
import 'package:teste2/style/widget-botao.dart';
import 'package:transparent_image/transparent_image.dart';
import 'dart:async';
import 'package:icon_shadow/icon_shadow.dart';
import 'package:date_format/date_format.dart';

final db = Firestore.instance;

class Atracoes extends StatelessWidget {
  Stack buildAtracoes(DocumentSnapshot doc, BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 10),
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(7),
            shadowColor: corPrincipal2.withOpacity(0.4),
            child: InkWell(
              onTap: () {
                var eventosChip = doc.data['eventosChip'];

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AtracoesDetalhes(
                            img: "${doc.data['img']}",
                            atracao: "${doc.data['atracao']}",
                            descricao: "${doc.data['descricao']}",
                            eventosChip: eventosChip,
                            id: doc.documentID,
                          )),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: corFundoLight,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 45),
                  child: Container(
                    decoration: BoxDecoration(
                      color: corFundoLight,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    height: 170,
                    width: double.infinity,
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              backgroundColor: corPrincipal2,
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          height: 110,
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                            borderRadius: new BorderRadius.circular(7.0),
                            child: Hero(
                              tag: "${doc.data['img']}",
                              child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: "${doc.data['img']}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          bottom: 5,
                          child: BotaoRota(
                            corBotao: corPrincipal2,
                            height: 35,
                            icone: LineAwesomeIcons.map_marker,
                            rota: GoogleMaps(
                              nomeLocal: doc['atracao'],
                              local: LatLng(doc.data['local'].latitude,
                                  doc.data['local'].longitude),
                            ),
                            texto: "Local",
                            width: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 40,
          top: 20,
          child: Hero(
            transitionOnUserGestures: true,
            tag: "${doc.data['atracao']}",
            child: Material(
              color: Colors.transparent,
              child: Text(
                "${doc.data['atracao']}",
                style: subTitulo2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corFundo,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: AnimationLimiter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: AnimationConfiguration.toStaggeredList(
                duration: Duration(milliseconds: 800),
                childAnimationBuilder: (widget) => SlideAnimation(
                  horizontalOffset: MediaQuery.of(context).size.width / 2,
                  child: FadeInAnimation(child: widget),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 20, bottom: 10),
                    child: Hero(
                      tag: "atracoes",
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          "Atrações",
                          style: tituloPrincipal,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 40, right: 20),
                    child: Text(
                      "Confira a descrição, localidade e outras informações sobre as atrações de nossa cidade.",
                      style: textoPagina,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 25, bottom: 8),
                            child: Text(
                              "Principais",
                              style: subTitulo,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, bottom: 10),
                            child: StreamBuilder<QuerySnapshot>(
                              stream: db
                                  .collection('atracoes')
                                  .where('fav', isEqualTo: 1)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return SizedBox(
                                    height: 32,
                                    width: 32,
                                    child: Chip(
                                      backgroundColor:
                                          corPrincipal2.withOpacity(0.8),
                                      label: Text(
                                        snapshot.data.documents.length
                                            .toString(),
                                        style: fonteChip,
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      _PrincipaisAtracoes()
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25, right: 25, top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Todas",
                          style: subTitulo,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: StreamBuilder<QuerySnapshot>(
                            stream: db.collection('atracoes').snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return SizedBox(
                                  width: 37,
                                  height: 38,
                                  child: Chip(
                                    backgroundColor:
                                        corPrincipal2.withOpacity(0.8),
                                    label: Text(
                                      snapshot.data.documents.length.toString(),
                                      style: fonteChip,
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: db
                        .collection("atracoes")
                        .orderBy('atracao')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: snapshot.data.documents
                              .map((doc) => buildAtracoes(doc, context))
                              .toList(),
                        );
                      } else {
                        return Container();
                      }
                    },
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

//______________________________ PRINCIPAIS ATRACAOES ___________________________

class _PrincipaisAtracoes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: StreamBuilder<QuerySnapshot>(
        stream: db
            .collection('atracoes')
            .where('fav', isEqualTo: 1)
            .orderBy('atracao')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text(
                'Carregando...',
                style: subTitulo3,
              );
            default:
              return ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        var eventosChip = document.data['eventosChip'];

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AtracoesDetalhes(
                                    img: "${document.data['img']}",
                                    atracao: "${document.data['atracao']}",
                                    descricao: "${document.data['descricao']}",
                                    eventosChip: eventosChip,
                                    id: document.documentID,
                                  )),
                        );
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 10, bottom: 20, right: 10),
                        child: Material(
                          elevation: 7,
                          shadowColor: corPrincipal2.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(7),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            width: 200,
                            child: Stack(
                              children: <Widget>[
                                Center(
                                  child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      backgroundColor: corPrincipal2,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  height: 150,
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(7.0),
                                    child: FadeInImage.memoryNetwork(
                                      placeholder: kTransparentImage,
                                      image: "${document.data['img']}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                    left: 10,
                                    bottom: 10,
                                    child: Text(
                                      "${document.data['atracao']}",
                                      style: card20,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
          }
        },
      ),
    );
  }
}

//______________________________ MAPS ___________________________________________

class GoogleMaps extends StatefulWidget {
  final String nomeLocal;
  final LatLng local;

  const GoogleMaps({Key key, this.nomeLocal, this.local}) : super(key: key);

  @override
  _GoogleMapsState createState() => _GoogleMapsState(nomeLocal, local);
}

class _GoogleMapsState extends State<GoogleMaps> {
  final String nomeLocal;
  final LatLng local;

  GoogleMapController _controller;
  bool isMapCreated = false;

  _GoogleMapsState(this.nomeLocal, this.local);

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  changeMapMode() {
    getJsonFile("lib/style/dark-map.json").then(setMapStyle);
  }

  void setMapStyle(String mapStyle) {
    _controller.setMapStyle(mapStyle);
  }

  @override
  Widget build(BuildContext context) {
    if (isMapCreated) {
      changeMapMode();
    }
    return Scaffold(
      backgroundColor: corFundo,
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
                isMapCreated = true;
                changeMapMode();
                setState(() {});
              },
              buildingsEnabled: false,
              initialCameraPosition: CameraPosition(
                target: local,
                zoom: 16,
              ),
              markers: {
                Marker(
                  markerId: MarkerId(widget.nomeLocal),
                  position: local,
                  infoWindow: InfoWindow(
                    title: nomeLocal,
                  ),
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}

//______________________________ ATRACOES DETALHES _____________________________

class AtracoesDetalhes extends StatefulWidget {
  final String img;
  final String atracao;
  final String descricao;
  final List eventosChip;
  final String id;

  AtracoesDetalhes(
      {Key key,
      this.img,
      this.atracao,
      this.descricao,
      this.eventosChip,
      this.id})
      : super(key: key);

  @override
  _AtracoesDetalhesState createState() => _AtracoesDetalhesState();
}

class _AtracoesDetalhesState extends State<AtracoesDetalhes> {
  Column buildEvento(DocumentSnapshot doc, BuildContext context) {
    if (doc.data['evento'] == 'nao apagar') {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Text(
              "Não há mais eventos",
              style: subTitulo3white,
            )),
          )
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
            child: Material(
              elevation: 3,
              shadowColor: corPrincipal.withOpacity(0.2),
              borderRadius: BorderRadius.circular(7),
              child: Container(
                decoration: BoxDecoration(
                  color: corPrincipal.withOpacity(0.9),
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "${doc.data['evento']}",
                                  style: subTitulo3white,
                                ),
                                Text(
                                  '${formatDate(doc.data['data'].toDate(), [
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
                                "${doc.data['descricao']}",
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
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corFundoLight,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Center(child: CircularProgressIndicator()),
                    Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: Hero(
                        tag: widget.img,
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: widget.img,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 50,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: IconShadowWidget(
                          Icon(
                            LineAwesomeIcons.arrow_left,
                            size: 35,
                            color: corFundoLight,
                          ),
                          shadowColor: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  color: corFundoLight,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //---------------ATRACAO--------------
                      Padding(
                        padding: EdgeInsets.only(left: 20, top: 20),
                        child: Hero(
                          transitionOnUserGestures: true,
                          tag: widget.atracao,
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              widget.atracao,
                              style: tituloPrincipal2,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 20, bottom: 30),
                          child: Text(
                            widget.descricao,
                            style: textoPagina,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, bottom: 10),
                        child: Row(
                          children: <Widget>[
                            Icon(LineAwesomeIcons.calendar_plus_o, size: 30),
                            Padding(
                              padding: EdgeInsets.only(top: 10, left: 5),
                              child: Text(
                                "Próximos Eventos",
                                style: subTitulo2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Material(
                          elevation: 3,
                          borderRadius: BorderRadius.circular(7),
                          shadowColor: corPrincipal.withOpacity(0.2),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: corPrincipal2,
                                borderRadius: BorderRadius.circular(7)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                StreamBuilder<QuerySnapshot>(
                                  stream: db
                                      .collection('atracoes')
                                      .document(widget.id)
                                      .collection('eventos')
                                      .orderBy('data', descending: true)
                                      .limit(3)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Column(
                                          children: snapshot.data.documents
                                              .map((doc) =>
                                                  buildEvento(doc, context))
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
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, top: 20),
                        child: Row(
                          children: <Widget>[
                            Icon(LineAwesomeIcons.calendar_check_o, size: 30),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(top: 10, left: 5),
                                child: Text(
                                  "Eventos que acontecem aqui",
                                  style: subTitulo2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, left: 35, bottom: 30),
                        child: Wrap(
                          spacing: 10,
                          children: widget.eventosChip
                              .map((eventos) => Chip(
                                    backgroundColor:
                                        corPrincipal.withOpacity(0.6),
                                    label: Text(
                                      eventos.toUpperCase(),
                                      style: fonteTag,
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
