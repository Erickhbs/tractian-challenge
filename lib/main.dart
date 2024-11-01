import 'package:content_repository/content_repository.dart';
import 'package:flutter/material.dart';
import 'package:company_repository/company_repository.dart';
import 'package:tractians_mobile_challenge/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final companyRepo = CompanyRepository(companies: []);
  await companyRepo.loadCompaniesFromJson('assets/apidata.json');

  final contentRepo = ContentRepository(contents: []);
  await contentRepo.loadContentsFromJson('assets/apidata.json');

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp(companyRepository: companyRepo, contentRepository: contentRepo));
}
