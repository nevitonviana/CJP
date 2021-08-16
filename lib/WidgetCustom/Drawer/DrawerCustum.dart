import 'package:cjp/Firebase/Firebase_Instance.dart';
import 'package:cjp/Route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DraerCustom extends StatefulWidget {
  var constraints;

  DraerCustom(this.constraints);

  @override
  _DraerCustomState createState() => _DraerCustomState();
}

class _DraerCustomState extends State<DraerCustom> {
  String _fotoDeperfil = "";
  String _nomeusuario = "";
  bool _Admin = false;

  _deslogar() {
    UsuarioAutentica.Deslogar();
    Navigator.pushReplacementNamed(context, RouteGererator.rota_Login);
  }

  _getfotoDeperfil() async {
    var foto = await getDoUsuario().Foto();
    setState(() {
      _fotoDeperfil = foto;
    });
  }

  _getNomeDOUsuario() async {
    var nome = await getDoUsuario().Nome();
    setState(() {
      _nomeusuario = nome;
    });
  }

  _verificarserEAdmin() async {
    var admin = await getDoUsuario().Admin();
    setState(() {
      _Admin = admin;
    });
  }

  @override
  void initState() {
    _verificarserEAdmin();
    _getfotoDeperfil();
    _getNomeDOUsuario();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 3,
      child: ListView(
        children: [
          DrawerHeader(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Perfil: ",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                Text(
                  _nomeusuario,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                )
              ],
            ),
            decoration: BoxDecoration(
              color: Color(0x4F111DD7),
              image: DecorationImage(
                image: NetworkImage(_fotoDeperfil != null ? _fotoDeperfil : ""),
              ),
            ),
          ),
          _Admin
              ? Container()
              : Column(
                  children: [
                    kIsWeb
                        ? Container()
                        : ListTile(
                            leading: Icon(Icons.assignment_outlined),
                            title: Text('Registra Ocorrencia'),
                            onTap: () => {
                              Navigator.pushNamed(context,
                                  RouteGererator.rote_Adicionar_corencias)
                            },
                          ),
                    widget.constraints < 900
                        ? ListTile(
                            leading: Icon(
                              Icons.assignment,
                              color: Colors.black87,
                            ),
                            title: Text('Minhas Ocorrencias'),
                            onTap: () => {
                              Navigator.pushReplacementNamed(context,
                                  RouteGererator.rote_minhas_ocorencias)
                            },
                          )
                        : Container(),
                  ],
                ),
          ListTile(
            leading: Icon(
              Icons.account_circle_rounded,
              color: Colors.black87,
            ),
            title: Text('Meu Perfil'),
            onTap: () =>
                {Navigator.pushNamed(context, RouteGererator.rote_Perfil)},
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.black87,
            ),
            title: Text('Logout'),
            onTap: () {
              _deslogar();
            },
          ),
        ],
      ),
    );
  }
}
