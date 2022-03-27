import 'package:flutter/material.dart';
import 'package:search/models/models.dart';

//
//
//
// DISEÑO DE FOTO Y NOMBRE DE CLIENTE PARA BUSCAR
//
//
//
class ClienteCard extends StatelessWidget {
  final Cliente cliente;

  const ClienteCard({Key? key, required this.cliente}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: EdgeInsets.only(top: 30, bottom: 30),
        width: double.infinity,
        height: 80,
        decoration: _cardBorders(),
        child: Row(
          //alignment: Alignment.bottomLeft,
          children: [
            _BackgroundImage(cliente.picture),
            //Image(image: AssetImage('assets/avatar.png')),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                cliente.apellido,
                //+ ' ' + cliente.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: false,
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(color: Colors.white);
}

class _NotAvailable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('No disponible'),
      width: 100,
      height: 50,
      alignment: Alignment.center,
      color: Colors.grey,
    );
  }
}

class _PriceTag extends StatelessWidget {
  final double price;

  const _PriceTag(this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('$price'),
      width: 100,
      height: 50,
      alignment: Alignment.center,
      color: Colors.grey,
    );
  }
}

class _ClienteDetails extends StatelessWidget {
  final String title;
  //final String subTitle;

  const _ClienteDetails({
    required this.title,
    //required this.subTitle
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: double.infinity,
      height: 50,
      color: Colors.grey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontFamily: 'Avenir', fontSize: 20, color: Colors.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  final String? url;

  const _BackgroundImage(this.url);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      child: url == null
          ? Image(image: AssetImage('assets/avatar.png'), fit: BoxFit.cover)
          : FadeInImage(
              placeholder: AssetImage('assets/cuadrados.gif'),
              image: NetworkImage(url!),
              fit: BoxFit.cover,
            ),
    );
  }
}
