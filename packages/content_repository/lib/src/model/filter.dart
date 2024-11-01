import 'package:content_repository/src/model/assets.dart';
import 'package:content_repository/src/model/locations.dart';

class Filter {
  final Asset asset;
  final List<Location> path;

  Filter({required this.asset, required this.path});
}