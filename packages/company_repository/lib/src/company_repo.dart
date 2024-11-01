import 'dart:convert';
import 'package:company_repository/src/entity/entity.dart';
import 'package:flutter/services.dart';
import './model/company.dart';

class CompanyRepository {
  List<Company> companies = [];

  CompanyRepository({required this.companies});

  Future<void> loadCompaniesFromJson(String jsonPath) async {
    try {
      String jsonData = await rootBundle.loadString(jsonPath);

      if (jsonData.isNotEmpty) {
        Map<String, dynamic> jsonMap = json.decode(jsonData);

        if (jsonMap['companies'] != null) {
          List<dynamic> jsonCompanies = jsonMap['companies'];
          companies.addAll(jsonCompanies.map((json) => Company.fromEntity(CompanyEntity.fromJson(json))).toList());
        } else {
          print('A lista de companies não foi encontrada.');
        }
      } else {
        print('O JSON está vazio.');
      }
    } catch (e) {
      print('Erro ao carregar em companies do JSON: $e');
    }
  }

  Company? getCompanyById(String id) {
    return companies.firstWhere((company) => company.id == id);
  }
}
