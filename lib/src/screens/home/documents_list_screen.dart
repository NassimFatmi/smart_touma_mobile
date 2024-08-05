import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_touma_mobile/src/providers/documents_provider.dart';
import 'package:smart_touma_mobile/src/screens/documents/document_details_screen.dart';
import 'package:smart_touma_mobile/src/utils/mock_elements.dart';

class DocumentsListScreen extends StatefulWidget {
  const DocumentsListScreen({super.key});

  @override
  State<DocumentsListScreen> createState() => _DocumentsListScreenState();
}

class _DocumentsListScreenState extends State<DocumentsListScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () =>
          Provider.of<DocumentsProvider>(context, listen: false).getDocuments(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Documents",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: Consumer<DocumentsProvider>(builder: (context, provider, _) {
        return Skeletonizer(
          enabled: provider.isLoading,
          child: ListView.builder(
              itemCount: provider.documents.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(provider.documents[index].title),
                  leading: const Icon(Icons.file_copy),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DocumentDetailsScreen(
                          document: provider.documents[index],
                        ),
                      ),
                    );
                  },
                );
              }),
        );
      }),
    );
  }
}
