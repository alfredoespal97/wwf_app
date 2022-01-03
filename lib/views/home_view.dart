import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //var wwfApi = "https://raw.githubusercontent.com/alfredoespal97/json_wwf/main/wwf.json";
  List? films;

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
        body: Stack(
      children: [
        Positioned(
          top: -50,
          right: -50,
          child:
              Image.asset('assets/movie.png', width: 90, fit: BoxFit.fitWidth),
        ),
        const Positioned(
          top: 80,
          left: 20,
          child: Text(
            'Wizarding World\n Films',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        Positioned(
            top: 150,
            bottom: 0,
            width: width,
            child: Column(
              children: [
                films != null
                    ? Expanded(
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              childAspectRatio: 1.4,
                            ),
                            itemCount: films?.length,
                            itemBuilder: (context, i) {
                              return InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 12),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black26,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                            child: Text(films![i]['name']))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      )
              ],
            ))
      ],
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchFilmsData
      ),
    );
  }

  //Funcion para llamar datos de las peliculas
  void fetchFilmsData() async {
    var url = Uri.https(
        "raw.githubusercontent.com", "/alfredoespal97/json_wwf/main/wwf.json");
    await http.get(url).then((value) {
      print(value.statusCode);
      if (value.statusCode == 200) {
        var decodedJsonData = jsonDecode(value.body);
        films = decodedJsonData['films'];
        print(films![0]);
        setState(() {});
      } else {
        print('Request failed with status: ${value.statusCode}.');
      }
    }
    );
  }
}
