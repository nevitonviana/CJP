class Ocorrencias {
  String _id;
  String _bairro;
  String _ruaAv;
  String _nomeOcorencia;
  String _descricao;
  List<String> _fotos;
  String _visivel = "false";

  Ocorrencias();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": this.id,
      "bairro": this.bairro,
      "ruaAv": this.ruaAv,
      "nomeOcorencia": this.nomeOcorencia,
      "descricao": this.descricao,
      "fotos": this.fotos,
      "visivel": this.visivel,
    };
    return map;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get bairro => _bairro;

  String get visivel => _visivel;

  set visivel(String value) {
    _visivel = value;
  }

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
}
