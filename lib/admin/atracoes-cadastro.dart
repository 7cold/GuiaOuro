import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:teste2/style/style.dart';
import 'package:teste2/style/widget-botao.dart';
import 'package:teste2/style/widget-campo-texto.dart';

final db = Firestore.instance;

class AtracoesCad extends StatefulWidget {
  final String atracao;
  final String idAtracao;

  const AtracoesCad({Key key, this.atracao, this.idAtracao}) : super(key: key);
  @override
  _AtracoesCadState createState() => _AtracoesCadState(atracao, idAtracao);
}

class _AtracoesCadState extends State<AtracoesCad> {
  final _formKey = GlobalKey<FormState>();
  final format = new DateFormat.yMMMd().add_Hm();

  final String atracao;
  final String idAtracao;

  _AtracoesCadState(this.atracao, this.idAtracao);

  String id;
  String idEvento;
  String evento;
  String descricao;
  DateTime data;

  TextEditingController controllerEvento = TextEditingController();
  TextEditingController controllerData = TextEditingController();
  TextEditingController controllerDescricao = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corFundo,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Cadastro de Evento",
                            style: subTitulo2,
                          ),
                          CampoTextoNaoObrigatorio(
                            hintText: "Nome do Evento",
                            icone: LineAwesomeIcons.pencil,
                            controller: controllerEvento,
                            variavel: evento = controllerEvento.text,
                            textCap: TextCapitalization.words,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 10, right: 10),
                            child: Material(
                              elevation: 2,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  primaryColor: corSecundaria,
                                  accentColor: corPrincipal,
                                  buttonTheme: ButtonThemeData(
                                    textTheme: ButtonTextTheme.normal,
                                  ),
                                ),
                                child: DateTimeField(
                                    style: fonteCampoTexto,
                                    format: format,
                                    onShowPicker: (context, currentValue) {
                                      return showDatePicker(
                                          context: context,
                                          firstDate: DateTime(2018),
                                          initialDate:
                                              currentValue ?? DateTime.now(),
                                          lastDate: DateTime(2025));
                                    },
                                    decoration: InputDecoration(
                                      errorStyle: fonteErroInput,
                                      fillColor: Colors.white,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: corPrincipal, width: 2.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7.0)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                      ),
                                      hintText: "Data",
                                      prefixIcon: Icon(
                                        Icons.calendar_today,
                                        size: 24,
                                        color: corSecundaria,
                                      ),
                                      hintStyle: fonteCampoTextoHint,
                                    ),
                                    onSaved: (value) => data = value),
                              ),
                            ),
                          ),
                          CampoTextoNaoObrigatorio(
                            hintText: "Descrição",
                            icone: LineAwesomeIcons.align_left,
                            controller: controllerDescricao,
                            variavel: descricao = controllerDescricao.text,
                          ),
                          Botao(
                            corBotao: corPrincipal2,
                            funcao: createEvento,
                            height: 35,
                            icone: LineAwesomeIcons.save,
                            texto: "Salvar",
                            width: 0,
                          ),
                          BotaoSingle(
                            acao: pressCancelar,
                            corBotao: redDelete.withOpacity(0.8),
                            height: 35,
                            icone: LineAwesomeIcons.times,
                            texto: "Cancelar",
                            width: 0,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void pressCancelar() {
    Navigator.pop(context);
  }

  void createEvento() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      DocumentReference ref = await db
          .collection('atracoes')
          .document(idAtracao)
          .collection('eventos')
          .add({
        'evento': '$evento',
        'descricao': controllerDescricao.text,
        'data': Timestamp.fromDate(data),
      });

      DocumentReference ref2 = await db.collection('proximosEventos').add({
        'evento': '$evento',
        'atracao': atracao,
        'descricao': controllerDescricao.text,
        'data': Timestamp.fromDate(data),
      });

      setState(() => idEvento = ref.documentID);
      setState(() => idEvento = ref2.documentID);

      print("Cadastrado com sucesso!");
      print(atracao);
      Navigator.pop(context);
      Flushbar(
        margin: EdgeInsets.all(20),
        borderRadius: 7,
        backgroundColor: greenAcept,
        title: "Cadastrado",
        message: "Evento Cadastrado com sucesso",
        duration: Duration(seconds: 5),
      )..show(context);
    }
  }
}
