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
  File _imageFile_photos1;
  File _imageFile_photos2;
  File _imageFile_photos3;
  File _imageFile_photos4;
  StorageUploadTask uploadTask;
  StorageUploadTask uploadTask_photos1;
  StorageUploadTask uploadTask_photos2;
  StorageUploadTask uploadTask_photos3;
  StorageUploadTask uploadTask_photos4;
  String downloadUrl;
  String downloadUrl_photos1;
  String downloadUrl_photos2;
  String downloadUrl_photos3;
  String downloadUrl_photos4;
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

  StorageReference _reference_photos1 = FirebaseStorage.instance.ref().child(
      'noticiasImagens/photos1-${Path.basename(DateTime.now().toString() + '.jpg')}');

  StorageReference _reference_photos2 = FirebaseStorage.instance.ref().child(
      'noticiasImagens/photos2-${Path.basename(DateTime.now().toString() + '.jpg')}');

  StorageReference _reference_photos3 = FirebaseStorage.instance.ref().child(
      'noticiasImagens/photos3-${Path.basename(DateTime.now().toString() + '.jpg')}');

  StorageReference _reference_photos4 = FirebaseStorage.instance.ref().child(
      'noticiasImagens/photos4-${Path.basename(DateTime.now().toString() + '.jpg')}');

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

//____________________________________________
  Future getImage_photos1() async {
    File image_photos1;

    image_photos1 = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile_photos1 = image_photos1;
    });
  }

  Future uploadImage_photos1() async {
    StorageUploadTask uploadTask_photos1 =
        _reference_photos1.putFile(_imageFile_photos1);

    final StreamSubscription<StorageTaskEvent> streamSubscription_photos1 =
        uploadTask_photos1.events.listen((event) {
      //print('EVENT ${event.type}');
      setState(() {
        loading = true;
        _porcentagem = event.snapshot.bytesTransferred.toDouble() /
            event.snapshot.totalByteCount.toDouble();

        //print(_porcentagem);
      });
    });

    await uploadTask_photos1.onComplete;

    streamSubscription_photos1.cancel();

    var downloadUrl_photos1 = await _reference_photos1.getDownloadURL();

    return downloadUrl_photos1;
  }

//____________________________________________

//____________________________________________
  Future getImage_photos2() async {
    File image_photos2;

    image_photos2 = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile_photos2 = image_photos2;
    });
  }

  Future uploadImage_photos2() async {
    StorageUploadTask uploadTask_photos2 =
        _reference_photos2.putFile(_imageFile_photos2);

    final StreamSubscription<StorageTaskEvent> streamSubscription_photos2 =
        uploadTask_photos2.events.listen((event) {
      //print('EVENT ${event.type}');
      // setState(() {
      //   loading = true;
      //   _porcentagem = event.snapshot.bytesTransferred.toDouble() /
      //       event.snapshot.totalByteCount.toDouble();

      //   //print(_porcentagem);
      // });
    });

    await uploadTask_photos2.onComplete;

    streamSubscription_photos2.cancel();

    var downloadUrl_photos2 = await _reference_photos2.getDownloadURL();

    return downloadUrl_photos2;
  }

//____________________________________________

//____________________________________________
  Future getImage_photos3() async {
    File image_photos3;

    image_photos3 = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile_photos3 = image_photos3;
    });
  }

  Future uploadImage_photos3() async {
    StorageUploadTask uploadTask_photos3 =
        _reference_photos3.putFile(_imageFile_photos3);

    final StreamSubscription<StorageTaskEvent> streamSubscription_photos3 =
        uploadTask_photos3.events.listen((event) {
      //print('EVENT ${event.type}');
      // setState(() {
      //   loading = true;
      //   _porcentagem = event.snapshot.bytesTransferred.toDouble() /
      //       event.snapshot.totalByteCount.toDouble();

      //   //print(_porcentagem);
      // });
    });

    await uploadTask_photos3.onComplete;

    streamSubscription_photos3.cancel();

    var downloadUrl_photos3 = await _reference_photos3.getDownloadURL();

    return downloadUrl_photos3;
  }

//____________________________________________

//____________________________________________
  Future getImage_photos4() async {
    File image_photos4;

    image_photos4 = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile_photos4 = image_photos4;
    });
  }

  Future uploadImage_photos4() async {
    StorageUploadTask uploadTask_photos4 =
        _reference_photos4.putFile(_imageFile_photos4);

    final StreamSubscription<StorageTaskEvent> streamSubscription_photos4 =
        uploadTask_photos4.events.listen((event) {
      //print('EVENT ${event.type}');
      // setState(() {
      //   loading = true;
      //   _porcentagem = event.snapshot.bytesTransferred.toDouble() /
      //       event.snapshot.totalByteCount.toDouble();

      //   //print(_porcentagem);
      // });
    });

    await uploadTask_photos4.onComplete;

    streamSubscription_photos4.cancel();

    var downloadUrl_photos4 = await _reference_photos4.getDownloadURL();

    return downloadUrl_photos4;
  }

