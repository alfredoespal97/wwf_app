import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'film.dart';
import 'detail_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //var wwfApi = "https://raw.githubusercontent.com/alfredoespal97/json_wwf/main/wwf.json";
  List? films;
  late Film peli = Film(
      0,
      "name",
      "img",
      [
        "Adventure"
      ],
      "year",
      "duration",
      "director",
      "description");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      fetchFilmsData();
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
          child: Column(children: <Widget>[
        Container(
            width: width,
          child: ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
            child: Image.asset(
              'assets/fondo.jpg',
              height: 200,
            ),
        )),
        films != null
            ? Expanded(
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: films?.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                          // print(films![i]['name']);
                          // print(films![i]['img']);
                          // print(films![i]['type']);
                          // print(films![i]['year']);
                          // print(films![i]['director']);
                          // print(films![i]['duration']);
                          assignFilm(i);
                          Navigator.push(context, new MaterialPageRoute(builder: (context) => DetailPage(peli)));
                        },
                        child: Container(
                          height: 250.0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Hero(
                                tag: 'img',
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  child: CachedNetworkImage(
                                    imageUrl: films![i]['img'],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              )
            : const Center(
                child: CircularProgressIndicator(),
              )
      ])),
      //floatingActionButton: FloatingActionButton(onPressed: fetchFilmsData),
    );
  }

  //Funcion para llamar datos de las peliculas
  void fetchFilmsData() async {
    var url = Uri.https("raw.githubusercontent.com", "/alfredoespal97/json_wwf/main/db.json");
    await http.get(url).then((value) {
      print(value.statusCode);
      if (value.statusCode == 200) {
        var decodedJsonData = jsonDecode(value.body);
        films = decodedJsonData['films'];
        setState(() {});
      } else {
        print('Request failed with status: ${value.statusCode}.');
      }
    });
  }

  void assignFilm(int index) {
    peli.id = films![index]['id'];
    peli.name = films![index]['name'];
    peli.img = films![index]['img'];
    peli.year = films![index]['year'];
    peli.duration = films![index]['duration'];
    peli.director = films![index]['director'];
    peli.description = films![index]['description'];
    List t = films![index]['type'];
    for (int i = 0; i < t.length; i++) {
      peli.type.add(t.elementAt(i));
    }
  }
}
