import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:teste2/style/style.dart';
import 'package:teste2/style/widget-botao.dart';
import 'package:teste2/style/widget-campo-texto.dart';

final db = Firestore.instance;

class EmpregoCad extends StatefulWidget {
  @override
  _EmpregoCadState createState() => _EmpregoCadState();
}

class _EmpregoCadState extends State<EmpregoCad> {
  final _formKey = GlobalKey<FormState>();

  String idEmprego;
  String vaga;
  String descricao;
  String local;
  String contato;
  String fonte;
  String disponilidade;

  TextEditingController controllerVaga = TextEditingController();
  TextEditingController controllerDescricao = TextEditingController();
  TextEditingController controllerLocal = TextEditingController();
  TextEditingController controllerContato = TextEditingController();
  TextEditingController controllerFonte = TextEditingController();
  TextEditingController controllerDisponibilidade = TextEditingController();

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
                            "Cadastro de Emprego",
                            style: subTitulo2,
                          ),
                          CampoTextoNaoObrigatorio(
                            hintText: "Vaga",
                            icone: LineAwesomeIcons.pencil,
                            controller: controllerVaga,
                            variavel: vaga = controllerVaga.text,
                            textCap: TextCapitalization.words,
                          ),
                          CampoTextoNaoObrigatorio(
                            hintText: "Descrição",
                            icone: LineAwesomeIcons.align_left,
                            controller: controllerDescricao,
                            variavel: descricao = controllerDescricao.text,
                          ),
                          CampoTextoNaoObrigatorio(
                            hintText: "Local",
                            icone: LineAwesomeIcons.pencil,
                            controller: controllerLocal,
                            variavel: local = controllerLocal.text,
                            textCap: TextCapitalization.words,
                          ),
                          CampoTextoNaoObrigatorio(
                            hintText: "Contato",
                            icone: LineAwesomeIcons.pencil,
                            controller: controllerContato,
                            variavel: contato = controllerContato.text,
                            textCap: TextCapitalization.words,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 30, right: 30),
                            child: Center(
                              child: DropdownButtonFormField<String>(
                                  icon: Icon(Icons.keyboard_arrow_down),
                                  style: fonteCampoTexto,
                                  items: [
                                    DropdownMenuItem<String>(
                                      child: Text(
                                        'Observatório de Ouro Fino',
                                      ),
                                      value: "Observatório de Ouro Fino",
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text(
                                        'Difusora Ouro Fino',
                                      ),
                                      value: "Difurosa Ouro FIno",
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
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 30, right: 30),
                            child: Center(
                              child: DropdownButtonFormField<String>(
                                  icon: Icon(Icons.keyboard_arrow_down),
                                  style: fonteCampoTexto,
                                  items: [
                                    DropdownMenuItem<String>(
                                      child: Text(
                                        'Disponível',
                                      ),
                                      value: "1",
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text(
                                        'Indisponível',
                                      ),
                                      value: "0",
                                    ),
                                  ],
                                  onChanged: (String value) {
                                    setState(() {
                                      disponilidade = value;
                                    });
                                  },
                                  hint: Text('Disponível?'),
                                  value: disponilidade,
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Campo Obrigatório*';
                                    }
                                  },
                                  onSaved: (value) => disponilidade = value),
                            ),
                          ),
                          Botao(
                            corBotao: corPrincipal2,
                            funcao: createEmprego,
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

  void createEmprego() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      DocumentReference ref = await db.collection('emprego').add({
        'vaga': controllerVaga.text,
        'descricao': controllerDescricao.text,
        'local': controllerLocal.text,
        'contato': controllerContato.text,
        'fonte': '$fonte',
        'disponibilidade': '$disponilidade',
      });

      setState(() => idEmprego = ref.documentID);

      print("Cadastrado com sucesso!");
      Navigator.pop(context);
      Flushbar(
        margin: EdgeInsets.all(20),
        borderRadius: 7,
        backgroundColor: greenAcept,
        title: "Cadastrado",
        message: "Emprego Cadastrado com sucesso",
        duration: Duration(seconds: 5),
      )..show(context);
    }
  }
}
