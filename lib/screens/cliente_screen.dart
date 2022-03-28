import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:search/providers/cliente_form_provider.dart';
import 'package:search/services/services.dart';
import 'package:search/ui/input_decorations.dart';

import 'package:search/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class ClienteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final clienteService = Provider.of<ClientesService>(context);

    return ChangeNotifierProvider(
      create: (_) => ClienteFormProvider(clienteService.selectedCliente),
      child: _ClientesScreenBody(clienteService: clienteService),
    );
  }
}

class _ClientesScreenBody extends StatelessWidget {
  const _ClientesScreenBody({
    Key? key,
    required this.clienteService,
  }) : super(key: key);

  final ClientesService clienteService;

  @override
  Widget build(BuildContext context) {
    final clienteForm = Provider.of<ClienteFormProvider>(context);
    return Scaffold(
      appBar: AppBar(
          title: Text('CLIENTE',
              style: TextStyle(fontFamily: 'Avenir', fontSize: 20)),
          actions: [
            IconButton(
              onPressed: () async {
                final picker = new ImagePicker();
                final XFile? xFile = await picker.pickImage(
                    source: ImageSource.camera,
                    maxHeight: 600,
                    maxWidth: 800,
                    imageQuality: 60);

                if (xFile == null) {
                  print('No no seleccionó nada');
                  return;
                }

                clienteService.updateSelectedclienteImage(xFile.path);
              },
              icon: Icon(Icons.camera_alt_outlined,
                  size: 30, color: Colors.white),
            ),
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClienteImage(url: clienteService.selectedCliente.picture),
              ],
            ),
            _ClienteForm(),
            SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black87,
        child: clienteService.isSaving
            ? CircularProgressIndicator(color: Colors.white)
            : Icon(Icons.save_outlined),
        onPressed: clienteService.isSaving
            ? null
            : () async {
                if (!clienteForm.isValidForm()) return;
                final String? imageUrl = await clienteService.uploadImage();

                if (imageUrl != null) clienteForm.cliente.picture = imageUrl;

                await clienteService.saveOrCreateCliente(clienteForm.cliente);
              },
      ),
    );
  }
}

class _ClienteForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final clienteForm = Provider.of<ClienteFormProvider>(context);
    final cliente = clienteForm.cliente;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _builBoxDecoration(),
        child: Form(
          key: clienteForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox(height: 10),
              TextFormField(
                initialValue: cliente.name,
                onChanged: (value) => cliente.name = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'El nombre es obligatorio';
                },
                decoration: InputDecorations.authInputDecoration(
                    hinText: 'Nombre del cliente', labelText: 'Nombre:'),
              ),
              SizedBox(height: 15),
              TextFormField(
                initialValue: cliente.apellido,
                onChanged: (value) => cliente.apellido = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'El apellido es obligatorio';
                },
                decoration: InputDecorations.authInputDecoration(
                    hinText: 'Apellido del cliente', labelText: 'Apellido:'),
              ),
              SizedBox(height: 15),
              TextFormField(
                initialValue: '${cliente.altura}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value) {
                  if (double.tryParse(value) == null) {
                    cliente.altura = 0;
                  } else {
                    cliente.altura = double.parse(value);
                  }
                },
                //keyboardType: TextInputType.number,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecorations.authInputDecoration(
                    hinText: '150', labelText: 'Altura:'),
              ),
              SizedBox(height: 15),
              TextFormField(
                initialValue: '${cliente.peso}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value) {
                  if (double.tryParse(value) == null) {
                    cliente.peso = 0;
                  } else {
                    cliente.peso = double.parse(value);
                  }
                },
                //keyboardType: TextInputType.number,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecorations.authInputDecoration(
                    hinText: '150', labelText: 'Peso:'),
              ),
              SizedBox(height: 30),
              SwitchListTile.adaptive(
                  value: cliente.available,
                  title: Text('Disponible'),
                  activeColor: Color.fromARGB(255, 23, 62, 71),
                  onChanged: clienteForm.updateAvailability),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _builBoxDecoration() => BoxDecoration(color: Colors.white);
}
