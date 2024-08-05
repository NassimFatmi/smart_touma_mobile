import 'package:flutter/material.dart';
import 'package:smart_touma_mobile/src/models/document_model.dart';
import 'package:smart_touma_mobile/src/screens/documents/document_details_screen.dart';
import 'package:smart_touma_mobile/theme/app_theme.dart';

class DocumentCard extends StatelessWidget {
  final Document document;

  const DocumentCard({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DocumentDetailsScreen(document: document)));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.hPadding),
        margin: const EdgeInsets.only(right: AppTheme.hMargin * 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(child: Text(document.title)),
      ),
    );
  }
}
