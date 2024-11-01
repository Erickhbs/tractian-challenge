class AssetEntity {
  
  String id;
  String name;
  String? parentId;
  String? locationId;
  String? sensorId;
  String? sensorType;
  String? status;
  String? gatewayId;

  AssetEntity({
    required this.id,
    required this.name,
    required this.parentId,
    required this.locationId,
    required this.sensorId,
    required this.sensorType,
    required this.status,
    required this.gatewayId,
  });

  static AssetEntity fromJson(Map<String, dynamic> doc ){
    return AssetEntity(
      id: doc['id'],
      name: doc['name'],
      parentId: doc['parentId'],
      locationId: doc['locationId'],
      sensorId: doc['sensorId'],
      sensorType: doc['sensorType'],
      status: doc['status'],
      gatewayId: doc['gatewayId']
    );
  }
}