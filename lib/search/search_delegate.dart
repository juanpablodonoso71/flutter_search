import 'package:flutter/material.dart';
import 'package:search/models/cliente.dart';
import 'package:search/services/clientes_service.dart';
import 'package:provider/provider.dart';

class ClientesSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Text('results');
  }

  Widget _emptyContainer() {
    return Container(
      child: Center(
        child: Icon(
          Icons.person,
          color: Colors.grey,
          size: 130,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }
    return Container();

    /*  final clientesService =
        Provider.of<ClientesService>(context, listen: false);

    return FutureBuilder(
        future: clientesService.searchClientes(query),
        builder: (_, AsyncSnapshot<List<Cliente>> snapshot) {
          if (!snapshot.hasData) return _emptyContainer();

          return Container();
        }); */
  }
}
