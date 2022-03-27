import 'package:flutter/material.dart';
import 'package:search/models/models.dart';

class ClienteFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Cliente cliente;

  ClienteFormProvider(this.cliente);

  updateAvailability(bool value) {
    print(value);
    this.cliente.available = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
