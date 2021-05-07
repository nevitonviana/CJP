import 'package:cjp/Model/Usuario.dart';
import 'package:cjp/Route.dart';
import 'package:cjp/WidgetCustom/TexteField/CustomTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
          context, RouteGererator.rota_Home, (route) => false, arguments: _usuario);
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
                      child: Center(
                        child: Text("Cadastrar-se",
                            style:
                                TextStyle(color: Colors.black, fontSize: 20)),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomtextField(
                          textEditingController: _controllerNomeConpleto,
                          hintText: "Nome Completo",
                          icon: Icon(Icons.account_box_outlined),
                        ),
                        CustomtextField(
                          textEditingController: _controllerBairro,
                          hintText: "Bairro",
                          icon: Icon(Icons.location_city_outlined),
                        ),
                        CustomtextField(
                          textEditingController: _controllerCidade,
                          hintText: "Cidade",
                          icon: Icon(Icons.location_city_sharp),
                        ),
                        CustomtextField(
                          textEditingController: _controllerEmail,
                          hintText: "E-Mail",
                          icon: Icon(Icons.mail_outline_sharp),
                        ),
                        CustomtextField(
                          textEditingController: _controllerSenha,
                          hintText: "Senha:",
                          icon: Icon(Icons.lock_outline),
                        ),
                        CustomtextField(
                          textEditingController: _controllerRepetirSenha,
                          hintText: "Senha",
                          icon: Icon(Icons.lock_outlined),
                        ),
                        RaisedButton(
                          onPressed: () => _validar(),
                          elevation: 3,
                          color: Colors.cyan,
                          padding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Text("Entra"),
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
