import '../entity/company_entity.dart';

class Company {
  String id;
  String name;

  Company({
    required this.id,
    required this.name,
  });

  static Company fromEntity(CompanyEntity entity) {
    return Company(
      id: entity.id,
      name: entity.name,
    );
  }

  @override
  String toString() {
    return 'Company: $id, $name';
  }
}
