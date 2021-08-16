import 'dart:async';
import 'dart:io';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cjp/BreakPoints.dart';
import 'package:cjp/Firebase/Firebase_Instance.dart';
import 'package:cjp/Model/Ocorencias.dart';
import 'package:cjp/Route.dart';
import 'package:cjp/WidgetCustom/AppBar/Mobile_AppBar.dart';
import 'package:cjp/WidgetCustom/AppBar/Web_AppBar.dart';
import 'package:cjp/WidgetCustom/TexteField/CustomTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: camel_case_types, must_be_immutable
class Adicionar_Ocorrencia extends StatefulWidget {
  Ocorrencias ocorrencias;

  Adicionar_Ocorrencia({this.ocorrencias});

  @override
  _Adicionar_OcorrenciaState createState() => _Adicionar_OcorrenciaState();
}

// ignore: camel_case_types
class _Adicionar_OcorrenciaState extends State<Adicionar_Ocorrencia> {
  //variaves
  TextEditingController _controllerBairro =
      TextEditingController(text: "boissucanga");
  TextEditingController _controllerRuaAv = TextEditingController();
  TextEditingController _controllerNomeOcorrencia = TextEditingController();
  TextEditingController _controllerDescricao = TextEditingController();
  String _mensagemDeErro = "";

  // ignore: deprecated_member_use
  List<dynamic> _listaDeImagens = List();
  final picker = ImagePicker();
  Ocorrencias ocorrencia;
  FirebaseFirestore db = FirebaseFirestore.instance;
  BuildContext _dialogContext;

