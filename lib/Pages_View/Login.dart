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

  _fazerLogin() async {
    var email = _controllerEmail.text;
    var password = _controllerSenha.text;
    if (email.isNotEmpty && email.contains("@")) {
      if (password.isNotEmpty && password.length > 1) {
        auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          Navigator.pushNamed(context, RouteGererator.rota_Home);
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
      Navigator.pushNamed(context, RouteGererator.rota_Home);
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
        child: Card(
          elevation: 4,
          child: SingleChildScrollView(
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
                        child: Text("Login", style: TextStyle(color: Colors.black, fontSize: 20),),
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
                          hintText: "Usuario",
                          icon: Icon(Icons.account_circle),
                        ),
                        CustomtextField(
                          textEditingController: _controllerSenha,
                          hintText: "Senha",
                          icon: Icon(Icons.lock_outlined),
                        ),
                        RaisedButton(
                          onPressed: () => _fazerLogin(),
                          elevation: 3,
                          color: Colors.cyan,
                          padding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Text("Entra"),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, RouteGererator.rota_Registro),
                          child: Text("Cadastra-se"),
                        )
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
