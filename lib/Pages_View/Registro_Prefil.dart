import 'package:cjp/Model/Usuario.dart';
import 'package:cjp/Route.dart';
import 'package:cjp/WidgetCustom/TexteField/CustomTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Registro_Prefil extends StatefulWidget {
  @override
  _Registro_PrefilState createState() => _Registro_PrefilState();
}

class _Registro_PrefilState extends State<Registro_Prefil> {
  TextEditingController _controllerNomeConpleto = TextEditingController();
  TextEditingController _controllerBairro = TextEditingController();
  TextEditingController _controllerCidade = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  TextEditingController _controllerRepetirSenha = TextEditingController();
  String _mensagemDeErro = "";
  Usuario _usuario = Usuario();
  bool _verSenha = true;

  _validar() {
    String _nome = _controllerNomeConpleto.text;
    String _bairro = _controllerBairro.text;
    String _cidade = _controllerCidade.text;
    String _email = _controllerEmail.text;
    String _senha = _controllerSenha.text;
    String _repetirSenha = _controllerRepetirSenha.text;

    if (_nome.isNotEmpty &&
        _bairro.isNotEmpty &&
        _cidade.isNotEmpty &&
        _email.isNotEmpty &&
        _senha.isNotEmpty) {
      if (_senha == _repetirSenha) {
        _usuario.nome = _nome;
        _usuario.bairro = _bairro;
        _usuario.cidade = _cidade;
        _usuario.email = _email;
        _usuario.senha = _senha;
        print(_usuario.toMap());
        _cadastrarUsuario(_usuario);
      } else {
        setState(() {
          _mensagemDeErro = "Senha Invalidar";
        });
      }
    } else {
      setState(() {
        _mensagemDeErro = "Todos os campos são Obrigatorios";
      });
    }
  }

  _cadastrarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;
    print(usuario.toMap());
    print(usuario.email + usuario.senha);

    auth
        .createUserWithEmailAndPassword(
            email: _usuario.email, password: _usuario.senha)
        .then((Users) {
      usuario.id = Users.user.uid;
      db.collection("usuarios").doc(Users.user.uid).set(usuario.toMap());
      Navigator.pushNamedAndRemoveUntil(
          context, RouteGererator.rota_Home, (route) => false,
          arguments: Users.user.uid);
    }).catchError((onError) {
      print("ERRO: " + onError.toString());
      setState(() {
        _mensagemDeErro = "Desculpe ocorreu um erro na hora de ser cadastra-se";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      color: Color(0xFFF6F1CA),
      child: Center(
        child: Card(
          elevation: 3,
          child: Container(
              height: mediaQuery.size.height * (kIsWeb?0.7:0.8),
              width: 500,
              color: Colors.grey[200],
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.grey,
                      child: Center(
                        child: Text("Cadastrar-Se",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      _mensagemDeErro,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: ListView(
                      children: [
                        CustomtextField(
                          textEditingController: _controllerNomeConpleto,
                          labelText: "Nome Completo:",
                          hintText: "Ex: Joãozinho Silva Santos",
                          icon: Icon(Icons.account_box_outlined,
                              color: Colors.black),
                        ),
                        CustomtextField(
                          textEditingController: _controllerBairro,
                          labelText: "Bairro:",
                          hintText: "Ex: juquehy",
                          icon: Icon(Icons.location_city_outlined,
                              color: Colors.black),
                        ),
                        CustomtextField(
                          textEditingController: _controllerCidade,
                          labelText: "Cidade:",
                          hintText: "Ex: São Paulo",
                          icon: Icon(Icons.location_city_sharp,
                              color: Colors.black),
                        ),
                        CustomtextField(
                          textEditingController: _controllerEmail,
                          labelText: "E-Mail:",
                          hintText: "EX: exemplo@exemplo.com",
                          icon: Icon(Icons.mail_outline_sharp,
                              color: Colors.black),
                        ),
                        CustomtextField(
                          textEditingController: _controllerSenha,
                          labelText: "Senha:" ,
                          hintText: "Senha com mais de 5 caracteres",
                          icon: Icon(Icons.lock_outline, color: Colors.black),
                          obscureText: _verSenha,
                          suffix: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _verSenha = !_verSenha;
                                });
                              },
                              child: Icon(
                                _verSenha
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              )),
                        ),
                        CustomtextField(
                          textEditingController: _controllerRepetirSenha,
                          labelText: "Repetir Senha:",
                          hintText: "Repita a senha informado acima",
                          icon: Icon(
                            Icons.lock_outlined,
                            color: Colors.black,
                          ),
                          obscureText: _verSenha,
                          suffix: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _verSenha = !_verSenha;
                                });
                              },
                              child: Icon(
                                _verSenha
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 100, right: 100, bottom: kIsWeb ? 0 : 30),
                          child: RaisedButton(
                            onPressed: () => _validar(),
                            elevation: 3,
                            color: Colors.cyan,
                            padding: EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            child: Text("Entra"),
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
    );
  }
}
