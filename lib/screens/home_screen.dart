import 'package:flutter/material.dart';
import 'package:search/models/models.dart';
import 'package:search/screens/screens.dart';
import 'package:search/search/search_delegate.dart';
import 'package:search/services/services.dart';
import 'package:provider/provider.dart';
import 'package:search/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final clientesService = Provider.of<ClientesService>(context);

    if (clientesService.isLoading) return LoadingScreen();
    return Scaffold(
      appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => showSearch(
                        context: context,
                        delegate: ClientesSearchDelegate(),
                      ));
            },
          ),
          title: Text('SELECCIONAR CLIENTE',
              style: TextStyle(fontFamily: 'Avenir', fontSize: 20)),
          actions: []),
      body: ListView.builder(
          itemCount: clientesService.clientes.length,
          itemBuilder: (BuildContext contex, int index) => GestureDetector(
              onTap: () {
                clientesService.selectedCliente =
                    clientesService.clientes[index].copy();

                Navigator.pushNamed(context, 'cliente');
              },
              child: ClienteCard(
                cliente: clientesService.clientes[index],
              ))),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black87,
        child: Icon(Icons.add),
        onPressed: () {
          clientesService.selectedCliente = new Cliente(
            available: false,
            name: '',
            apellido: '',
            altura: 0,
            peso: 0,
          );
          Navigator.pushNamed(context, 'cliente');
        },
      ),
    );
  }
}
