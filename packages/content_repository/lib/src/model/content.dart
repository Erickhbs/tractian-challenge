import 'package:content_repository/src/entity/asset_entity.dart';
import 'package:content_repository/src/entity/location_entity.dart';
import 'package:content_repository/src/model/model.dart';

class Content {
  final String companyId;
  final List<Asset> assets;
  final List<Location> locations;

  Content({
    required this.companyId,
    required this.assets,
    required this.locations,
  });

  factory Content.fromJson(String companyId, Map<String, dynamic> json) {
    // Extrair os assets da empresa
    List<dynamic> jsonAssets = json['assets'];
    List<Asset> assets = jsonAssets.map((json) => Asset.fromEntity(AssetEntity.fromJson(json))).toList();

    // Extrair as locations da empresa
    List<dynamic> jsonLocations = json['locations'];
    List<Location> locations = jsonLocations.map((json) => Location.fromEntity(LocationEntity.fromJson(json))).toList();

    return Content(
      companyId: companyId,
      assets: assets,
      locations: locations,
    );
  }

  List<Location> get rootLocations {
    return locations.where((location) => location.parentId == null).toList();
  }

  List<Location> getChildLocations(String parentId) {
    return locations.where((location) => location.parentId == parentId).toList();
  }

  List<Asset> getAssetsInLocation(String locationId) {
    return assets.where((asset) => asset.locationId == locationId).toList();
  }

  List<Asset> getChildAssets(String parentId) {
    return assets.where((asset) => asset.parentId == parentId).toList();
  }

  List<Asset> get rootAssets {
    return assets.where((asset) => (asset.parentId == null && asset.locationId == null )).toList();
  }

  List<Filter> getAlertAssets() {
    List<Filter> result = [];

    void searchLocation(Location location, List<Location> path) {
      List<Location> subLocations = getChildLocations(location.id);
      List<Asset> locationAssets = getAssetsInLocation(location.id);
      List<Location> currentPath = List.from(path)..add(location);

      for (var asset in locationAssets) {
        if (asset.status == "alert") {
          result.add(Filter(asset: asset, path: currentPath));
        }
      }

      for (var subLocation in subLocations) {
        searchLocation(subLocation, currentPath);
      }
    }

    for (var location in rootLocations) {
      searchLocation(location, []);
    }

    for (var asset in rootAssets) {
      if (asset.status == "alert") {
        result.add(Filter(asset: asset, path: []));
      }
    }
    return result;
  }

  List<Filter> getEnergyAssets() {
    List<Filter> result = [];

    void searchLocation(Location location, List<Location> path) {
      List<Location> subLocations = getChildLocations(location.id);
      List<Asset> locationAssets = getAssetsInLocation(location.id);
      List<Location> currentPath = List.from(path)..add(location);

      for (var asset in locationAssets) {
        if ((asset.sensorType == "energy" || asset.sensorType == "vibration") && asset.status != null) {
          result.add(Filter(asset: asset, path: List.from(currentPath)));
        }
      }

      for (var subLocation in subLocations) {
        searchLocation(subLocation, currentPath);
      }
    } 

    for (var location in rootLocations) {
      searchLocation(location, []);
    }

    return result;
  }
}
