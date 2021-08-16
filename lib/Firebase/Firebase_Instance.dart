import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore db = FirebaseFirestore.instance;

class UsuarioAutentica {
  UsuarioAutentica.Deslogar() {
    auth.signOut();
  }
}

class IdUsuario {
  id() {
    return auth.currentUser.uid;
  }
}

class getDoUsuario {
  Cidade() async {
    DocumentSnapshot documentSnapshot =
        await db.collection("usuarios").doc(IdUsuario().id()).get();
    var dados = documentSnapshot.data();
    return dados["cidade"];
  }

  Bairro() async {
    DocumentSnapshot documentSnapshot =
        await db.collection("usuarios").doc(IdUsuario().id()).get();
    var dados = documentSnapshot.data();
    return dados["bairro"];
  }

  Admin() async {
    DocumentSnapshot documentSnapshot =
        await db.collection("usuarios").doc(IdUsuario().id()).get();
    var dados = documentSnapshot.data();
    return dados["admin"];
  }
  Foto()async{
    DocumentSnapshot documentSnapshot =
    await db.collection("usuarios").doc(IdUsuario().id()).get();
    var dados = documentSnapshot.data();
    return dados["fotoPerfil"];
  }
  Nome()async{
    DocumentSnapshot documentSnapshot =
    await db.collection("usuarios").doc(IdUsuario().id()).get();
    var dados = documentSnapshot.data();
    return dados["nome"];
  }

}

class ListaDeBairro {
  Firebase() async {
    List bairros = List();
    QuerySnapshot querySnapshot = await db.collection("ocorrencias").get();
    for (DocumentSnapshot dados in querySnapshot.docs) {
      var bairro = dados.data();
      if (bairros.contains(bairro["bairro"])) {
      } else {
        bairros.add(bairro["bairro"]);
      }
    }
    return bairros;
  }
}
