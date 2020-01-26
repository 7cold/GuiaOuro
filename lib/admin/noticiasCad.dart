import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:path/path.dart' as Path;
import 'package:teste2/style/style.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:teste2/style/widget-botao.dart';
import 'package:teste2/style/widget-campo-texto.dart';

final db = Firestore.instance;

class NoticiasCad extends StatefulWidget {
  @override
  _NoticiasCadState createState() => _NoticiasCadState();
}

class _NoticiasCadState extends State<NoticiasCad> {
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

  CampoTexto textFormTitulo() {
    return CampoTexto(
      controller: controllerTitulo,
      variavel: titulo = controllerTitulo.text,
      numCaracteres: 80,
      hintText: "Título",
      icone: LineAwesomeIcons.pencil,
      textInputAction: TextInputAction.done,
    );
  }

  CampoTexto textFormNoticia() {
    return CampoTexto(
      controller: controllerNoticia,
      variavel: noticia = controllerNoticia.text,
      hintText: "Texto Notícia",
      icone: LineAwesomeIcons.align_left,
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
              style: fonteCampoTexto,
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
                  LineAwesomeIcons.calendar_check_o,
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
      icone: LineAwesomeIcons.search,
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
      icone: LineAwesomeIcons.link,
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
              height: 45,
              icone: Icons.image,
              texto: "Selec. Imagem",
              width: 200,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corFundo,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 10, left: 10),
                        child: Text(
                          "Cadastro de Notícias",
                          style: tituloPrincipal,
                        ),
                      ),
                      textFormTitulo(),
                      textFormNoticia(),
                      textFormData(),
                      textFormLocal(),
                      textFormCategoria(),
                      textFormFonte(),
                      textFormLink(),
                      textFormImg(),
                      loading
                          ? Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: RoundedProgressBar(
                                percent: _porcentagem * 100,
                              ),
                            )
                          : SizedBox(),
                      Botao(
                        texto: "Criar Notícia",
                        icone: LineAwesomeIcons.save,
                        funcao: createNoticias,
                        height: 45,
                        width: 200,
                        corBotao: corPrincipal2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  //______________________________________________________________________________________

  void createNoticias() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      downloadUrl = await uploadImage();

      DocumentReference ref = await db.collection('noticias').add({
        'titulo': '$titulo',
        'noticia': '$noticia',
        'data': Timestamp.fromDate(data),
        'fonte': '$fonte',
        'local': '$local',
        'categoria': '$categoria',
        'link': '$link',
        'image': downloadUrl.toString(),
      });

      setState(() => id = ref.documentID);
      print("Cadastrado com sucesso!");
      setState(() {
        loading = false;
        controllerTitulo.clear();
        controllerNoticia.clear();
        controllerData.clear();
        controllerFonte.clear();
        controllerLink.clear();
        _imageFile = null;
      });

      Navigator.pop(context);

      Flushbar(
        margin: EdgeInsets.all(20),
        borderRadius: 7,
        backgroundColor: greenAcept,
        title: "Cadastrado",
        message: "Notícia Cadastrada com sucesso",
        duration: Duration(seconds: 5),
      )..show(context);
    }
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
  }
}
