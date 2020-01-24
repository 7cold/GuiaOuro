import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:teste2/admin/noticiasCad.dart';
import 'package:teste2/style/style.dart';
import 'package:date_format/date_format.dart';

import 'package:teste2/style/widget-botao.dart';

import 'package:teste2/style/widget-campo-texto.dart';
import 'package:transparent_image/transparent_image.dart';

final db = Firestore.instance;

class NoticiasConsulta extends StatefulWidget {
  @override
  NoticiasConsultaState createState() {
    return NoticiasConsultaState();
  }
}

class NoticiasConsultaState extends State<NoticiasConsulta> {
  final _formKey = GlobalKey<FormState>();
  final format = new DateFormat.yMMMd().add_Hm();
  DocumentSnapshot _currentDocument;

  String id;
  String titulo;
  String noticia;
  String fonte;
  String local;
  String categoria;
  String link;
  DateTime data;
  File _imageFile;
  StorageUploadTask uploadTask;
  StreamSubscription streamSubscription;
  String downloadUrl;
  bool loading = false;
  double _porcentagem;

  TextEditingController controllerTitulo = TextEditingController();
  TextEditingController controllerUpdateTitulo = TextEditingController();
  TextEditingController controllerNoticia = TextEditingController();
  TextEditingController controllerUpdateNoticia = TextEditingController();
  TextEditingController controllerData = TextEditingController();
  TextEditingController controllerFonte = TextEditingController();
  TextEditingController controllerLocal = TextEditingController();
  TextEditingController controllerCategoria = TextEditingController();
  TextEditingController controllerLink = TextEditingController();
  TextEditingController controllerImg = TextEditingController();

  StorageReference _reference = FirebaseStorage.instance.ref().child(
      'noticiasImagens/${Path.basename(DateTime.now().toString() + '.jpg')}');

