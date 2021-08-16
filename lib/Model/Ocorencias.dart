import 'package:cjp/Firebase/Firebase_Instance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Ocorrencias {
  String _id;
  String _idUsuario;
  String _bairro;
  String _cidade;
  String _ruaAv;
  String _nomeOcorencia;
  String _descricao;
  List<String> _fotos;
  bool _visivel = true;
  String _feedback;

  Ocorrencias();

  Ocorrencias.GeraId() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference idOcorencia = db.collection("ocorrencias");
    this.id = idOcorencia.doc().id;
    this.idUsuario = IdUsuario().id();
    this.fotos = [];
  }

  Ocorrencias.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    this.id = documentSnapshot.id;
    this.idUsuario = documentSnapshot["idUsuario"];
    this.bairro = documentSnapshot["bairro"];
    this.nomeOcorencia = documentSnapshot["nomeOcorencia"];
    this.ruaAv = documentSnapshot["ruaAv"];
    this.descricao = documentSnapshot["descricao"];
    this.fotos = List<String>.from(documentSnapshot["fotos"]);
    this.visivel = documentSnapshot["visivel"];
    this.feedback = documentSnapshot["feedback"];
    this.cidade = documentSnapshot['cidade'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": this.id,
      "idUsuario": this.idUsuario,
      "bairro": this.bairro,
      "ruaAv": this.ruaAv,
      "nomeOcorencia": this.nomeOcorencia,
      "descricao": this.descricao,
      "fotos": this.fotos,
      "visivel": this.visivel,
      "cidade": this.cidade,
      "feedback": this.feedback,
    };
    return map;
  }

  String get cidade => _cidade;

  set cidade(String value) {
    _cidade = value;
  }

  String get idUsuario => _idUsuario;

  set idUsuario(String value) {
    _idUsuario = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get bairro => _bairro;

  List<String> get fotos => _fotos;

  set fotos(List<String> value) {
    _fotos = value;
  }

  String get descricao => _descricao;

  set descricao(String value) {
    _descricao = value;
  }

  String get nomeOcorencia => _nomeOcorencia;

  set nomeOcorencia(String value) {
    _nomeOcorencia = value;
  }

  String get ruaAv => _ruaAv;

  set ruaAv(String value) {
    _ruaAv = value;
  }

  set bairro(String value) {
    _bairro = value;
  }

  bool get visivel => _visivel;

  set visivel(bool value) {
    _visivel = value;
  }

  String get feedback => _feedback;

  set feedback(String value) {
    _feedback = value;
  }
}
