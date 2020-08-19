// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
// import 'package:flushbar/flushbar.dart';
// import 'package:flutter/material.dart';
// import 'package:line_awesome_icons/line_awesome_icons.dart';
// import 'package:teste2/style/style.dart';
// import 'package:intl/intl.dart';
// import 'package:teste2/style/widget-botao.dart';
// import 'package:teste2/style/widget-campo-texto.dart';

// final db = Firestore.instance;

// class EmpregoCad extends StatefulWidget {
//   @override
//   _EmpregoCadState createState() => _EmpregoCadState();
// }

// class _EmpregoCadState extends State<EmpregoCad> {
//   final _formKey = GlobalKey<FormState>();
//   final format = new DateFormat.yMMMd().add_Hm();

//   String idEmprego;
//   String vaga;
//   String descricao;
//   String local;
//   String contato;
//   String fonte;
//   DateTime data;
//   String disponilidade;

//   TextEditingController controllerVaga = TextEditingController();
//   TextEditingController controllerDescricao = TextEditingController();
//   TextEditingController controllerLocal = TextEditingController();
//   TextEditingController controllerContato = TextEditingController();
//   TextEditingController controllerFonte = TextEditingController();
//   TextEditingController controllerData = TextEditingController();
//   TextEditingController controllerDisponibilidade = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: corFundo,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           physics: BouncingScrollPhysics(),
//           child: Column(
//             children: <Widget>[
//               Container(
//                 height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.width,
//                 child: SingleChildScrollView(
//                   physics: BouncingScrollPhysics(),
//                   child: Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: Form(
//                       key: _formKey,
//                       child: Column(
//                         children: <Widget>[
//                           Text(
//                             "Cadastro de Emprego",
//                             style: subTitulo2,
//                           ),
//                           CampoTextoNaoObrigatorio(
//                             hintText: "Vaga",
//                             icone: LineAwesomeIcons.pencil,
//                             controller: controllerVaga,
//                             variavel: vaga = controllerVaga.text,
//                             textCap: TextCapitalization.words,
//                             textInputAction: TextInputAction.done,
//                           ),
//                           CampoTextoNaoObrigatorio(
//                             hintText: "Descrição",
//                             icone: LineAwesomeIcons.align_left,
//                             controller: controllerDescricao,
//                             variavel: descricao = controllerDescricao.text,
//                           ),
//                           CampoTextoNaoObrigatorio(
//                             hintText: "Local",
//                             icone: LineAwesomeIcons.map_marker,
//                             controller: controllerLocal,
//                             variavel: local = controllerLocal.text,
//                             textCap: TextCapitalization.words,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(top: 5),
//                             child: Text(
//                               "Valor Padrão: Não Informado.",
//                               style: fonteLabel,
//                             ),
//                           ),
//                           CampoTextoNaoObrigatorio(
//                             hintText: "Contato",
//                             icone: LineAwesomeIcons.user,
//                             controller: controllerContato,
//                             variavel: contato = controllerContato.text,
//                             textCap: TextCapitalization.words,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(top: 5),
//                             child: Text(
//                               "Valor Padrão: (xx) xxxxx-xxxx",
//                               style: fonteLabel,
//                             ),
//                           ),
//                           Padding(
//                             padding:
//                                 EdgeInsets.only(top: 20, left: 10, right: 10),
//                             child: Material(
//                               elevation: 2,
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(7)),
//                               child: Theme(
//                                 data: Theme.of(context).copyWith(
//                                   primaryColor: corSecundaria,
//                                   accentColor: corPrincipal,
//                                   buttonTheme: ButtonThemeData(
//                                     textTheme: ButtonTextTheme.normal,
//                                   ),
//                                 ),
//                                 child: DateTimeField(
//                                     controller: controllerData,
//                                     style: fonteCampoTexto,
//                                     format: format,
//                                     onShowPicker: (context, currentValue) {
//                                       return showDatePicker(
//                                           context: context,
//                                           firstDate: DateTime(2018),
//                                           initialDate:
//                                               currentValue ?? DateTime.now(),
//                                           lastDate: DateTime(2025));
//                                     },
//                                     decoration: InputDecoration(
//                                       errorStyle: fonteErroInput,
//                                       fillColor: Colors.white,
//                                       filled: true,
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: corPrincipal, width: 2.0),
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(7.0)),
//                                       ),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: Colors.transparent,
//                                             width: 1),
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(15.0)),
//                                       ),
//                                       hintText: "Data",
//                                       prefixIcon: Icon(
//                                         LineAwesomeIcons.calendar_check_o,
//                                         size: 24,
//                                         color: corSecundaria,
//                                       ),
//                                       hintStyle: fonteCampoTextoHint,
//                                     ),
//                                     validator: (value) {
//                                       if (value == null) {
//                                         return 'Campo Obrigatório*';
//                                       }
//                                     },
//                                     onSaved: (value) => data = value),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(
//                                 top: 20, left: 30, right: 30),
//                             child: Center(
//                               child: DropdownButtonFormField<String>(
//                                   icon: Icon(Icons.keyboard_arrow_down),
//                                   style: fonteCampoTexto,
//                                   items: [
//                                     DropdownMenuItem<String>(
//                                       child: Text(
//                                         'Observatório de Ouro Fino',
//                                       ),
//                                       value: "Observatório de Ouro Fino",
//                                     ),
//                                     DropdownMenuItem<String>(
//                                       child: Text(
//                                         'Difusora Ouro Fino',
//                                       ),
//                                       value: "Difusora Ouro Fino",
//                                     ),
//                                   ],
//                                   onChanged: (String value) {
//                                     setState(() {
//                                       fonte = value;
//                                     });
//                                   },
//                                   hint: Text('Fonte'),
//                                   value: fonte,
//                                   validator: (value) {
//                                     if (value == null) {
//                                       return 'Campo Obrigatório*';
//                                     }
//                                   },
//                                   onSaved: (value) => fonte = value),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(
//                                 top: 20, left: 30, right: 30),
//                             child: Center(
//                               child: DropdownButtonFormField<String>(
//                                   icon: Icon(Icons.keyboard_arrow_down),
//                                   style: fonteCampoTexto,
//                                   items: [
//                                     DropdownMenuItem<String>(
//                                       child: Text(
//                                         'Sim',
//                                       ),
//                                       value: "1",
//                                     ),
//                                     DropdownMenuItem<String>(
//                                       child: Text(
//                                         'Não',
//                                       ),
//                                       value: "0",
//                                     ),
//                                   ],
//                                   onChanged: (String value) {
//                                     setState(() {
//                                       disponilidade = value;
//                                     });
//                                   },
//                                   hint: Text('Disponível?'),
//                                   value: disponilidade,
//                                   validator: (value) {
//                                     if (value == null) {
//                                       return 'Campo Obrigatório*';
//                                     }
//                                   },
//                                   onSaved: (value) => disponilidade = value),
//                             ),
//                           ),
//                           Botao(
//                             corBotao: corPrincipal2,
//                             funcao: createEmprego,
//                             height: 35,
//                             icone: LineAwesomeIcons.save,
//                             texto: "Salvar",
//                             width: 0,
//                           ),
//                           BotaoSingle(
//                             acao: pressCancelar,
//                             corBotao: redDelete.withOpacity(0.8),
//                             height: 35,
//                             icone: LineAwesomeIcons.times,
//                             texto: "Cancelar",
//                             width: 0,
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void pressCancelar() {
//     Navigator.pop(context);
//   }

//   void createEmprego() async {
//     if (_formKey.currentState.validate()) {
//       _formKey.currentState.save();

//       DocumentReference ref = await db.collection('emprego').add({
//         'vaga': controllerVaga.text,
//         'descricao': controllerDescricao.text,
//         'local':
//             controllerLocal.text == "" ? "Não Informado" : controllerLocal.text,
//         'contato': controllerContato.text == ""
//             ? "(xx) xxxxx-xxxx"
//             : controllerContato.text,
//         'fonte': '$fonte',
//         'data': Timestamp.fromDate(data),
//         'disponibilidade': '$disponilidade',
//       });

//       setState(() => idEmprego = ref.documentID);

//       print("Cadastrado com sucesso!");
//       Navigator.pop(context);
//       Flushbar(
//         margin: EdgeInsets.all(20),
//         borderRadius: 7,
//         backgroundColor: greenAcept,
//         title: "Cadastrado",
//         message: "Emprego Cadastrado com sucesso",
//         duration: Duration(seconds: 5),
//       )..show(context);
//     }
//   }
// }
