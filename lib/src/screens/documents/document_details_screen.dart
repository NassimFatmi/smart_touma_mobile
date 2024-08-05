import 'package:provider/provider.dart';
import 'package:smart_touma_mobile/src/providers/documents_provider.dart';
import 'package:smart_touma_mobile/src/screens/documents/edit_document_screen.dart';
import 'package:smart_touma_mobile/src/utils/file_storage.dart';
import 'package:smart_touma_mobile/theme/app_theme.dart';

import 'package:flutter/material.dart';
import 'package:smart_touma_mobile/src/models/document_model.dart';

class DocumentDetailsScreen extends StatefulWidget {
  final Document document;
  final FileStorage fileStorage = FileStorage();

  DocumentDetailsScreen({super.key, required this.document});

  @override
  State<DocumentDetailsScreen> createState() => _DocumentDetailsScreenState();
}

class _DocumentDetailsScreenState extends State<DocumentDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.document.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.hPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: MediaQuery.of(context).size.height / 3,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppTheme.borderRadius),
              ),
              child: const Center(child: Text('Preview')),
            ),
            const SizedBox(height: AppTheme.vMargin * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Categories',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                TextButton(
                  onPressed: _editDocumentCategories,
                  child: const Text('Edit'),
                ),
              ],
            ),

            const SizedBox(height: AppTheme.vMargin * 2),

            // actions buttons
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: AppTheme.hMargin),
                    child: ElevatedButton.icon(
                      onPressed: _downloadDocumentAsPDF,
                      icon: const Icon(Icons.download),
                      label: const Text('PDF'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: AppTheme.hMargin),
                    child: ElevatedButton.icon(
                      onPressed: _downloadLatexDocument,
                      icon: const Icon(Icons.download),
                      label: const Text('LateX'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: AppTheme.hMargin),
                    child: ElevatedButton.icon(
                      onPressed: _editDocument,
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: AppTheme.hMargin),
                    child: ElevatedButton.icon(
                      onPressed: _deleteDocument,
                      icon: const Icon(Icons.delete),
                      label: const Text('Delete'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: AppTheme.hMargin),
                    child: ElevatedButton.icon(
                      onPressed: _shareDocument,
                      icon: const Icon(Icons.share),
                      label: const Text('Share'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _shareDocument() {}

  void _deleteDocument() async {
    await Provider.of<DocumentsProvider>(context, listen: false)
        .deleteDocument(widget.document.id);
    if (mounted) Navigator.pop(context);
  }

  void _editDocument() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EditDocumentScreen(document: widget.document);
    }));
  }

  void _editDocumentCategories() {}

  void _downloadDocumentAsPDF() {}

  void _downloadLatexDocument() async {
    await widget.fileStorage.writeFile(
      fileName: '${widget.document.title}.tex',
      content: widget.document.latexCode,
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Document saved as LateX'),
        ),
      );
    }
  }
}
