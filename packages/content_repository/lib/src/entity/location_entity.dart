class LocationEntity {
  String id;
  String name;
  String? parentId;

  LocationEntity({
    required this.id,
    required this.name,
    required this.parentId
  });

  static LocationEntity fromJson(Map<String, dynamic> doc){
    return LocationEntity(
      id: doc['id'],
      name: doc['name'],
      parentId: doc['parentId']
    );
  }
}