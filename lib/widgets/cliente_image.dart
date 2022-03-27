import 'dart:io';

import 'package:flutter/material.dart';

class ClienteImage extends StatelessWidget {
  final String? url;

  const ClienteImage({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        decoration: _buildBoxDecoration(),
        width: double.infinity,
        height: 300,
        child: Opacity(
          opacity: 0.9,
          child: ClipRRect(child: getImage(url)),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(color: Colors.white);

  Widget getImage(String? picture) {
    if (picture == null)
      return Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Image(
          image: AssetImage('assets/avatar.png'),
        ),
      );

    if (picture.startsWith('http'))
      return FadeInImage(
        image: NetworkImage(this.url!),
        placeholder: AssetImage('assets/hfgif100.gif'),
        fit: BoxFit.cover,
      );

    return Image.file(File(picture), fit: BoxFit.cover);
  }
}
