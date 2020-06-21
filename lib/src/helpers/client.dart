import 'package:butchertesta1916/src/models/client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:butchertesta1916/src/models/client.dart';

  class ClientServices {
  String collection = "clients";
  Firestore _firestore = Firestore.instance;

  void createClient(Map<String, dynamic> values){
    String id = values["id"];
    _firestore.collection(collection).document(id).setData(values);
  }
  Future<List<ClientModel>> getClients() async =>
      _firestore.collection(collection).getDocuments().then((result) {
        List<ClientModel> clients = [];
        for(DocumentSnapshot client in result.documents){
          clients.add(ClientModel.fromSnapshot(client));
        }
        print("===== helpers / client.dart > getClients ${clients[1]} ===========");
        return clients;
      });

  Future<ClientModel> getClientsById({String id}) async =>
      _firestore
          .collection(collection)
          .document(id)
          .get()
          .then((doc) {
        return ClientModel.fromSnapshot(doc);
      });

  Future<List<ClientModel>> searchClients({String clientName}) {
    // code to convert the first character to uppercase
    String searchKey = clientName[0].toUpperCase() + clientName.substring(1);
    print("============== helpers/client > search: $searchKey ==============");
    return _firestore
        .collection(collection)
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .getDocuments()
        .then((result) {
      List<ClientModel> clients = [];
      for (DocumentSnapshot client in result.documents) {
        clients.add(ClientModel.fromSnapshot(client));
      }
      return clients;
    });
  }
}