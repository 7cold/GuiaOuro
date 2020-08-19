// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:line_awesome_icons/line_awesome_icons.dart';
// import 'package:teste2/admin/home-adm.dart';
// import 'package:teste2/style/style.dart';
// import 'package:teste2/style/widget-botao.dart';
// import 'package:teste2/style/widget-campo-texto.dart';

// final FirebaseAuth _auth = FirebaseAuth.instance;
// enum authProblems { UserNotFound, PasswordNotValid, NetworkError }

// class SignInPage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => SignInPageState();
// }

// class SignInPageState extends State<SignInPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: corFundo,
//       body: Builder(builder: (BuildContext context) {
//         return ListView(
//           physics: BouncingScrollPhysics(),
//           scrollDirection: Axis.vertical,
//           children: <Widget>[
//             _EmailPasswordForm(),
//           ],
//         );
//       }),
//     );
//   }
// }

// class _EmailPasswordForm extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _EmailPasswordFormState();
// }

// class _EmailPasswordFormState extends State<_EmailPasswordForm> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _success;
//   String _userEmail;

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.only(top: 20, bottom: 20),
//             child: Text(
//               "GuiaOuro - Login",
//               style: tituloPrincipal2,
//             ),
//           ),
//           Image.asset(
//             "lib/style/images/erro/acesso-negado.png",
//             scale: 8,
//           ),
//           Text(
//             "Acesso restrito!",
//             style: subTitulo2,
//           ),

//           //text form field email.
//           CampoTexto(
//             controller: _emailController,
//             hintText: "E-mail",
//             icone: LineAwesomeIcons.user,
//             paddingLeft: 20,
//             paddingRight: 20,
//             maxLines: 1,
//             textInputAction: TextInputAction.done,
//           ),
//           CampoTexto(
//             controller: _passwordController,
//             hintText: "Password",
//             icone: LineAwesomeIcons.key,
//             paddingLeft: 20,
//             paddingRight: 20,
//             maxLines: 1,
//             password: true,
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Text(
//             _success == null
//                 ? ''
//                 : (_success ? 'Sucesso ' + _userEmail : 'Erro de Login!'),
//             style: fonteErroInput,
//           ),
//           Botao(
//             corBotao: corPrincipal2,
//             funcao: _signInWithEmailAndPassword,
//             icone: LineAwesomeIcons.arrow_right,
//             height: 50,
//             texto: "Login",
//             width: 150,
//           ),
//         ],
//       ),
//     );
//   }

//   void _signInWithEmailAndPassword() async {
//     try {
//       FirebaseUser user = (await _auth.signInWithEmailAndPassword(
//         email: _emailController.text,
//         password: _passwordController.text,
//       ))
//           .user;
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => HomeAdm(
//             user: user,
//           ),
//         ),
//       );
//     } catch (e) {
//       authProblems errorType;
//       if (Platform.isAndroid) {
//         switch (e.message) {
//           case 'There is no user record corresponding to this identifier. The user may have been deleted.':
//             setState(() {
//               _success = false;
//             });
//             errorType = authProblems.UserNotFound;
//             break;

//           case 'The password is invalid or the user does not have a password.':
//             errorType = authProblems.PasswordNotValid;
//             setState(() {
//               _success = false;
//             });
//             break;
//           case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
//             errorType = authProblems.NetworkError;
//             setState(() {
//               _success = false;
//             });
//             break;
//           // ...
//           default:
//             print('Case ${e.message} is not yet implemented');
//             setState(() {
//               _success = false;
//             });
//         }
//       } else if (Platform.isIOS) {
//         switch (e.code) {
//           case 'Error 17011':
//             errorType = authProblems.UserNotFound;
//             setState(() {
//               _success = false;
//             });
//             break;
//           case 'Error 17009':
//             errorType = authProblems.PasswordNotValid;
//             setState(() {
//               _success = false;
//             });
//             break;
//           case 'Error 17020':
//             errorType = authProblems.NetworkError;
//             setState(() {
//               _success = false;
//             });
//             break;
//           // ...
//           default:
//             print('Case ${e.message} is not yet implemented');
//             setState(() {
//               _success = false;
//             });
//         }
//       }
//       print('The error is $errorType');
//       setState(() {
//         _success = false;
//       });
//     }
//   }
// }
