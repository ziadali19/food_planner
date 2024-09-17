class Country {
  final String? strArea;

  Country(this.strArea);

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      map['strArea'],
    );
  }
}
