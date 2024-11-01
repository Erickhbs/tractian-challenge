import 'package:content_repository/content_repository.dart';
import 'package:flutter/material.dart';
import 'package:tractians_mobile_challenge/views/assets/teste.dart';

class UnitCard extends StatelessWidget {
  final String name;
  final String id;
  final ContentRepository contentRepository;
  final String image = "assets/images/vector.png";

  const UnitCard({
    required this.name,
    required this.id,
    required this.contentRepository,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15),
      color: Theme.of(context).colorScheme.onSecondary,
      elevation: 0,
      child: ListTile(
        subtitle: Row(
          children: [
            Image.asset(image, scale: 5),
            const SizedBox(width: 15),
            Text(
              '$name unit',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            )
          ],
        ),
        isThreeLine: true,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AssetsView(
                contentRepository: contentRepository,
                companyId: id,
              ),
            ),
          );
        },
      ),
    );
  }
}