  Future _selecionarImagemGaleria() async {
    File _image;
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print("456" + _image.toString());
        _listaDeImagens.add(_image);
      } else {
        print('No image selected.');
      }
    });
  }

  _validarCompos() async {
    var _cidade = await getDoUsuario().Cidade();
    String _nomeOcorencia = _controllerNomeOcorrencia.text;
    String _ruaAv = _controllerRuaAv.text;
    String _bairro = _controllerBairro.text;
    String _descricao = _controllerDescricao.text;
    if (_nomeOcorencia.isNotEmpty &&
        _ruaAv.isNotEmpty &&
        _descricao.isNotEmpty &&
        _bairro.isNotEmpty &&
        _listaDeImagens.isNotEmpty) {
      ocorrencia.nomeOcorencia = _nomeOcorencia;
      ocorrencia.ruaAv = _ruaAv;
      ocorrencia.bairro = _bairro;
      ocorrencia.descricao = _descricao;
      ocorrencia.feedback = "";
      ocorrencia.cidade = _cidade;
      _uploadDasImagens();
    } else {
      setState(() {
        _mensagemDeErro = "Todos os Compos são obrigatorios";
      });
    }
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
                  child: Text("Salvando Ocorrência.."),
                )
              ],
            ),
          );
        });
  }

  Future _uploadDasImagens() async {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference pastaRaiz = firebaseStorage.ref();
    _abriDialog(_dialogContext);
    for (var _imagem in _listaDeImagens) {
      String _nomeDaImagem = DateTime.now().millisecondsSinceEpoch.toString();
      Reference arquivo =
          pastaRaiz.child("imagens").child(ocorrencia.id).child(_nomeDaImagem);
      UploadTask uploadTask = arquivo.putFile(_imagem);
      uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
        if (taskSnapshot.state == TaskState.success) {}
      });
      final get = await uploadTask.whenComplete(() {});
      String url = await get.ref.getDownloadURL();
      ocorrencia.fotos.add(url);
    }
    _salvaOcorencia();
  }

  _salvaOcorencia() async {
    db
        .collection("ocorrencias")
        .doc(ocorrencia.id)
        .set(ocorrencia.toMap())
        .then((value) {
      Navigator.pop(_dialogContext);
      Navigator.pushReplacementNamed(context, RouteGererator.rota_Home);
    }).catchError((onError) {
      print(onError.toString());
      setState(() {
        _mensagemDeErro =
            "Não foi possivel salvar sua ocorrencia neste momento";
      });
    });
  }

  _getEUpedatDeOcorrecia() {
    if (widget.ocorrencias != null) {
      _controllerDescricao.text = widget.ocorrencias.descricao;
      _controllerBairro.text = widget.ocorrencias.bairro;
      _controllerNomeOcorrencia.text = widget.ocorrencias.nomeOcorencia;
      _controllerRuaAv.text = widget.ocorrencias.ruaAv;
      _getListaDeImagens();
    }
  }

  List _getListaDeImagens() {
    List<String> listadeUrlDeimagens = widget.ocorrencias.fotos;
    return listadeUrlDeimagens.map((url) {
      return Container(
        height: 250,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: NetworkImage(url), fit: BoxFit.contain)),
      );
    }).toList();
  }

  _atualizarAnuncio() {
    _abriDialog(_dialogContext);
    widget.ocorrencias.bairro = _controllerBairro.text;
    widget.ocorrencias.ruaAv = _controllerRuaAv.text;
    widget.ocorrencias.descricao = _controllerDescricao.text;
    widget.ocorrencias.nomeOcorencia = _controllerNomeOcorrencia.text;
    db
        .collection("ocorrencias")
        .doc(widget.ocorrencias.id)
        .set(widget.ocorrencias.toMap())
        .then((value) {
      Navigator.pop(_dialogContext);
      Navigator.pop(context);
    }).catchError((onError) {
      print(onError.toString());
      setState(() {
        _mensagemDeErro = "Não foi possivel savar sua ocorrencia neste momento";
      });
    });
  }

  @override
  void initState() {
    ocorrencia = Ocorrencias.GeraId();
    super.initState();
    _getEUpedatDeOcorrecia();
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
                color: Colors.grey[200],
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 900, maxHeight: 900),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          height: 120,
                          margin:
                              EdgeInsets.only(bottom: 30, left: 20, top: 50),
                          alignment: Alignment.center,
                          child: widget.ocorrencias != null
                              ? Carousel(
                                  dotColor: Colors.white,
                                  images: _getListaDeImagens(),
                                  boxFit: BoxFit.cover,
                                  dotBgColor: Colors.white24,
                                  dotIncreasedColor: Colors.grey,
                                )
                              : ListView.builder(
                                  padding: const EdgeInsets.all(10),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _listaDeImagens.length + 1,
                                  itemBuilder: (context, indice) {
                                    if (indice == _listaDeImagens.length) {
                                      return Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        child: GestureDetector(
                                          onTap: () {
                                            _selecionarImagemGaleria();
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: Colors.grey[400],
                                            radius: 75,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.add_a_photo,
                                                  size: 40,
                                                  color: Colors.grey[100],
                                                ),
                                                Text(
                                                  "Adicionar",
                                                  style: TextStyle(
                                                      color: Colors.grey[100]),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    if (_listaDeImagens.length > 0) {
                                      return Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        child: GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => Dialog(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Image.file(_listaDeImagens[
                                                        indice]),
                                                    // ignore: deprecated_member_use
                                                    FlatButton(
                                                      child: Text("Excluir"),
                                                      textColor: Colors.red,
                                                      onPressed: () {
                                                        setState(
                                                          () {
                                                            _listaDeImagens
                                                                .removeAt(
                                                                    indice);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
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
                                            radius: 75,
                                            backgroundImage: FileImage(
                                                _listaDeImagens[indice]),
                                            child: Container(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.3),
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
                                )),
                      Wrap(
                        direction: Axis.horizontal,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8.0,
                        runSpacing: 15.0,
                        children: [
                          CustomtextField(
                            textEditingController: _controllerBairro,
                            labelText: "Bairro",
                            hintText: "Ex: juquehy",
                            textStyle: TextStyle(color: Colors.black),
                          ),
                          CustomtextField(
                            textEditingController: _controllerRuaAv,
                            labelText: "Rua/Av",
                            hintText: "Ex: Rua: Exemplo ou AV: Exemplo",
                          ),
                          CustomtextField(
                            textEditingController: _controllerNomeOcorrencia,
                            labelText: "Nome Da Ocorrência",
                            hintText: "Ex: Buraco na Estrada ",
                          ),
                          CustomtextField(
                            textEditingController: _controllerDescricao,
                            labelText: "Descrição",
                            hintText: "Descreva o ocorrido na Rua/AV",
                            maxLines: null,
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: Center(
                          // ignore: deprecated_member_use
                          child: RaisedButton(
                            padding: EdgeInsets.only(
                                left: 30, right: 30, bottom: 20, top: 20),
                            onPressed: () {
                              _dialogContext = context;
                              widget.ocorrencias != null
                                  ? _atualizarAnuncio()
                                  : _validarCompos();
                            },
                            child: Text(
                              widget.ocorrencias != null
                                  ? "Atualizar"
                                  : "Envidar",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            elevation: 3,
                            color: Colors.cyanAccent[100],
                          ),
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
