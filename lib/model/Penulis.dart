class Penulis {
  int? id;
  String? authorName;
  String? nationality;
  int? birthYear;

  Penulis({this.id, this.authorName, this.nationality, this.birthYear});

  factory Penulis.fromJson(Map<String, dynamic> obj) {
    return Penulis(
        id: obj['id'],
        authorName: obj['author_name'],
        nationality: obj['nationality'],
        birthYear: obj['birth_year']);
  }

  Map<String, dynamic> toJson() {
    return {
      "author_name": authorName,
      "nationality": nationality,
      "birth_year": birthYear,
    };
  }
}
