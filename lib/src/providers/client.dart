import 'package:butchertesta1916/src/helpers/client.dart';
import 'package:butchertesta1916/src/models/client.dart';
import 'package:flutter/material.dart';

class ClientProvider with ChangeNotifier{
  ClientServices _clientServices = ClientServices();
  List<ClientModel> clients = [];
  List<ClientModel> clientsSearched = [];
  ClientModel clientsById;

//  getter

  ClientProvider.inizialize(){
    print("===== providers\product.dart inizialize prima 1===========");
    _loadClients();
    print("===== providers\product.dart inizialize dopo 2===========");
  }

  _loadClients ()async{
    print("===== providers\product.dart Loadclients prima 3===========");
    clients = await _clientServices.getClients();
    print("===== providers\product.dart Loadclients dopo  4===========");
    notifyListeners();
    print("===== providers\product.dart inizialize prima 5===========");
  }

  Future loadClientsById ({String id})async{
    clientsById = await _clientServices.getClientsById(id: id);
    notifyListeners();
  }

  Future search({String clientName})async{
    clientsSearched = await _clientServices.searchClients(clientName: clientName);
    notifyListeners();
  }
}