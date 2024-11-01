import 'package:content_repository/src/entity/asset_entity.dart';

class Asset {
  
  String id;
  String name;
  String? parentId;
  String? locationId;
  String? sensorId;
  String? sensorType;
  String? status;
  String? gatewayId;

  Asset({
    required this.id,
    required this.name,
    required this.parentId,
    required this.locationId,
    required this.sensorId,
    required this.sensorType,
    required this.status,
    required this.gatewayId,
  });

  static Asset fromEntity(AssetEntity entity) {
    return Asset(
      id: entity.id,
      name: entity.name,
      parentId: entity.parentId,
      locationId: entity.locationId,
      sensorId: entity.sensorId,
      sensorType: entity.sensorType,
      status: entity.status,
      gatewayId: entity.gatewayId
    );
  }

  @override
  String toString() {
    return 'Asset: $id, $name, $parentId, $locationId, $sensorId,$sensorType, $status, $gatewayId';
  }
}