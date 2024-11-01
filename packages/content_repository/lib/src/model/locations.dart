import 'package:content_repository/src/entity/location_entity.dart';

class Location {
  String id;
  String name;
  String? parentId;

  Location({
    required this.id,
    required this.name,
    required this.parentId
  });

  static Location fromEntity(LocationEntity entity){
    return Location(
      id: entity.id,
      name: entity.name,
      parentId: entity.parentId
    );
  }

  @override
  String toString() {
    return 'Location: $id, $name, $parentId';
  }
}