//____________________________________________

  CampoTexto textFormTitulo() {
    return CampoTexto(
      controller: controllerTitulo,
      variavel: titulo = controllerTitulo.text,
      numCaracteres: 100,
      hintText: "Título",
      icone: LineAwesomeIcons.pencil,
      textInputAction: TextInputAction.done,
      textCap: TextCapitalization.words,
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
      textCap: TextCapitalization.words,
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
              height: 35,
              icone: Icons.image,
              texto: "Img principal",
              width: 0,
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

  BotaoUploadImg textFormImg_photos1() {
    return BotaoUploadImg(
      corBotao: corFundoDark,
      funcao: getImage_photos1,
      height: 35,
      texto: "...1",
      icone: Icons.image,
      width: 0,
    );
  }

  BotaoUploadImg textFormImg_photos2() {
    return BotaoUploadImg(
      corBotao: corFundoDark,
      funcao: getImage_photos2,
      height: 35,
      texto: "...2",
      icone: Icons.image,
      width: 0,
    );
  }

  BotaoUploadImg textFormImg_photos3() {
    return BotaoUploadImg(
      corBotao: corFundoDark,
      funcao: getImage_photos3,
      height: 35,
      texto: "...3",
      icone: Icons.image,
      width: 0,
    );
  }

  BotaoUploadImg textFormImg_photos4() {
    return BotaoUploadImg(
      corBotao: corFundoDark,
      funcao: getImage_photos4,
      height: 35,
      texto: "...4",
      icone: Icons.image,
      width: 0,
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
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: corPrincipal2.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  textFormImg_photos1(),
                                  _imageFile_photos1 == null
                                      ? Container(
                                          height: 100,
                                          width: 100,
                                        )
                                      : Image.file(
                                          _imageFile_photos1,
                                          height: 100.0,
                                          width: 100.0,
                                        ),
                                  _imageFile_photos1 != null
                                      ? Column(
                                          children: <Widget>[
                                            textFormImg_photos2(),
                                            _imageFile_photos2 == null
                                                ? Container(
                                                    height: 100,
                                                    width: 100,
                                                  )
                                                : Image.file(
                                                    _imageFile_photos2,
                                                    height: 100.0,
                                                    width: 100.0,
                                                  ),
                                          ],
                                        )
                                      : Container(
                                          height: 100,
                                          width: 100,
                                        ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: <Widget>[
                                  _imageFile_photos2 != null
                                      ? Column(
                                          children: <Widget>[
                                            textFormImg_photos3(),
                                            _imageFile_photos3 == null
                                                ? Container(
                                                    height: 100,
                                                    width: 100,
                                                  )
                                                : Image.file(
                                                    _imageFile_photos3,
                                                    height: 100.0,
                                                    width: 100.0,
                                                  ),
                                          ],
                                        )
                                      : Container(
                                          height: 100,
                                          width: 100,
                                        ),
                                  _imageFile_photos3 != null
                                      ? Column(
                                          children: <Widget>[
                                            textFormImg_photos4(),
                                            _imageFile_photos4 == null
                                                ? Container(
                                                    height: 100,
                                                    width: 100,
                                                  )
                                                : Image.file(
                                                    _imageFile_photos4,
                                                    height: 100.0,
                                                    width: 100.0,
                                                  ),
                                          ],
                                        )
                                      : Container(
                                          height: 100,
                                          width: 100,
                                        ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      loading
                          ? Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: RoundedProgressBar(
                                childCenter: Text(
                                  "Aguarde",
                                  style: subTitulo4white,
                                ),
                                percent: _porcentagem * 100,
                              ),
                            )
                          : SizedBox(),
                      Botao(
                        texto: "Salvar Notícia",
                        icone: LineAwesomeIcons.save,
                        funcao: createNoticias,
                        height: 45,
                        width: MediaQuery.of(context).size.width,
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

      _imageFile_photos1 == null
          ? downloadUrl_photos1 = "null"
          : downloadUrl_photos1 = await uploadImage_photos1();

      _imageFile_photos2 == null
          ? downloadUrl_photos2 = "null"
          : downloadUrl_photos2 = await uploadImage_photos2();

      _imageFile_photos3 == null
          ? downloadUrl_photos3 = "null"
          : downloadUrl_photos3 = await uploadImage_photos3();

      _imageFile_photos4 == null
          ? downloadUrl_photos4 = "null"
          : downloadUrl_photos4 = await uploadImage_photos4();

      DocumentReference ref = await db.collection('noticias').add({
        'titulo': '$titulo',
        'noticia': '$noticia',
        'data': Timestamp.fromDate(data),
        'fonte': '$fonte',
        'local': '$local',
        'categoria': '$categoria',
        'link': '$link',
        'image': downloadUrl.toString(),
        'photos1': downloadUrl_photos1.toString(),
        'photos2': downloadUrl_photos2.toString(),
        'photos3': downloadUrl_photos3.toString(),
        'photos4': downloadUrl_photos4.toString(),
      });

      setState(() => id = ref.documentID);
      print("Cadastrado com sucesso!");

      setState(() {
        loading = false;
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
