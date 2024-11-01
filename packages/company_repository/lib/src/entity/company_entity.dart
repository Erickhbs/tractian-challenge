class CompanyEntity {
  String id;
  String name;

  CompanyEntity({
    required this.id,
    required this.name,
  });

  static CompanyEntity fromJson(Map<String, dynamic> doc) {
    return CompanyEntity(
      id: doc['id'],
      name: doc['name'])
    ;
  }
}