import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'film.dart';

class DetailPage extends StatelessWidget {
  final Film film;
  const DetailPage(this.film, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
          child: Column(children: <Widget>[
        Container(
            width: MediaQuery.of(context).size.width,
            child: Hero(
              tag: 'img',
              child: ClipRRect(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
                child: CachedNetworkImage(
                  imageUrl: film.img,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  height: 200,
                ),
              ),
            )),
        SizedBox(
          height: 20,
        ),
        Container(
            child: Text(
          film.name,
          style: TextStyle(color: Colors.black45),
        )),
        SizedBox(
          height: 8,
        ),
        Container(
            child: Text(
          film.year,
          style: TextStyle(color: Colors.black45),
        )),
        SizedBox(
          height: 8,
        ),
        Container(
            child: Text(
          film.duration,
          style: TextStyle(color: Colors.black45),
        )),
        SizedBox(
          height: 8,
        ),
        Container(
            child: Text(
          film.director,
          style: TextStyle(color: Colors.black45),
        )),
        SizedBox(
          height: 8,
        ),
        // Container(
        //     child: Text(
        //   film.description,
        //   style: TextStyle(color: Colors.black45),
        // )),
      ])),
      floatingActionButton: FloatingActionButton(
        onPressed: Navigator.of(context).pop,
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}
