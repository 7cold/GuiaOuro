import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:teste2/style/style.dart';
import 'package:teste2/style/widget-animator.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:date_format/date_format.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

BannerAd myBanner;
Firestore db = Firestore.instance;

class Noticias extends StatefulWidget {
  @override
  _NoticiasState createState() => _NoticiasState();
}

class _NoticiasState extends State<Noticias> {
  final String todasNoticias =
      'lib/style/images/noticias-categorias/todas-noticias.svg';

  List<DocumentSnapshot> noticias = [];

  bool isLoading = false;

  bool hasMore = true;

  int documentLimit = 5;

  DocumentSnapshot lastDocument;

  ScrollController _scrollController = ScrollController();

  getNoticias() async {
    if (!hasMore) {
      print('No More Noticias');
      return;
    }
    if (isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    QuerySnapshot querySnapshot;
    if (lastDocument == null) {
      querySnapshot = await db
          .collection('noticias')
          .orderBy('data', descending: true)
          .limit(documentLimit)
          .getDocuments();
    } else {
      querySnapshot = await db
          .collection('noticias')
          .orderBy('data', descending: true)
          .startAfterDocument(lastDocument)
          .limit(documentLimit)
          .getDocuments();
      print(1);
    }
    if (querySnapshot.documents.length < documentLimit) {
      hasMore = false;
    }
    lastDocument = querySnapshot.documents[querySnapshot.documents.length - 1];
    noticias.addAll(querySnapshot.documents);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getNoticias();

    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.25;

      if (maxScroll - currentScroll <= delta) {
        getNoticias();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corFundo,
      body: Column(children: [
        Stack(
          children: <Widget>[
            Material(
              color: Colors.transparent,
              shadowColor: corPrincipal2,
              elevation: 3,
              borderRadius: BorderRadius.circular(14),
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(14),
                      bottomRight: Radius.circular(14)),
                  child: SvgPicture.asset(
                    todasNoticias,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 15,
              bottom: 5,
              child: Text(
                "Notícias",
                style: tituloPrincipal2white,
              ),
            ),
          ],
        ),
        Expanded(
          child: noticias.length == 0
              ? Center(
                  //child: Text('No Data...'),
                  )
              : WidgetANimator(
                  ListView.builder(
                    physics: BouncingScrollPhysics(),
                    controller: _scrollController,
                    itemCount: noticias.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Stack(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: 35, top: 10, left: 20, right: 20),
                              child: Material(
                                elevation: 5,
                                shadowColor: corPrincipal2.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(7),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NoticiasDetalhes(
                                          titulo:
                                              "${noticias[index].data['titulo']}",
                                          image:
                                              "${noticias[index].data['image']}",
                                          photos1:
                                              "${noticias[index].data['photos1']}",
                                          photos2:
                                              "${noticias[index].data['photos2']}",
                                          photos3:
                                              "${noticias[index].data['photos3']}",
                                          photos4:
                                              "${noticias[index].data['photos4']}",
                                          noticia:
                                              "${noticias[index].data['noticia']}",
                                          fonte:
                                              "${noticias[index].data['fonte']}",
                                          link:
                                              "${noticias[index].data['link']}",
                                          local:
                                              "${noticias[index].data['local']}",
                                          categoria:
                                              "${noticias[index].data['categoria']}",
                                          id: "${noticias[index].documentID}",
                                          data:
                                              "${formatDate(noticias[index].data['data'].toDate(), [
                                            dd,
                                            '/',
                                            mm,
                                            '/',
                                            yyyy,
                                          ])}",
                                          youtube:
                                              "${noticias[index].data['youtube']}",
                                        ),
                                      ),
                                    );

                                    print("${noticias[index].documentID}");
                                  },
                                  child: Container(
                                    height: 220,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Stack(
                                      children: <Widget>[
                                        Center(
                                          child: CircularProgressIndicator(
                                            backgroundColor: corPrincipal2,
                                            strokeWidth: 2,
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          height: 230,
                                          width: double.infinity,
                                          child: ClipRRect(
                                            borderRadius:
                                                new BorderRadius.circular(7.0),
                                            child: FadeInImage.memoryNetwork(
                                              placeholder: kTransparentImage,
                                              image:
                                                  "${noticias[index].data['image']}",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 10,
                                          left: 10,
                                          right: 10,
                                          child: Hero(
                                            tag: "${noticias[index].documentID}"
                                                .toString(),
                                            child: Material(
                                              color: Colors.transparent,
                                              child: Text(
                                                  "${noticias[index].data['titulo']}",
                                                  style: card20),
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
                              top: 235,
                              right: 20,
                              child: Hero(
                                tag: ("${noticias[index].documentID}" * 2)
                                    .toString(),
                                child: Material(
                                  color: Colors.transparent,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(LineAwesomeIcons.clock_o,
                                          size: 20.0, color: corFundoDark),
                                      Text(
                                        " ${timeago.format((noticias[index].data['data'] as Timestamp).toDate(), locale: 'pt_BR')}",
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
                    },
                  ),
                ),
        ),
        isLoading
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: corPrincipal2,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          backgroundColor: corPrincipal2,
                          strokeWidth: 1.5,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Carregando...',
                        textAlign: TextAlign.center,
                        style: subTitulo4white,
                      ),
                    ],
                  ),
                ),
              )
            : Container()
      ]),
    );
  }
}

class NoticiasDetalhes extends StatefulWidget {
  final String titulo;
  final String image;
  final String photos1;
  final String photos2;
  final String photos3;
  final String photos4;
  final String noticia;
  final String fonte;
  final String link;
  final String youtube;
  final String local;
  final String categoria;
  final String data;
  final String id;

  NoticiasDetalhes(
      {Key key,
      this.titulo,
      this.image,
      this.noticia,
      this.fonte,
      this.link,
      this.local,
      this.categoria,
      this.data,
      this.id,
      this.photos1,
      this.photos2,
      this.photos3,
      this.photos4,
      this.youtube})
      : super(key: key);

  @override
  _NoticiasDetalhesState createState() => _NoticiasDetalhesState();
}

class _NoticiasDetalhesState extends State<NoticiasDetalhes> {
  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['games', 'pubg'],
    contentUrl: 'https://flutter.io',
    childDirected: false,
    testDevices: <String>[],
  );

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: "ca-app-pub-6292126127383705/2058165781",
        //Change BannerAd adUnitId with Admob ID
        size: AdSize.smartBanner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd $event");
        });
  }

  @override
  void initState() {
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-6292126127383705~4656408966");
    //Change appId With Admob Id
    myBanner = createBannerAd()
      ..load()
      ..show();

    super.initState();
  }

  @override
  void dispose() {
    myBanner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String videoID = YoutubePlayer.convertUrlToId(widget.youtube);
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
                          image: widget.image,
                        ),
                      ),
                    );
                  },
                  child: Image.network(
                    widget.image,
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
                              tag: widget.id.toString(),
                              child: Material(
                                color: Colors.transparent,
                                child: Text(
                                  widget.titulo,
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
                            tag: (widget.id * 2).toString(),
                            child: Material(
                              color: Colors.transparent,
                              child: Row(
                                children: <Widget>[
                                  Icon(LineAwesomeIcons.clock_o,
                                      size: 28.0, color: corFundoDark),
                                  Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Text(
                                      " " + widget.data,
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
                            widget.noticia,
                            style: textoPagina,
                            textAlign: TextAlign.justify,
                          ),
                        ),

                        SizedBox(height: 20),

                        _GaleriaPhotos(context),

                        videoID != null
                            ? YoutubePlayer(
                                controller: YoutubePlayerController(
                                  initialVideoId: videoID,
                                  flags: YoutubePlayerFlags(
                                    autoPlay: false,
                                  ),
                                ),
                                showVideoProgressIndicator: true,
                              )
                            : SizedBox(),

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
                          child: Wrap(
                            children: <Widget>[
                              Chip(
                                elevation: 3,
                                shadowColor: corPrincipal2,
                                backgroundColor: corPrincipal2,
                                labelStyle: textoPagina,
                                label: Text(
                                  widget.local.toUpperCase(),
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
                                  widget.categoria.toUpperCase(),
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
                              EdgeInsets.only(left: 10, right: 10, bottom: 90),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: corPrincipal2.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(7)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                //fonte
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 15,
                                    left: 15,
                                  ),
                                  child: Text(widget.fonte, style: subTitulo3),
                                ),
                                //link
                                InkWell(
                                  onTap: () async {
                                    if (await canLaunch(widget.link)) {
                                      await launch(widget.link);
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 15, bottom: 10, right: 15),
                                    child: Text(widget.link, style: fonteLink),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _GaleriaPhotos(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: Column(
            children: <Widget>[
              widget.photos1 != "null"
                  ? Material(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => _PhotoViewNoticiaDetalhes(
                                image: widget.photos1,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width / 2.3,
                          child: ClipRRect(
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: "${widget.photos1}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
              Padding(padding: EdgeInsets.only(top: 5)),
              widget.photos2 != "null"
                  ? Material(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => _PhotoViewNoticiaDetalhes(
                                image: widget.photos2,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width / 2.3,
                          child: ClipRRect(
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: "${widget.photos2}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: Column(
            children: <Widget>[
              widget.photos3 != "null"
                  ? Material(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => _PhotoViewNoticiaDetalhes(
                                image: widget.photos3,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width / 2.3,
                          child: ClipRRect(
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: "${widget.photos3}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
              Padding(padding: EdgeInsets.only(top: 5)),
              widget.photos4 != "null"
                  ? Material(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => _PhotoViewNoticiaDetalhes(
                                image: widget.photos4,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width / 2.3,
                          child: ClipRRect(
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: "${widget.photos4}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ],
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
