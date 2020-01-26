import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:teste2/pages/noticias.dart';
import 'package:teste2/style/style.dart';

class NoticiasCategorias extends StatefulWidget {
  @override
  _NoticiasCategoriasState createState() => _NoticiasCategoriasState();
}

class _NoticiasCategoriasState extends State<NoticiasCategorias> {
  double animatedContainer = 0;

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
                children: <Widget>[
                  //texto categorias
                  Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 20, top: 20),
                    child: Text(
                      "Categorias",
                      style: tituloPrincipal,
                    ),
                  ),
                  //texto pesquisa
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      onTap: () {
                        setState(() {
                          animatedContainer = 200;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                              color: corPrincipal2,
                              borderRadius: BorderRadius.circular(10)),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                left: 20,
                                top: 13,
                                child: Text(
                                  "Pesquisa Notícia",
                                  style: subTitulo3white,
                                ),
                              ),
                              Positioned(
                                right: 20,
                                top: 13,
                                child: Icon(
                                  LineAwesomeIcons.arrow_down,
                                  color: corFundoLight,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  //expanded pesquisa
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      width: MediaQuery.of(context).size.width,
                      height: animatedContainer,
                      decoration: BoxDecoration(
                          color: corPrincipal2.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10)),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                              right: 20,
                              bottom: 10,
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  setState(() {
                                    animatedContainer = 0;
                                  });
                                },
                                child: Material(
                                  color: Colors.transparent,
                                  child: Icon(
                                    LineAwesomeIcons.arrow_up,
                                    color: corFundoDark,
                                  ),
                                ),
                              )),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 20, right: 20, top: 20),
                            child: TextField(
                              decoration: InputDecoration(
                                errorStyle: fonteErroInput,
                                fillColor: Colors.white,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: corPrincipal2, width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.0)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.0)),
                                ),
                                prefixIcon: Icon(
                                  LineAwesomeIcons.glass,
                                  color: corSecundaria,
                                ),
                                hintText: "Pesquisa",
                                hintStyle: fonteCampoTextoHint,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 100),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  _FeedCategorias(
                      "Todas as notícias",
                      'lib/style/images/noticias-categorias/todas.jpg',
                      200,
                      Noticias(
                        titulo: "Todas as Notícias",
                      )),
                  _FeedCategorias(
                    "Cidade",
                    'lib/style/images/noticias-categorias/cidade.jpg',
                    140,
                    Noticias(
                      categoria: "cidade",
                      titulo: "Cidade",
                    ),
                  ),
                  _FeedCategorias(
                    "Cultura",
                    'lib/style/images/noticias-categorias/cultura.jpg',
                    140,
                    Noticias(
                      categoria: "cultura",
                      titulo: "Cultura",
                    ),
                  ),
                  _FeedCategorias(
                    "Denúncia",
                    'lib/style/images/noticias-categorias/denuncia.jpg',
                    140,
                    Noticias(
                      categoria: "denuncia",
                      titulo: "Denúncia",
                    ),
                  ),
                  _FeedCategorias(
                    "Economia",
                    'lib/style/images/noticias-categorias/economia.jpg',
                    140,
                    Noticias(
                      categoria: "economia",
                      titulo: "Economia",
                    ),
                  ),
                  _FeedCategorias(
                    "Educação",
                    'lib/style/images/noticias-categorias/educacao.jpg',
                    140,
                    Noticias(
                      categoria: "educacao",
                      titulo: "Educação",
                    ),
                  ),
                  _FeedCategorias(
                    "Esporte",
                    'lib/style/images/noticias-categorias/esporte.jpg',
                    140,
                    Noticias(
                      categoria: "esporte",
                      titulo: "Esporte",
                    ),
                  ),
                  _FeedCategorias(
                    "Polícia",
                    'lib/style/images/noticias-categorias/policia.png',
                    140,
                    Noticias(
                      categoria: "policia",
                      titulo: "Polícia",
                    ),
                  ),
                  _FeedCategorias(
                    "Política",
                    'lib/style/images/noticias-categorias/politica.jpg',
                    140,
                    Noticias(
                      categoria: "politica",
                      titulo: "Política",
                    ),
                  ),
                  _FeedCategorias(
                    "Turismo",
                    'lib/style/images/noticias-categorias/turismo.jpg',
                    140,
                    Noticias(
                      categoria: "turismo",
                      titulo: "Turismo",
                    ),
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

//cidade, cultura, denuncia, economia, educacao, esporte, policia, politica, turismo

class _FeedCategorias extends StatelessWidget {
  final String text;
  final String image;
  final double heightPercent;
  final Object page;

  const _FeedCategorias(this.text, this.image, this.heightPercent, this.page);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 25),
      child: Container(
        height: heightPercent,
        child: Material(
          color: corFundoLight,
          elevation: 3,
          shadowColor: corPrincipal2.withOpacity(0.3),
          borderRadius: BorderRadius.circular(7),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                      left: 10,
                      bottom: 10,
                      child: Text(
                        text,
                        style: card22,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
