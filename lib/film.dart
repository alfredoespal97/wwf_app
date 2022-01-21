import 'dart:core';

class Film {
  late int id;
  late String name;
  late String img;
  late List<String> type;
  late String year;
  late String duration;
  late String director;
  late String description;

  Film(int id, String name, String img, List<String> type, String year, String duration, String director, String description) {
    this.id = id;
    this.name = name;
    this.img = img;
    this.type = type;
    this.year = year;
    this.duration = duration;
    this.director = director;
    this.description = description;
  }
}
