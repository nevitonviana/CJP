import 'package:cjp/Route.dart';
import 'package:cjp/WidgetCustom/TexteField/CustomTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  String _mensagemDeErro = "";
  List _listaBairro = List();
  bool _verSenha = true;

  _fazerLogin() async {
    var email = _controllerEmail.text;
    var password = _controllerSenha.text;
    if (email.isNotEmpty && email.contains("@")) {
      if (password.isNotEmpty && password.length > 1) {
        auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          Navigator.pushNamedAndRemoveUntil(
              context, RouteGererator.rota_Home, (route) => false);
        }).catchError((onError) {
          setState(() {
            _mensagemDeErro = "Email ou Senha invalido";
          });
        });
      } else {
        setState(() {
          _mensagemDeErro = "preencha pelo menos 6 caracteres";
        });
      }
    } else {
      setState(() {
        _mensagemDeErro = "Preencha um Email válido";
      });
    }
  }

  Future _verificarUserLogin() async {
    User userlogin = await auth.currentUser;

    if (userlogin != null) {
      //TODO verificar
      Navigator.pushNamed(context, RouteGererator.rota_Home,
          arguments: _listaBairro);
    }
  }

  @override
  void initState() {
    _verificarUserLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      color: Color(0xFFF6F1CA),
      child: Center(
        child: SingleChildScrollView(
          child: Card(
            elevation: 4,
            child: Container(
              height: mediaQuery.size.height * 0.7,
              width: 500,
              color: Colors.grey[200],
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.grey,
                      height: 80,
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                          child: Text(
                            _mensagemDeErro,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                        CustomtextField(
                          textEditingController: _controllerEmail,
                          textInputType: TextInputType.emailAddress,
                          labelText: "E-mail:",
                          hintText: "Ex:exemplo@exemplo.com",
                          icon: Icon(
                            Icons.email,
                            color: Colors.black87,
                          ),
                        ),
                        CustomtextField(
                          textEditingController: _controllerSenha,
                          labelText: "Senha:",
                          hintText: "EX:123456",
                          icon: Icon(
                            Icons.lock_outlined,
                            color: Colors.black87,
                          ),
                          obscureText: _verSenha,
                          suffix: GestureDetector(
                            onTap: () {
                              setState(
                                () {
                                  _verSenha = !_verSenha;
                                },
                              );
                            },
                            child: Icon(
                              _verSenha
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                        RaisedButton(
                          onPressed: () => _fazerLogin(),
                          elevation: 3,
                          color: Colors.cyan,
                          padding: EdgeInsets.only(
                              right: 50, left: 50, bottom: 15, top: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Text(
                            "Entrar",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, RouteGererator.rota_Registro),
                          child: Column(
                            children: [
                              Text(
                                "Cadastra-se",
                                style: TextStyle(
                                  color: Color(0xff1a1a1a),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
