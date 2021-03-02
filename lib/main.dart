import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
        primarySwatch: Colors.blue,
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
                          return Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          height: 220,
                          width: double.maxFinite,
                          child: Card(
                          elevation: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                    width: 2.0, color: Colors.blue),
                              ),
                              color: Colors.white,
                            ),
                          child: Padding(
                            padding: EdgeInsets.all(7),
                          child: Stack(children: <Widget>[

                          Align(
                            alignment: Alignment.topLeft,
                              child: Stack(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(4,12,0,0),
                                      child:
                                      Icon(
                                        Icons.hotel,
                                        size: 20.0,
                                        color: Colors.blueGrey,
                                      ),
                                    ),



                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
                                        child: Row(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: RichText(
                                                  text: TextSpan(
                                                    text: snapshot.data?[position].hotel?.nom ?? '',
                                                    style: TextStyle(
                                                        color: Colors.black38, fontSize: 24),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: ' (',
                                                          style: TextStyle(
                                                              color: Colors.blueGrey,
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.bold)),
                                                      TextSpan(
                                                          text: snapshot.data?[position].destination ?? '',
                                                          style: TextStyle(
                                                              color: Colors.blueGrey,
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.bold)),
                                                      TextSpan(
                                                          text: ')',
                                                          style: TextStyle(
                                                              color: Colors.blueGrey,
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.bold)),
                                                    ],

                                                  ),
                                                ),
                                              )
                                            ]
                                        )
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(35, 40, 0, 0),
                                      child: Row(
                                          children: <Widget>[
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: RichText(
                                          text: TextSpan(
                                            text: 'de ',
                                            style: TextStyle(
                                                color: Colors.black38, fontSize: 16),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: snapshot.data?[position].villeDepart ?? '',
                                                  style: TextStyle(
                                                      color: Colors.blueGrey,
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                      )

                                            ]
                                      )
                                    ),




                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                                        child: Row(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.center,
                                                child: RichText(
                                                  text: TextSpan(
                                                    text: 'Prix: ',
                                                    style: TextStyle(
                                                        color: Colors.black38, fontSize: 16),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: snapshot.data?[position].prix.toString() ?? '',
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 20,
                                                              fontWeight: FontWeight.bold)),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ]
                                        )
                                    ),


                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(35, 60, 0, 0),
                                        child: Row(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.center,
                                                child: RichText(
                                                  text: TextSpan(
                                                    text: 'Date de départ: ',
                                                    style: TextStyle(
                                                        color: Colors.black38, fontSize: 16),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: snapshot.data?[position].dateDepart.toString() ?? '',
                                                          style: TextStyle(
                                                              color: Colors.blueGrey,
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.bold)),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ]
                                        )
                                    ),


                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(35, 100, 0, 0),
                                        child: Row(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.center,
                                                child: RichText(
                                                  text: TextSpan(
                                                    text: 'Date de retour: ',
                                                    style: TextStyle(
                                                        color: Colors.black38, fontSize: 16),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: snapshot.data?[position].dateRetour.toString() ?? '',
                                                          style: TextStyle(
                                                              color: Colors.blueGrey,
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.bold)),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ]
                                        )
                                    ),


                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                        child: Row(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.bottomRight,
                                                child: RichText(
                                                  text: TextSpan(
                                                    text: ' ',
                                                    style: TextStyle(
                                                        color: Colors.black38, fontSize: 16),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: snapshot.data?[position].hotel?.nombreEtoiles.toString() ?? '',
                                                          style: TextStyle(
                                                              color: Colors.blueGrey,
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.bold),

                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ]
                                        )
                                    ),

                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                        child:Row(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child:
                                              Icon(
                                                Icons.star_border,
                                                size: 22.0,
                                                color: Colors.blueGrey,
                                              ),
                                            ),

                                          ],
                                        )
                                    )


                                  ],
                              )
                          )

                          ]
                          )
                          )
                          )
                          )
                          );
                        },
                        itemCount: snapshot.data?.length,
                      ),
                    )
                  ],
                ),
              )
          ); // Cette partie a été comprimée dans les notes pour une meilleure visibilité
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
