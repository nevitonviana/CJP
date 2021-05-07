class Usuario {
  String _id;

  String _nome;
  String _bairro;
  String _cidade;
  String _email;
  String _senha;
  String _repetirsenha;

  Usuario();

  String get repetirsenha => _repetirsenha;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": this.id,
      "nome": this.nome,
      "email": this.email,
      "bairro": this.bairro,
      "cidade": this.cidade,
    };
    return map;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  set repetirsenha(String value) {
    _repetirsenha = value;
  }

  String get senha => _senha;

  set senha(String value) {
    _senha = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get cidade => _cidade;

  set cidade(String value) {
    _cidade = value;
  }

  String get bairro => _bairro;

  set bairro(String value) {
    _bairro = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }
}
