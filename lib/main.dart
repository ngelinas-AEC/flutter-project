import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forfaits Voyages',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: AccueilForfaitsVoyages(title: 'Forfaits Voyages'),
    );
  }
}

class AccueilForfaitsVoyages extends StatefulWidget {
  AccueilForfaitsVoyages({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  AccueilForfaitsVoyagesState createState() => AccueilForfaitsVoyagesState();
}

class AccueilForfaitsVoyagesState extends State<AccueilForfaitsVoyages> {
  Future<List<Forfait>>? futursForfaits;

  initState() {
    super.initState();
    futursForfaits = _fetchForfaits();
  }

  Column _buildButtonColumn(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label + ' ',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              //     color: color,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Forfait>>(
      future: futursForfaits,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
              appBar: AppBar(title: Text(widget.title!)),
              body: Center(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, position) {
                          return Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            12.0, 12.0, 12.0, 6.0),
                                        child: Text(
                                          snapshot.data?[position]
                                                  .destination ??
                                              '',
                                          style: TextStyle(
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            12.0, 6.0, 12.0, 12.0),
                                        child: Text(
                                          snapshot.data?[position]
                                                  .villeDepart ??
                                              '',
                                          style: TextStyle(fontSize: 18.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Text(
                                          snapshot.data?[position].hotel?.nombreEtoiles.toString() ?? '',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child:
                                          Icon(
                                            Icons.star_border,
                                            size: 35.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                height: 2.0,
                                color: Colors.grey,
                              )
                            ],
                          );
                        },
                        itemCount: snapshot.data?.length,
                      ),
                    )
                  ],
                ),
              )); // Cette partie a été comprimée dans les notes pour une meilleure visibilité
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}

class Forfait {
  final String? id;
  final String? destination;
  final String? villeDepart;
  final DateTime? dateDepart;
  final DateTime? dateRetour;
  final String? image;
  final int? prix;
  final int? rabais;
  final bool? vedette;
  final Hotel? hotel;

  Forfait(
      {this.id,
      this.destination,
      this.villeDepart,
      this.hotel,
      this.dateDepart,
      this.dateRetour,
      this.image,
      this.prix,
      this.rabais,
      this.vedette});

  factory Forfait.fromJson(Map<String, dynamic> json) {
    return Forfait(
      id: json['_id'],
      destination: json['destination'],
      villeDepart: json['villeDepart'],
      dateDepart: DateTime.parse(
          json['dateDepart']), //DateTime.parse(json['dateDepartD']),
      dateRetour:
          DateTime.parse("2021-01-01"), //DateTime.parse(json['dateRetourD']),
      image: json['image'],
      prix: json['prix'],
      rabais: json['rabais'],
      vedette: json['vedette'],
      hotel: Hotel.fromJson(json['hotel']),
    );
  }
}

class Hotel {
  final String? nom;
  final String? coordonnees;
  final int? nombreEtoiles;
  final int? nombreChambres;
  final List<String>? caracteristiques;

  Hotel(
      {this.nom,
      this.coordonnees,
      this.nombreEtoiles,
      this.nombreChambres,
      this.caracteristiques});

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
        nom: json['nom'],
        coordonnees: json['coordonnees'],
        nombreEtoiles: json['nombreEtoiles'],
        nombreChambres: json['nombreChambres'],
        caracteristiques: new List<String>.from(json['caracteristiques']));
  }
}

Future<List<Forfait>> _fetchForfaits() async {
  final response = await http.get(Uri.https(
      'forfaits-voyages.herokuapp.com', '/api/forfaits/da/1996407', {}));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse
        .map((forfait) => new Forfait.fromJson(forfait))
        .toList();
  } else {
    throw Exception('Erreur de chargement des forfaits');
  }
}
