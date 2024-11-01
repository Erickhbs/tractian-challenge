import 'package:flutter/material.dart';
import 'package:content_repository/content_repository.dart';
import 'package:tractians_mobile_challenge/views/assets/components/alert_filter.dart';
import 'package:tractians_mobile_challenge/views/assets/components/energy_filter.dart';
import 'package:tractians_mobile_challenge/views/assets/components/search_filter.dart';

class AssetsView extends StatefulWidget {
  final ContentRepository contentRepository;
  final String companyId;
  final String assetPng = "assets/images/asset.png";
  final String locationPng = "assets/images/location.png";
  final String componentPng = "assets/images/component.png";
  final String sensor = "assets/images/";

  const AssetsView({
    required this.contentRepository,
    required this.companyId,
    super.key,
  });

  @override
  AssetsViewState createState() => AssetsViewState();
}

class AssetsViewState extends State<AssetsView> {
  bool showEnergyAssets = false;
  bool showAlertAssets = false;

  @override
  Widget build(BuildContext context) {
    List<Location> rootLocations = widget.contentRepository.contents
        .firstWhere((content) => content.companyId == widget.companyId)
        .rootLocations;

    List<Asset> rootAssets = widget.contentRepository.contents
        .firstWhere((content) => content.companyId == widget.companyId)
        .rootAssets;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text("Assets"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SearchFilter(),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      EnergyFilter(
                        onFilterChanged: (isPressed) {
                          setState(() {
                            showEnergyAssets = isPressed;
                            showAlertAssets = false;
                          });
                        },
                      ),
                      const SizedBox(width: 10),
                      AlertFilter(
                        onFilterChanged: (isPressed) {
                          setState(() {
                            showAlertAssets = isPressed;
                            showEnergyAssets = false;
                          });
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: rootLocations.length + rootAssets.length,
              itemBuilder: (context, index) {
                if (index < rootLocations.length) {
                  return buildLocationTile(rootLocations[index]);
                } else {
                  return buildAssetTile(rootAssets[index - rootLocations.length]);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  bool shouldDisplayAsset(Asset asset) {
    if (showEnergyAssets &&
        (asset.sensorType == "energy" || asset.sensorType == "vibration") &&
        asset.status == "operating") {
      return true;
    }
    if (showAlertAssets && asset.status == "alert") {
      return true;
    }
    if (!showEnergyAssets && !showAlertAssets) {
      return true;
    }
    return false;
  }

  Widget buildLocationTile(Location location) {
    List<Location> subLocations = widget.contentRepository.contents
        .firstWhere((content) => content.companyId == widget.companyId)
        .getChildLocations(location.id);

    List<Asset> locationAssets = widget.contentRepository.contents
        .firstWhere((content) => content.companyId == widget.companyId)
        .getAssetsInLocation(location.id);

    return ExpansionTile(
      collapsedTextColor: Theme.of(context).colorScheme.inverseSurface,
      textColor: Theme.of(context).colorScheme.inverseSurface,
      collapsedIconColor: Theme.of(context).colorScheme.inverseSurface,
      iconColor: Theme.of(context).colorScheme.inverseSurface,
      childrenPadding: const EdgeInsets.only(left: 10),
      initiallyExpanded: true,
      controlAffinity: ListTileControlAffinity.leading,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(widget.locationPng, scale: 1),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              location.name,
              maxLines: 2,
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
      children: [
        ...subLocations.map((loc) => buildLocationTile(loc)),
        ...locationAssets.where((asset) => shouldDisplayAsset(asset)).map((asset) => buildAssetTile(asset)),
      ],
    );
  }

  Widget buildAssetTile(Asset asset) {
    List<Asset> subAssets = widget.contentRepository.contents
        .firstWhere((content) => content.companyId == widget.companyId)
        .getChildAssets(asset.id);

    String assetImage = (asset.sensorType != null || asset.sensorId != null) && asset.status != null
        ? widget.componentPng
        : widget.assetPng;

    String sensor = ((asset.sensorType == "energy" || asset.sensorType == "vibration") && asset.status == "operating")
        ? "${widget.sensor}energy.png"
        : "${widget.sensor}alert.png";

    return ExpansionTile(
      collapsedTextColor: Theme.of(context).colorScheme.inverseSurface,
      textColor: Theme.of(context).colorScheme.inverseSurface,
      collapsedIconColor: Theme.of(context).colorScheme.inverseSurface,
      iconColor: Theme.of(context).colorScheme.inverseSurface,
      childrenPadding: const EdgeInsets.only(left: 20),
      initiallyExpanded: true,
      controlAffinity: ListTileControlAffinity.leading,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(assetImage, scale: 1),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              asset.name,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (assetImage == widget.componentPng) Image.asset(sensor, scale: 3),
        ],
      ),
      children: [
        ...subAssets.where((subAsset) => shouldDisplayAsset(subAsset)).map((subAsset) => buildAssetTile(subAsset)),
      ],
    );
  }
}
