class Movie {
  final String id;
  final String name;
  final String date;
  final String posterpath;

  Movie({this.id, this.name, this.date, this.posterpath});

  factory Movie.fromJson(Map<String, dynamic> json) {
    // print(json);
    return Movie(
        id: json['id'].toString(),
        name: json['name'],
        posterpath: json['posterpath'],
        date: json['date']);
  }
}
