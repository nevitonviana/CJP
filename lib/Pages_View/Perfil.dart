import 'dart:io';
import 'package:cjp/BreakPoints.dart';
import 'package:cjp/Firebase/Firebase_Instance.dart';
import 'package:cjp/Model/Usuario.dart';
import 'package:cjp/Route.dart';
import 'package:cjp/WidgetCustom/AppBar/Mobile_AppBar.dart';
import 'package:cjp/WidgetCustom/AppBar/Web_AppBar.dart';
import 'package:cjp/WidgetCustom/TexteField/CustomTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: camel_case_types
class Meu_Perfil extends StatefulWidget {
  @override
  _Meu_PerfilState createState() => _Meu_PerfilState();
}

class _Meu_PerfilState extends State<Meu_Perfil> {
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerCidade = TextEditingController();
  TextEditingController _controllerBairro = TextEditingController();
  String _mensagemDeErro = "";
  File imagem;
  Usuario _usuario;
  FirebaseFirestore db = FirebaseFirestore.instance;
  String _fotoUrl;
  String _email;
  BuildContext _dialogContext;

  _getDadosDoUsuario() async {
    DocumentSnapshot documentSnapshot =
        await db.collection("usuarios").doc(IdUsuario().id()).get();
    var dados = documentSnapshot.data();
    setState(() {
      _usuario = Usuario.fromDocumentSnapshot(documentSnapshot);
      _controllerNome.text = dados["nome"];
      _controllerCidade.text = dados["cidade"];
      _controllerBairro.text = dados["bairro"];
      _fotoUrl = dados['fotoPerfil'];
      _email = dados['email'];
    });
  }

  Future _selecionarImagemGaleria() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        imagem = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future _uploadDasImagens() async {
    _abriDialog(_dialogContext);
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference pastaRaiz = firebaseStorage.ref();
    Reference arquivo =
        pastaRaiz.child("Foto_De_Perfil").child(IdUsuario().id());
    UploadTask uploadTask = arquivo.putFile(imagem);
    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
      if (taskSnapshot.state == TaskState.success) {}
    });
    final get = await uploadTask.whenComplete(() {});
    String url = await get.ref.getDownloadURL();
    _usuario.fotoPerfil = url;
    _Salvar();
  }

  _Salvar() {
    _usuario.bairro = _controllerBairro.text;
    _usuario.cidade = _controllerCidade.text;
    _usuario.nome = _controllerNome.text;
    _usuario.email = _email;
    imagem != null
        ? _usuario.fotoPerfil = _usuario.fotoPerfil
        : _usuario.fotoPerfil = _fotoUrl;
    db
        .collection("usuarios")
        .doc(IdUsuario().id())
        .set(_usuario.toMap())
        .then((value) {
      Navigator.pop(_dialogContext);
    }).catchError((erro) {});
    Navigator.pushReplacementNamed(context, RouteGererator.rota_Home);
  }

  _abriDialog(BuildContext buildContext) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 6,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator.adaptive(),
                SizedBox(
                  height: 20,
                  child: Text("Atualizando Perfil.."),
                )
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    _getDadosDoUsuario();
    super.initState();
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
          body: SingleChildScrollView(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.only(bottom: 35),
                color: Colors.grey[200],
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 900, maxHeight: 900),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(top: 35),
                                child: Text(
                                  "Foto de Perfil",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: 15),
                                )),
                            Container(
                              height: 250,
                              margin: EdgeInsets.only(
                                bottom: 30,
                              ),
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () => _selecionarImagemGaleria(),
                                child: imagem != null
                                    ? CircleAvatar(
                                        radius: 100,
                                        backgroundImage: FileImage(imagem),
                                      )
                                    : _fotoUrl != null
                                        ? CircleAvatar(
                                            radius: 100,
                                            backgroundImage:
                                                NetworkImage(_fotoUrl))
                                        : CircleAvatar(
                                            backgroundColor: Colors.grey,
                                            radius: 100,
                                            child: Icon(
                                              Icons.image,
                                              size: 35,
                                            ),
                                          ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Wrap(
                        direction: Axis.horizontal,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8.0,
                        runSpacing: 15.0,
                        children: [
                          CustomtextField(
                            textEditingController: _controllerNome,
                            labelText: "Nome",
                          ),
                          CustomtextField(
                            textEditingController: _controllerCidade,
                            labelText: "Cidade",
                          ),
                          CustomtextField(
                            textEditingController: _controllerBairro,
                            labelText: "Bairro",
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
                          onPressed: () {
                            _dialogContext = context;
                            imagem != null ? _uploadDasImagens() : _Salvar();
                          },
                          child: Text("Atualizar"),
                          elevation: 3,
                          color: Colors.cyanAccent[100],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
