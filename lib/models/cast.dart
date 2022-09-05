class CastList {
  final List<Cast> cast;

  CastList(this.cast);
}

class Cast {
  final String name;
  final String profilePath;
  final String character;

  Cast({required this.name, required this.profilePath, required this.character});

  factory Cast.fromJson(dynamic json) {
    if (json == null) {
      return Cast(character: '', name: '', profilePath: '');
    }

    return Cast(
        name: json['name'],
        profilePath: json['profile_path'],
        character: json['character']);
  }
}