  Future getImage() async {
    File image;

    image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = image;
    });
  }

  Future uploadImage() async {
    StorageUploadTask uploadTask = _reference.putFile(_imageFile);

    final StreamSubscription<StorageTaskEvent> streamSubscription =
        uploadTask.events.listen((event) {
      //print('EVENT ${event.type}');
      setState(() {
        loading = true;
        _porcentagem = event.snapshot.bytesTransferred.toDouble() /
            event.snapshot.totalByteCount.toDouble();

        //print(_porcentagem);
      });
    });

    await uploadTask.onComplete;

    streamSubscription.cancel();

    var downloadUrl = await _reference.getDownloadURL();

    return downloadUrl;
  }

  Slidable buildNoticias(DocumentSnapshot doc) {
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
              controllerUpdateTitulo.text = doc.data['titulo'];
              controllerUpdateNoticia.text = doc.data['noticia'];
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
                              controller: controllerUpdateTitulo,
                              icone: Icons.title,
                            ),
                            CampoTexto(
                              controller: controllerUpdateNoticia,
                              icone: Icons.dehaze,
                              maxLines: 8,
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
          onTap: () => deleteNoticias(doc),
        ),
      ],
      child: Container(
        height: 130,
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
                      image: doc.data['image'],
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        doc.data['titulo'],
                        style: subTitulo3,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        '(${formatDate(doc.data['data'].toDate(), [
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
                        ])}) - ${doc.data['noticia']}',
                        style: textoPagina2,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // Slidable buildNoticias(DocumentSnapshot doc) {
  //   return Slidable(
  //     actionPane: SlidableDrawerActionPane(),
  //     actionExtentRatio: 0.18,
  //     child: Container(
  //       child: ListTile(
  //         leading: Container(
  //           height: 100,
  //           width: 100,
  //           child: Image.network(
  //             '${doc.data['image']}',
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //         title: Text(
  //           '${doc.data['titulo']}',
  //           style: fonteBold16Titulo,
  //         ),
  //         subtitle: Text(
  //           '(${formatDate(doc.data['data'].toDate(), [
  //             dd,
  //             '/',
  //             mm,
  //             '/',
  //             yyyy,
  //             ' - ',
  //             hh,
  //             ':',
  //             mm,
  //             ' ',
  //             am
  //           ])}) - ${doc.data['noticia']}',
  //           style: fonteReg14,
  //           maxLines: 4,
  //         ),
  //       ),
  //     ),
  //     actions: <Widget>[],
  //     secondaryActions: <Widget>[
  //       IconSlideAction(
  //         color: Colors.blue,
  //         icon: Icons.edit,
  //         onTap: () async {
  //           _currentDocument = doc;
  //           controllerUpdateTitulo.text = doc.data['titulo'];
  //           controllerUpdateNoticia.text = doc.data['noticia'];

  //           showDialog(
  //             context: context,
  //             builder: (BuildContext context) => Dialog(
  //               elevation: 10,
  //               child: ResponsiveContainer(
  //                 widthPercent: 150,
  //                 heightPercent: 50,
  //                 child: Container(
  //                   child: ListView(
  //                     children: <Widget>[
  //                       Column(
  //                         children: <Widget>[
  //                           Padding(
  //                             padding: EdgeInsets.only(top: 20),
  //                             child: Text(
  //                               "Editar Notícia",
  //                               style: fonteBold24,
  //                             ),
  //                           ),
  //                           CampoTexto(
  //                             controller: controllerUpdateTitulo,
  //                             icone: Icons.title,
  //                           ),
  //                           CampoTexto(
  //                             controller: controllerUpdateNoticia,
  //                             icone: Icons.dehaze,
  //                             maxLines: 8,
  //                           ),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.center,
  //                             children: <Widget>[
  //                               Padding(
  //                                 padding: EdgeInsets.only(top: 20, bottom: 20),
  //                                 child: RaisedButton(
  //                                   color: corPrincipal,
  //                                   child: Text(
  //                                     "Editar",
  //                                     style: fonteBotao,
  //                                   ),
  //                                   onPressed: () {
  //                                     updateData();
  //                                   },
  //                                 ),
  //                               ),
  //                               Padding(
  //                                 padding: EdgeInsets.only(
  //                                     top: 20, bottom: 20, left: 20),
  //                                 child: RaisedButton(
  //                                     color: corFundoDark,
  //                                     child: Text(
  //                                       "Cancelar",
  //                                       style: fonteBotao,
  //                                     ),
  //                                     onPressed: () {
  //                                       Navigator.pop(context);
  //                                     }),
  //                               ),
  //                             ],
  //                           ),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           );
  //         },
  //       ),
  //       IconSlideAction(
  //         color: redDelete,
  //         icon: Icons.delete,
  //         onTap: () => deleteNoticias(doc),
  //       ),
  //     ],
  //   );
  // }

  //______________________________________________________________________________________

  CampoTexto textFormTitulo() {
    return CampoTexto(
      controller: controllerTitulo,
      variavel: titulo = controllerTitulo.text,
      numCaracteres: 80,
      hintText: "Título",
      icone: Icons.title,
      textInputAction: TextInputAction.done,
    );
  }

  CampoTexto textFormNoticia() {
    return CampoTexto(
      controller: controllerNoticia,
      variavel: noticia = controllerNoticia.text,
      hintText: "Texto Notícia",
      icone: Icons.dehaze,
      maxLines: 5,
      textInputAction: TextInputAction.newline,
    );
  }

  Padding textFormData() {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.all(Radius.circular(7)),
        child: Theme(
          data: Theme.of(context).copyWith(
            primaryColor: corSecundaria,
            accentColor: corPrincipal,
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.normal,
            ),
          ),
          child: DateTimeField(
              controller: controllerData,
              style: textoPaginaLight,
              format: format,
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    context: context,
                    firstDate: DateTime(2018),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2025));
              },
              decoration: InputDecoration(
                errorStyle: fonteErroInput,
                fillColor: Colors.white,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: corPrincipal, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(7.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                hintText: "Data",
                prefixIcon: Icon(
                  Icons.calendar_today,
                  size: 24,
                  color: corSecundaria,
                ),
                hintStyle: fonteCampoTextoHint,
              ),
              validator: (value) {
                if (value == null) {
                  return 'Campo Obrigatório*';
                }
              },
              onSaved: (value) => data = value),
        ),
      ),
    );
  }

  CampoTexto textFormFonte() {
    return CampoTexto(
      controller: controllerFonte,
      variavel: fonte = controllerFonte.text,
      hintText: "Fonte da Matéria",
      icone: Icons.find_in_page,
      textInputAction: TextInputAction.done,
    );
  }

  Padding textFormLocal() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
      child: Center(
        child: DropdownButtonFormField<String>(
            icon: Icon(Icons.keyboard_arrow_down),
            style: fonteCampoTexto,
            items: [
              DropdownMenuItem<String>(
                child: Text(
                  'Ouro Fino',
                ),
                value: 'Ouro Fino',
              ),
              DropdownMenuItem<String>(
                child: Text(
                  'Inconfidentes',
                ),
                value: 'Inconfidentes',
              ),
              DropdownMenuItem<String>(
                child: Text(
                  'Jacutinga',
                ),
                value: 'Jacutinga',
              ),
              DropdownMenuItem<String>(
                child: Text(
                  'Monte Sião',
                ),
                value: 'Monte Sião',
              ),
              DropdownMenuItem<String>(
                child: Text(
                  'Zona Rural',
                ),
                value: 'Zona Rural',
              ),
            ],
            onChanged: (String value) {
              setState(() {
                local = value;
              });
            },
            hint: Text('Cidade'),
            value: local,
            validator: (value) {
              if (value == null) {
                return 'Campo Obrigatório*';
              }
            },
            onSaved: (value) => local = value),
      ),
    );
  }

  Padding textFormCategoria() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
      child: Center(
        child: DropdownButtonFormField<String>(
            icon: Icon(Icons.keyboard_arrow_down),
            style: fonteCampoTexto,
            items: [
              DropdownMenuItem<String>(
                child: Text(
                  'Cidade',
                ),
                value: 'cidade',
              ),
              DropdownMenuItem<String>(
                child: Text(
                  'Cultura',
                ),
                value: 'cultura',
              ),
              DropdownMenuItem<String>(
                child: Text(
                  'Denúncia',
                ),
                value: 'denuncia',
              ),
              DropdownMenuItem<String>(
                child: Text(
                  'Economia',
                ),
                value: 'economia',
              ),
              DropdownMenuItem<String>(
                child: Text(
                  'Educação',
                ),
                value: 'educacao',
              ),
              DropdownMenuItem<String>(
                child: Text(
                  'Esporte',
                ),
                value: 'esporte',
              ),
              DropdownMenuItem<String>(
                child: Text(
                  'Polícia',
                ),
                value: 'policia',
              ),
              DropdownMenuItem<String>(
                child: Text(
                  'Política',
                ),
                value: 'politica',
              ),
              DropdownMenuItem<String>(
                child: Text(
                  'Turismo',
                ),
                value: 'turismo',
              ),
            ],
            onChanged: (String value) {
              setState(() {
                categoria = value;
              });
            },
            hint: Text('Categoria'),
            value: categoria,
            validator: (value) {
              if (value == null) {
                return 'Campo Obrigatório*';
              }
            },
            onSaved: (value) => categoria = value),
      ),
    );
  }

  CampoTexto textFormLink() {
    return CampoTexto(
      controller: controllerLink,
      variavel: link = controllerLink.text,
      hintText: "link.com",
      icone: Icons.link,
      textInputAction: TextInputAction.done,
      prefixText: "http://",
    );
  }

  Column textFormImg() {
    return Column(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: BotaoUploadImg(
              corBotao: corFundoDark,
              funcao: getImage,
              height: 50,
              icone: Icons.image,
              texto: "Selec. Imagem",
              width: 10,
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _imageFile == null
              ? Container()
              : Image.file(
                  _imageFile,
                  height: 200.0,
                  width: 200.0,
                ),
        ),
      ],
    );
  }

  //______________________________________________________________________________________

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corFundo,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Text(
                  "Noticias",
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
                  rota: NoticiasCad(),
                  height: 45,
                  icone: LineAwesomeIcons.plus_circle,
                  texto: "Add Notícia",
                  width: 10,
                ),
              ),
