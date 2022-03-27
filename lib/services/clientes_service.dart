import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:search/models/cliente.dart';
import 'package:http/http.dart' as http;
import 'package:search/models/search_response.dart';

class ClientesService extends ChangeNotifier {
  final String _baseUrl = 'controlpeso-631db-default-rtdb.firebaseio.com';

  final List<Cliente> clientes = [];
  late Cliente selectedCliente;

  File? newPictureFile;

  bool isLoading = true;
  bool isSaving = false;

  var filterByUser;

  ClientesService() {
    this.loadClientes();
  }

  Future<List<Cliente>> loadClientes() async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'clientes.json');
    final resp = await http.get(url);

    final Map<String, dynamic> clientesMap = json.decode(resp.body);

    clientesMap.forEach((key, value) {
      final tempCliente = Cliente.fromMap(value);
      tempCliente.id = key;
      this.clientes.add(tempCliente);
    });

    this.isLoading = false;
    notifyListeners();

    return this.clientes;
  }

  Future saveOrCreateCliente(Cliente cliente) async {
    isSaving = true;
    notifyListeners();

    if (cliente.id == null) {
      //es necesario crear
      await this.createCliente(cliente);
    } else {
      //actualizar
      await this.updateCliente(cliente);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateCliente(Cliente cliente) async {
    final url = Uri.https(_baseUrl, 'clientes/${cliente.id}.json');

    final resp = await http.put(url, body: cliente.toJson());
    final decodedData = resp.body;

    final index =
        this.clientes.indexWhere((element) => element.id == cliente.id);
    this.clientes[index] = cliente;

    return cliente.id!;
  }

  Future<String> createCliente(Cliente cliente) async {
    final url = Uri.https(_baseUrl, 'clientes.json');

    final resp = await http.post(url, body: cliente.toJson());
    final decodedData = json.decode(resp.body);

    cliente.id = decodedData['name'];

    this.clientes.add(cliente);

    return cliente.id!;
  }

  void updateSelectedclienteImage(String path) {
    this.selectedCliente.picture = path;
    this.newPictureFile = File.fromUri(Uri(path: path));

    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (this.newPictureFile == null) return null;
    this.isSaving = true;
    notifyListeners();

    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dwx1jpidk/image/upload?upload_preset=uzgep3o2');
    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file =
        await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('algo salio mal');
      print(resp.body);
      return null;
    }

    this.newPictureFile = null;
    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
  }

  Future<List<Cliente>> searchClientes(Cliente cliente) async {
    final filterString = filterByUser ? 'orderBy="apellido"&equalTo=' : '';
    final url = Uri.https(
      _baseUrl, 'clientes.json$filterString',
      //{'orderBy': 'apellido', 'equalTo': query}
    );

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);
    return searchResponse.apellido;
  }
}
