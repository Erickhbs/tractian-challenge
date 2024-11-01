import 'package:company_repository/company_repository.dart';
import 'package:content_repository/content_repository.dart';
import 'package:flutter/material.dart';
import 'package:tractians_mobile_challenge/views/home/components/unit_card.dart';

class HomeView extends StatelessWidget {
  final CompanyRepository companyRepository;
  final ContentRepository contentRepository;
  final String logo = "assets/images/logo.png";

  const HomeView({
    required this.companyRepository,
    required this.contentRepository,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(logo, fit: BoxFit.contain, height: 200),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 120,
          crossAxisCount: 1,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: companyRepository.companies.length,
        itemBuilder: (context, index) {
          final company = companyRepository.companies[index];
          return UnitCard(
            name: company.name,
            id: company.id,
            contentRepository: contentRepository,
          );
        },
      ),
    );
  }
}
