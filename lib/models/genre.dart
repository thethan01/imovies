class Genre {
  final dynamic id;
  final dynamic name;

  String? error;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(dynamic json) {
    if (json == null) {
      return Genre(name: '', id: 1);
    }
    return Genre(id: json['id'], name: json['name']);
  }
}