// -------------------------------- Lista de Noticias --------------------------------
              StreamBuilder<QuerySnapshot>(
                stream: db
                    .collection('noticias')
                    .orderBy("data", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                        children: snapshot.data.documents
                            .map((doc) => buildNoticias(doc))
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

  void deleteNoticias(DocumentSnapshot doc) async {
    await db.collection('noticias').document(doc.documentID).delete();

    setState(() => id = null);
    Flushbar(
      margin: EdgeInsets.all(20),
      borderRadius: 7,
      backgroundColor: greenAcept,
      title: "Notícia Apagada",
      message: "Notícia Apagada com sucesso",
      duration: Duration(seconds: 5),
    )..show(context);
  }

  //______________________________________________________________________________________

  updateData() async {
    await db
        .collection('noticias')
        .document(_currentDocument.documentID)
        .updateData({
      'titulo': controllerUpdateTitulo.text,
      'noticia': controllerUpdateNoticia.text
    });

    Navigator.of(context).pop();
    Flushbar(
      margin: EdgeInsets.all(20),
      borderRadius: 7,
      backgroundColor: greenAcept,
      title: "Notícia Editada",
      message: "Notícia Editada com sucesso",
      duration: Duration(seconds: 5),
    )..show(context);
  }

  //______________________________________________________________________________________

  //______________________________________________________________________________________
}
