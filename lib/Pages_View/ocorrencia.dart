import 'dart:async';
import 'dart:io';

import 'package:cjp/BreakPoints.dart';
import 'package:cjp/Model/Ocorencias.dart';
import 'package:cjp/Model/Usuario.dart';
import 'package:cjp/WidgetCustom/AppBar/Mobile_AppBar.dart';
import 'package:cjp/WidgetCustom/AppBar/Web_AppBar.dart';
import 'package:cjp/WidgetCustom/TexteField/CustomTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Ocorrencia extends StatefulWidget {
  @override
  _OcorrenciaState createState() => _OcorrenciaState();
}

class _OcorrenciaState extends State<Ocorrencia> {
  //variaves
  TextEditingController _controllerBairro =
      TextEditingController(text: "boissucanga");
  TextEditingController _controllerRuaAv = TextEditingController();
  TextEditingController _controllerNomeOcorrencia = TextEditingController();
  TextEditingController _controllerDescricao = TextEditingController();
  String _mensagemDeErro = "";

  File _image;
  List<File> _listaDeImagens = List();
  final picker = ImagePicker();
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future _selecionarImagemGalera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future _selecionarImagemGaleria() async {
    final imagemSelecionada =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (imagemSelecionada != null) {
      setState(() {
        _listaDeImagens.add(File(imagemSelecionada.path));
      });
    }
  }

  _validarCompos() {
    String _nomeOcorencia = _controllerNomeOcorrencia.text;
    String _ruaAv = _controllerRuaAv.text;
    String _bairro = _controllerBairro.text;
    String _descricao = _controllerDescricao.text;
    Ocorrencias ocorrencia = Ocorrencias();
    if (_nomeOcorencia.isNotEmpty &&
        _ruaAv.isNotEmpty &&
        _descricao.isNotEmpty &&
        _bairro.isNotEmpty) {
      ocorrencia.nomeOcorencia = _nomeOcorencia;
      ocorrencia.id = _auth.currentUser.uid;
      ocorrencia.ruaAv = _ruaAv;
      ocorrencia.bairro = _bairro;
      ocorrencia.descricao = _descricao;
      _salvaOcorencia(ocorrencia);
    } else {
      setState(() {
        _mensagemDeErro = "Todos os Compos são obrigatorios";
      });
    }
  }

  _salvaOcorencia(Ocorrencias ocorrencia) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    db
        .collection("ocorencias")
        .doc(ocorrencia.id)
        .collection("minha_ocorrencias")
        .add(ocorrencia.toMap())
        .then((value) {
          Navigator.pop(context);
    })
        .catchError((onError) {
      print(onError.toString());
      setState(() {
        _mensagemDeErro = "Não foi possivel savar sua ocorrencia neste momento";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: Colors.grey[350],
          appBar: constraints.maxWidth < mobile_breakPoint
              ? PreferredSize(
                  preferredSize: Size(double.infinity, 56),
                  child: Mobile_AppBar_Custom())
              : PreferredSize(
                  child: Desktop_AppBar_Custom(),
                  preferredSize: Size(double.infinity, 72)),
          body: Align(
            alignment: Alignment.center,
            child: Container(
              color: Colors.grey[200],
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 900, maxHeight: 900),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 100,
                      margin: EdgeInsets.only(bottom: 30, left: 30),
                      alignment: Alignment.center,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(10),
                        scrollDirection: Axis.horizontal,
                        itemCount: _listaDeImagens.length + 1,
                        itemBuilder: (context, indice) {
                          if (indice == _listaDeImagens.length) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: GestureDetector(
                                onTap: () {
                                  _selecionarImagemGaleria();
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey[400],
                                  radius: 50,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_a_photo,
                                        size: 40,
                                        color: Colors.grey[100],
                                      ),
                                      Text(
                                        "Adicionar",
                                        style:
                                            TextStyle(color: Colors.grey[100]),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                          if (_listaDeImagens.length > 0) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.file(_listaDeImagens[indice]),
                                          FlatButton(
                                            child: Text("Excluir"),
                                            textColor: Colors.red,
                                            onPressed: () {
                                              setState(
                                                () {
                                                  _listaDeImagens
                                                      .removeAt(indice);
                                                  Navigator.of(context).pop();
                                                },
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      FileImage(_listaDeImagens[indice]),
                                  child: Container(
                                    color: Color.fromRGBO(255, 255, 255, 0.3),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.delete_forever,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                    Wrap(
                      direction: Axis.horizontal,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8.0,
                      runSpacing: 15.0,
                      children: [
                        CustomtextField(
                          textEditingController: _controllerBairro,
                          hintText: "Bairro",
                        ),
                        CustomtextField(
                          textEditingController: _controllerRuaAv,
                          hintText: "Rua/Av",
                        ),
                        CustomtextField(
                          textEditingController: _controllerNomeOcorrencia,
                          hintText: "Nome Da Ocorneica",
                        ),
                        CustomtextField(
                          textEditingController: _controllerDescricao,
                          hintText: "Descrição",
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 50,
                      height: 30,
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
                    Center(
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        padding: EdgeInsets.all(20),
                        onPressed: () => _validarCompos(),
                        child: Text("Envidar"),
                        elevation: 3,
                        color: Colors.cyanAccent[100],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
