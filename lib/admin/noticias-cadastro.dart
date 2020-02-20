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
  String youtube;
  DateTime data;
  File imageFile;
  File imageFilePhotos1;
  File imageFilePhotos2;
  File imageFilePhotos3;
  File imageFilePhotos4;
  StorageUploadTask uploadTask;
  StorageUploadTask uploadTaskPhotos1;
  StorageUploadTask uploadTaskPhotos2;
  StorageUploadTask uploadTaskPhotos3;
  StorageUploadTask uploadTaskPhotos4;
  String downloadUrl;
  String downloadUrlPhotos1;
  String downloadUrlPhotos2;
  String downloadUrlPhotos3;
  String downloadUrlPhotos4;
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
  TextEditingController controllerYoutube = TextEditingController();
  TextEditingController controllerImg = TextEditingController();

  StorageReference reference = FirebaseStorage.instance.ref().child(
      'noticiasImagens/${Path.basename(DateTime.now().toString() + '.jpg')}');

  StorageReference referencePhotos1 = FirebaseStorage.instance.ref().child(
      'noticiasImagens/photos1-${Path.basename(DateTime.now().toString() + '.jpg')}');

  StorageReference referencePhotos2 = FirebaseStorage.instance.ref().child(
      'noticiasImagens/photos2-${Path.basename(DateTime.now().toString() + '.jpg')}');

  StorageReference referencePhotos3 = FirebaseStorage.instance.ref().child(
      'noticiasImagens/photos3-${Path.basename(DateTime.now().toString() + '.jpg')}');

  StorageReference referencePhotos4 = FirebaseStorage.instance.ref().child(
      'noticiasImagens/photos4-${Path.basename(DateTime.now().toString() + '.jpg')}');

  Future getImage() async {
    File image;

    image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageFile = image;
    });
  }

  Future uploadImage() async {
    StorageUploadTask uploadTask = reference.putFile(imageFile);

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

    var downloadUrl = await reference.getDownloadURL();

    return downloadUrl;
  }

//____________________________________________
  Future getImagePhotos1() async {
    File imagePhotos1;

    imagePhotos1 = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageFilePhotos1 = imagePhotos1;
    });
  }

  Future uploadImagePhotos1() async {
    StorageUploadTask uploadTaskPhotos1 =
        referencePhotos1.putFile(imageFilePhotos1);

    final StreamSubscription<StorageTaskEvent> streamSubscriptionPhotos1 =
        uploadTaskPhotos1.events.listen((event) {
      //print('EVENT ${event.type}');
      setState(() {
        loading = true;
        _porcentagem = event.snapshot.bytesTransferred.toDouble() /
            event.snapshot.totalByteCount.toDouble();

        //print(_porcentagem);
      });
    });

    await uploadTaskPhotos1.onComplete;

    streamSubscriptionPhotos1.cancel();

    var downloadUrlPhotos1 = await referencePhotos1.getDownloadURL();

    return downloadUrlPhotos1;
  }

//____________________________________________

//____________________________________________
  Future getImagePhotos2() async {
    File imagePhotos2;

    imagePhotos2 = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageFilePhotos2 = imagePhotos2;
    });
  }

  Future uploadImagePhotos2() async {
    StorageUploadTask uploadTaskPhotos2 =
        referencePhotos2.putFile(imageFilePhotos2);

    final StreamSubscription<StorageTaskEvent> streamSubscriptionPhotos2 =
        uploadTaskPhotos2.events.listen((event) {
      //print('EVENT ${event.type}');
      // setState(() {
      //   loading = true;
      //   _porcentagem = event.snapshot.bytesTransferred.toDouble() /
      //       event.snapshot.totalByteCount.toDouble();

      //   //print(_porcentagem);
      // });
    });

    await uploadTaskPhotos2.onComplete;

    streamSubscriptionPhotos2.cancel();

    var downloadUrlPhotos2 = await referencePhotos2.getDownloadURL();

    return downloadUrlPhotos2;
  }

//____________________________________________

