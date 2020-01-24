import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:teste2/style/style.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:date_format/date_format.dart';
import 'package:photo_view/photo_view.dart';

class Noticias extends StatefulWidget {
  final String categoria;
  final String titulo;

  const Noticias({Key key, this.categoria, this.titulo}) : super(key: key);

  @override
  _NoticiasState createState() => _NoticiasState(categoria, titulo);
}

class _NoticiasState extends State<Noticias> {
  final db = Firestore.instance;
  final String categoria;
  final String titulo;

  _NoticiasState(this.categoria, this.titulo);

  Container buildNoticia(DocumentSnapshot doc) {
    var id = "${doc.documentID}";
    return Container(
      //color: Colors.blue,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 35, top: 30),
            child: Material(
              elevation: 5,
              shadowColor: corPrincipal2.withOpacity(0.4),
              borderRadius: BorderRadius.circular(15),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoticiasDetalhes(
                        titulo: "${doc.data['titulo']}",
                        image: "${doc.data['image']}",
                        noticia: "${doc.data['noticia']}",
                        fonte: "${doc.data['fonte']}",
                        link: "${doc.data['link']}",
                        local: "${doc.data['local']}",
                        categoria: "${doc.data['categoria']}",
                        id: "${doc.documentID}",
                        data: "${formatDate(doc.data['data'].toDate(), [
                          dd,
                          '/',
                          mm,
                          '/',
                          yyyy,
                          ' - ',
                          hh,
                          ':',
                          mm,
                          ' ',
                          am
                        ])}",
                      ),
                    ),
                  );

                  print("${doc.documentID}");
                },
                child: Container(
                  height: 230,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: CircularProgressIndicator(
                          backgroundColor: corPrincipal.withOpacity(0.7),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        height: 230,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: new BorderRadius.circular(7.0),
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: "${doc.data['image']}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        right: 0,
                        child: Hero(
                          tag: id.toString(),
                          child: Material(
                            color: Colors.transparent,
                            child: Text("${doc.data['titulo']}", style: card20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 265,
            right: 10,
            child: Hero(
              tag: (id * 2).toString(),
              child: Material(
                color: Colors.transparent,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(LineAwesomeIcons.clock_o,
                        size: 20.0, color: corFundoDark),
                    Text(
                      " ${timeago.format((doc.data['data'] as Timestamp).toDate(), locale: 'pt_BR')}",
                      style: fonteData,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('pt_BR', timeago.PtBrMessages());
    return Scaffold(
      backgroundColor: corFundo,
      body: SafeArea(
        child: Container(
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(left: 20, right: 20),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  titulo,
                  style: tituloPrincipal,
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: db
                    .collection("noticias")
                    .orderBy("data", descending: true)
                    .where("categoria", isEqualTo: categoria)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                        children: snapshot.data.documents
                            .map((doc) => buildNoticia(doc))
                            .toList());
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(15),
                        shadowColor: corPrincipal.withOpacity(0.7),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: corPrincipal.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Nenhuma notícia cadastrada..",
                                  style: subTitulo2,
                                  textAlign: TextAlign.center,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 40),
                                  child: Image.asset(
                                    "lib/style/images/erro/nenhuma-noticia.png",
                                    width: 300,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NoticiasDetalhes extends StatelessWidget {
  final String titulo;
  final String image;
  final String noticia;
  final String fonte;
  final String link;
  final String local;
  final String categoria;
  final String data;
  final String id;

  const NoticiasDetalhes(
      {Key key,
      this.titulo,
      this.image,
      this.noticia,
      this.fonte,
      this.link,
      this.local,
      this.categoria,
      this.data,
      this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corFundo,
      body: Container(
        color: corFundoLight,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.transparent,
              pinned: false,
              expandedHeight: 410.0,
              flexibleSpace: FlexibleSpaceBar(
                background: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => _PhotoViewNoticiaDetalhes(
                          image: image,
                        ),
                      ),
                    );
                  },
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Stack(
                  children: <Widget>[
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: MediaQuery.of(context).size.width * 0.4,
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Hero(
                              tag: id.toString(),
                              child: Material(
                                color: Colors.transparent,
                                child: Text(
                                  titulo,
                                  style: tituloCard,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                titlePadding: EdgeInsets.only(left: 20, bottom: 5),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    color: corFundoLight,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //data
                        Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 20),
                          child: Hero(
                            tag: (id * 2).toString(),
                            child: Material(
                              color: Colors.transparent,
                              child: Row(
                                children: <Widget>[
                                  Icon(LineAwesomeIcons.clock_o,
                                      size: 28.0, color: corFundoDark),
                                  Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Text(
                                      " " + data,
                                      style: fonteData2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        //noticia
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            noticia,
                            style: textoPagina,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.only(left: 10, top: 10),
                          child: Text(
                            'Tags',
                            style: subTitulo3,
                          ),
                        ),
                        //tag
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Row(
                            children: <Widget>[
                              Chip(
                                elevation: 3,
                                shadowColor: corPrincipal2,
                                backgroundColor: corPrincipal2,
                                labelStyle: textoPagina,
                                label: Text(
                                  local.toUpperCase(),
                                  style: fonteTag,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Chip(
                                elevation: 3,
                                backgroundColor: corSecundaria,
                                labelStyle: textoPagina,
                                label: Text(
                                  categoria.toUpperCase(),
                                  style: fonteTag,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 10, top: 20, bottom: 5),
                          child: Text("Fonte", style: subTitulo3),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 20),
                          child: Container(
                            decoration: BoxDecoration(
                                color: corPrincipal2.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(7)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                //fonte
                                Padding(
                                  padding: EdgeInsets.only(top: 15, left: 15),
                                  child: Text(fonte, style: subTitulo3),
                                ),
                                //link
                                InkWell(
                                  onTap: () async {
                                    if (await canLaunch(link)) {
                                      await launch(link);
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 15, bottom: 10, right: 15),
                                    child: Text(link, style: fonteLink),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhotoViewNoticiaDetalhes extends StatelessWidget {
  final String image;

  const _PhotoViewNoticiaDetalhes({Key key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoView(
      maxScale: PhotoViewComputedScale.contained * 4,
      minScale: PhotoViewComputedScale.contained * 1,
      imageProvider: NetworkImage(image),
    ));
  }
}
