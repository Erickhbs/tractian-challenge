import 'dart:convert';
import 'package:content_repository/src/entity/asset_entity.dart';
import 'package:content_repository/src/entity/location_entity.dart';
import 'package:content_repository/src/model/model.dart';
import 'package:flutter/services.dart';

class ContentRepository {
  final List<Content> contents;

  ContentRepository({required this.contents});

  Future<void> loadContentsFromJson(String jsonPath) async {
    try {
      String jsonData = await rootBundle.loadString(jsonPath);

      if (jsonData.isNotEmpty) {
        Map<String, dynamic> jsonMap = json.decode(jsonData);

        jsonMap.forEach((companyId, data) {
          List<Asset> assets = (data['assets'] as List<dynamic>?)
              ?.map((json) => Asset.fromEntity(AssetEntity.fromJson(json)))
              .toList() ?? const [];

          List<Location> locations = (data['locations'] as List<dynamic>?)
              ?.map((json) => Location.fromEntity(LocationEntity.fromJson(json)))
              .toList() ?? const [];

          contents.add(Content(
            companyId: companyId,
            assets: assets,
            locations: locations,
          ));
        });
      } else {
        print('O JSON está vazio.');
      }
    } catch (e) {
      print('Erro ao carregar em content: $e');
    }
  }

  List<Filter> getAlertAssets(String companyId) {
    return contents
        .firstWhere((content) => content.companyId == companyId, orElse: () => Content(companyId: companyId, assets: [], locations: []))
        .getAlertAssets();
  }

  List<Filter> getEnergyAssets(String companyId) {
    return contents
        .firstWhere((content) => content.companyId == companyId, orElse: () => Content(companyId: companyId, assets: [], locations: []))
        .getEnergyAssets();
  }
}