//____________________________________________
  Future getImagePhotos3() async {
    File imagePhotos3;

    imagePhotos3 = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageFilePhotos3 = imagePhotos3;
    });
  }

  Future uploadImagePhotos3() async {
    StorageUploadTask uploadTaskPhotos3 =
        referencePhotos3.putFile(imageFilePhotos3);

    final StreamSubscription<StorageTaskEvent> streamSubscriptionPhotos3 =
        uploadTaskPhotos3.events.listen((event) {
      //print('EVENT ${event.type}');
      // setState(() {
      //   loading = true;
      //   _porcentagem = event.snapshot.bytesTransferred.toDouble() /
      //       event.snapshot.totalByteCount.toDouble();

      //   //print(_porcentagem);
      // });
    });

    await uploadTaskPhotos3.onComplete;

    streamSubscriptionPhotos3.cancel();

    var downloadUrlPhotos3 = await referencePhotos3.getDownloadURL();

    return downloadUrlPhotos3;
  }

//____________________________________________

//____________________________________________
  Future getImagePhotos4() async {
    File imagePhotos4;

    imagePhotos4 = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageFilePhotos4 = imagePhotos4;
    });
  }

  Future uploadImagePhotos4() async {
    StorageUploadTask uploadTaskPhotos4 =
        referencePhotos4.putFile(imageFilePhotos4);

    final StreamSubscription<StorageTaskEvent> streamSubscriptionPhotos4 =
        uploadTaskPhotos4.events.listen((event) {
      //print('EVENT ${event.type}');
      // setState(() {
      //   loading = true;
      //   _porcentagem = event.snapshot.bytesTransferred.toDouble() /
      //       event.snapshot.totalByteCount.toDouble();

      //   //print(_porcentagem);
      // });
    });

    await uploadTaskPhotos4.onComplete;

    streamSubscriptionPhotos4.cancel();

    var downloadUrlPhotos4 = await referencePhotos4.getDownloadURL();

    return downloadUrlPhotos4;
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

  // CampoTexto textFormFonte() {
  //   return CampoTexto(
  //     controller: controllerFonte,
  //     variavel: fonte = controllerFonte.text,
  //     hintText: "Fonte da Matéria",
  //     icone: LineAwesomeIcons.search,
  //     textInputAction: TextInputAction.done,
  //     textCap: TextCapitalization.words,
  //   );
  // }

  Padding textFormFonte() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
      child: Center(
        child: DropdownButtonFormField<String>(
            icon: Icon(Icons.keyboard_arrow_down),
            style: fonteCampoTexto,
            items: [
              DropdownMenuItem<String>(
                child: Text(
                  'Observatório de Ouro Fino',
                ),
                value: 'Observatório de Ouro Fino',
              ),
              DropdownMenuItem<String>(
                child: Text(
                  'Difusora Ouro Fino',
                ),
                value: 'Difusora Ouro Fino',
              ),
              DropdownMenuItem<String>(
                child: Text(
                  'Jornal Folha de Ouro',
                ),
                value: 'Jornal Folha de Ouro',
              ),
              DropdownMenuItem<String>(
                child: Text(
                  'G1 Sul de Minas',
                ),
                value: 'G1 Sul de Minas',
              ),
              DropdownMenuItem<String>(
                child: Text(
                  'Tonogiro',
                ),
                value: 'Tonogiro',
              ),
            ],
            onChanged: (String value) {
              setState(() {
                fonte = value;
              });
            },
            hint: Text('Fonte'),
            value: fonte,
            validator: (value) {
              if (value == null) {
                return 'Campo Obrigatório*';
              }
            },
            onSaved: (value) => fonte = value),
      ),
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
                  'Borda da Mata',
                ),
                value: 'Borda da Mata',
              ),
              DropdownMenuItem<String>(
                child: Text(
                  'Bueno Brandão',
                ),
                value: 'Bueno Brandão',
              ),
              DropdownMenuItem<String>(
                child: Text(
                  'Andradas',
                ),
                value: 'Andradas',
              ),
              DropdownMenuItem<String>(
                child: Text(
                  'Pouso Alegre',
                ),
                value: 'Pouso Alegre',
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

  CampoTextoNaoObrigatorio textFormLink() {
    return CampoTextoNaoObrigatorio(
      controller: controllerLink,
      variavel: link = controllerLink.text,
      hintText: "link.com",
      icone: LineAwesomeIcons.link,
      textInputAction: TextInputAction.done,
    );
  }

  CampoTexto textFormYoutube() {
    return CampoTexto(
      controller: controllerYoutube,
      variavel: youtube = controllerLink.text,
      hintText: "Link Video Youtube",
      icone: LineAwesomeIcons.youtube,
      textInputAction: TextInputAction.done,
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
          child: imageFile == null
              ? Container()
              : Image.file(
                  imageFile,
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
      funcao: getImagePhotos1,
      height: 35,
      texto: "...1",
      icone: Icons.image,
      width: 0,
    );
  }

  BotaoUploadImg textFormImg_photos2() {
    return BotaoUploadImg(
      corBotao: corFundoDark,
      funcao: getImagePhotos2,
      height: 35,
      texto: "...2",
      icone: Icons.image,
      width: 0,
    );
  }

  BotaoUploadImg textFormImg_photos3() {
    return BotaoUploadImg(
      corBotao: corFundoDark,
      funcao: getImagePhotos3,
      height: 35,
      texto: "...3",
      icone: Icons.image,
      width: 0,
    );
  }

  BotaoUploadImg textFormImg_photos4() {
    return BotaoUploadImg(
      corBotao: corFundoDark,
      funcao: getImagePhotos4,
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
          physics: BouncingScrollPhysics(),
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
                      textFormYoutube(),
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
                                  imageFilePhotos1 == null
                                      ? Container(
                                          height: 100,
                                          width: 100,
                                        )
                                      : Image.file(
                                          imageFilePhotos1,
                                          height: 100.0,
                                          width: 100.0,
                                        ),
                                  imageFilePhotos1 != null
                                      ? Column(
                                          children: <Widget>[
                                            textFormImg_photos2(),
                                            imageFilePhotos2 == null
                                                ? Container(
                                                    height: 100,
                                                    width: 100,
                                                  )
                                                : Image.file(
                                                    imageFilePhotos2,
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
                                  imageFilePhotos2 != null
                                      ? Column(
                                          children: <Widget>[
                                            textFormImg_photos3(),
                                            imageFilePhotos3 == null
                                                ? Container(
                                                    height: 100,
                                                    width: 100,
                                                  )
                                                : Image.file(
                                                    imageFilePhotos3,
                                                    height: 100.0,
                                                    width: 100.0,
                                                  ),
                                          ],
                                        )
                                      : Container(
                                          height: 100,
                                          width: 100,
                                        ),
                                  imageFilePhotos3 != null
                                      ? Column(
                                          children: <Widget>[
                                            textFormImg_photos4(),
                                            imageFilePhotos4 == null
                                                ? Container(
                                                    height: 100,
                                                    width: 100,
                                                  )
                                                : Image.file(
                                                    imageFilePhotos4,
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

      imageFilePhotos1 == null
          ? downloadUrlPhotos1 = "null"
          : downloadUrlPhotos1 = await uploadImagePhotos1();

      imageFilePhotos2 == null
          ? downloadUrlPhotos2 = "null"
          : downloadUrlPhotos2 = await uploadImagePhotos2();

      imageFilePhotos3 == null
          ? downloadUrlPhotos3 = "null"
          : downloadUrlPhotos3 = await uploadImagePhotos3();

      imageFilePhotos4 == null
          ? downloadUrlPhotos4 = "null"
          : downloadUrlPhotos4 = await uploadImagePhotos4();

      DocumentReference ref = await db.collection('noticias').add({
        'titulo': '$titulo',
        'noticia': '$noticia',
        'data': Timestamp.fromDate(data),
        'fonte': '$fonte',
        'local': '$local',
        'categoria': '$categoria',
        'link': '$link',
        'youtube': '$youtube',
        'image': downloadUrl.toString(),
        'photos1': downloadUrlPhotos1.toString(),
        'photos2': downloadUrlPhotos2.toString(),
        'photos3': downloadUrlPhotos3.toString(),
        'photos4': downloadUrlPhotos4.toString(),
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
