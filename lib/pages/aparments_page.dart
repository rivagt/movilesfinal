import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AparmentPage extends StatefulWidget {
  static String id = 'aparments_page';
  static const routeName = '/extractArguments';

  @override
  State<AparmentPage> createState() => _AparmentPageState();
}

class _AparmentPageState extends State<AparmentPage> {
  // late Future<List<Apartment>> _listaApartments;
  late Future<List<Apartment>> _listaApartments;
  Future<List<Apartment>> _getApartments() async {
    final response =
        await http.get(Uri.parse("http://34.135.64.65:3003/api/apartment"));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      List<dynamic> body = jsonDecode(response.body);

      List<Apartment> apartments = body
          .map(
            (dynamic item) => Apartment.fromJson(item),
          )
          .toList();
      return apartments;
    } else {
      // Si esta respuesta no fue OK, lanza un error.
      throw Exception('Failed to load post');
    }
  }

  @override
  void initState() {
    super.initState();
    // _listaApartments = _getApartments();
    _listaApartments = _getApartments();
  }

// ListView.builder(
//           itemCount: 1,
//           itemBuilder: (context, index) {
//             return ListTile(
//               onLongPress: () {
//                 // _deleteApartment(context, _apartments[index]);
//               },
//               title: Text('_apartments[index].description'),
//               subtitle: Text('_apartments[index].ubication'),
//               leading: Text('S/. '), //${_apartments[index].price}
//               trailing: Text('Llamar al: '), //${_apartments[index].phone}
//             );
//           },
//         )
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff7289EA),
        body: FutureBuilder(
          future: _listaApartments,
          builder:
              (BuildContext context, AsyncSnapshot<List<Apartment>> snapshot) {
            if (snapshot.hasData) {
              List<Apartment> apartments = snapshot.requireData;
              return ListView(
                children: apartments
                    .map(
                      (Apartment apart) => ListTile(
                        title: Text(apart.description),
                        subtitle: Text("${apart.ubication}"),
                      ),
                    )
                    .toList(),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

_deleteApartment(context, Apartment apartment) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Text("Eliminar departamento"),
            content: Text("¿Está seguro?"),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancelar")),
              FlatButton(
                  onPressed: () {
                    // _apartments.remove(apartment);
                    Navigator.pop(context);
                  },
                  child: Text("Eliminar")),
            ],
          ));
}

class Apartment {
  // String id;
  var ubication;
  var picture;
  var price;
  var category;
  var description;
  var phone;
  // String v;
  Apartment(
      {this.ubication,
      this.picture,
      this.price,
      this.category,
      this.description,
      this.phone});
  factory Apartment.fromJson(Map<String, dynamic> json) {
    return Apartment(
      ubication: json['ubication'],
      picture: json['picture'],
      price: json['price'],
      category: json['category'],
      description: json['description'],
      phone: json['phone'],
    );
  }
}
