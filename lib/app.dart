import 'package:company_repository/company_repository.dart';
import 'package:content_repository/content_repository.dart';
import 'package:flutter/material.dart';
import 'package:tractians_mobile_challenge/views/home/home_view.dart';

class MyApp extends StatelessWidget {
  final CompanyRepository companyRepository;
  final ContentRepository contentRepository;

  const MyApp({required this.companyRepository, required this.contentRepository, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          onSurface: Colors.white,
          onPrimary: Color(0xFF17192D),
          onSecondary: Color(0xFF2188FF),
          onTertiary: Colors.green,
          onError: Colors.red,
          inverseSurface: Colors.black,
          inversePrimary: Colors.grey,
        ),
      ),
      home: HomeView(companyRepository: companyRepository, contentRepository: contentRepository),
    );
  }
}
