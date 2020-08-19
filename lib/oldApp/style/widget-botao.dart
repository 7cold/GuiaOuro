// import 'package:flutter/material.dart';
// import 'package:teste2/style/style.dart';
// import 'package:teste2/style/widget-efeito-rota.dart';

// class Botao extends StatelessWidget {
//   final String texto;
//   final IconData icone;
//   final Function funcao;
//   final double height;
//   final double width;
//   final Color corBotao;

//   const Botao(
//       {Key key,
//       this.texto,
//       this.icone,
//       this.funcao,
//       this.height,
//       this.width,
//       this.corBotao})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(10),
//       child: ButtonTheme(
//         height: height,
//         minWidth: width,
//         child: RaisedButton.icon(
//           highlightElevation: 3,
//           color: corBotao,
//           elevation: 0,
//           icon: Icon(icone),
//           label: Padding(
//             padding: EdgeInsets.only(top: 5),
//             child: Text(
//               texto,
//               style: fonteBotao,
//             ),
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: new BorderRadius.circular(5.0),
//           ),
//           textColor: corFundoLight,
//           onPressed: () {
//             funcao();
//           },
//         ),
//       ),
//     );
//   }
// }

// class BotaoUploadImg extends StatelessWidget {
//   final String texto;
//   final IconData icone;
//   final Function funcao;
//   final double height;
//   final double width;
//   final Color corBotao;

//   const BotaoUploadImg(
//       {Key key,
//       this.texto = "",
//       this.icone,
//       this.funcao,
//       this.height,
//       this.width,
//       this.corBotao})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ButtonTheme(
//       height: height,
//       minWidth: width,
//       child: RaisedButton.icon(
//         highlightElevation: 3,
//         color: corPrincipal2,
//         elevation: 0,
//         icon: Icon(icone),
//         label: Text(
//           texto,
//           style: fonteBotao,
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: new BorderRadius.circular(5.0),
//         ),
//         textColor: corFundoLight,
//         onPressed: () {
//           funcao();
//         },
//       ),
//     );
//   }
// }

// class BotaoRota extends StatelessWidget {
//   final String texto;
//   final IconData icone;
//   final Widget rota;
//   final double height;
//   final double width;
//   final Color corBotao;

//   const BotaoRota(
//       {Key key,
//       this.texto,
//       this.icone,
//       this.rota,
//       this.height,
//       this.width,
//       this.corBotao})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ButtonTheme(
//       height: height,
//       minWidth: width,
//       child: RaisedButton.icon(
//         highlightElevation: 3,
//         color: corPrincipal2,
//         elevation: 0,
//         icon: Icon(icone),
//         label: Padding(
//           padding: EdgeInsets.only(top: 5),
//           child: Text(
//             texto,
//             style: fonteBotao,
//           ),
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(5.0),
//         ),
//         textColor: corFundoLight,
//         onPressed: () {
//           Navigator.push(
//             context,
//             ScaleRoute(
//               page: rota,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class BotaoSingle extends StatelessWidget {
//   final String texto;
//   final IconData icone;
//   final double height;
//   final double width;
//   final Color corBotao;
//   final Function acao;

//   const BotaoSingle(
//       {Key key,
//       this.texto,
//       this.icone,
//       this.height,
//       this.width,
//       this.corBotao,
//       this.acao})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ButtonTheme(
//       height: height,
//       minWidth: width,
//       child: RaisedButton.icon(
//         onPressed: acao,
//         highlightElevation: 3,
//         color: corBotao,
//         elevation: 0,
//         icon: Icon(
//           icone,
//           color: corFundoLight,
//         ),
//         label: Padding(
//           padding: EdgeInsets.only(top: 5),
//           child: Text(
//             texto,
//             style: fonteBotao,
//           ),
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(5.0),
//         ),
//         textColor: corFundoLight,
//       ),
//     );
//   }
// }
