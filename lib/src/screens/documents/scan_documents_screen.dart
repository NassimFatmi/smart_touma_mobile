import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smart_touma_mobile/src/providers/documents_provider.dart';
import 'package:smart_touma_mobile/theme/app_theme.dart';

class ScanDocumentsScreen extends StatefulWidget {
  const ScanDocumentsScreen({super.key});

  @override
  State<ScanDocumentsScreen> createState() => _ScanDocumentsScreenState();
}

class _ScanDocumentsScreenState extends State<ScanDocumentsScreen> {
  XFile? _imageFile;
  String _title = "";
  bool _isLoading = false;
  void _addMediaFromGallery() async {
    final XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (image == null) {
      return;
    }

    setState(() {
      _imageFile = image;
    });
  }

  void _addMediaFromCamera() async {
    final XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 100);

    if (image == null) {
      return;
    }

    setState(() {
      _imageFile = image;
    });
  }

  void _createDocument() async {
    if (_imageFile == null) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    await Provider.of<DocumentsProvider>(context, listen: false)
        .createDocument(_imageFile!);

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Scan Documents",
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.hPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    _title = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: "Title",
                  hintText: "Enter title",
                ),
              ),
              const SizedBox(height: AppTheme.hMargin * 2),
              Text(
                "Add Media",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      iconSize: 32,
                      onPressed: _addMediaFromGallery,
                      icon: const Icon(Icons.add_photo_alternate)),
                  const SizedBox(width: AppTheme.hMargin),
                  IconButton(
                      iconSize: 32,
                      onPressed: _addMediaFromCamera,
                      icon: const Icon(Icons.add_a_photo)),
                ],
              ),
              const SizedBox(height: AppTheme.hMargin * 2),
              Text(
                "Perview",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: AppTheme.hMargin),
              if (_imageFile != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.file(
                      File(_imageFile!.path),
                      height: 200,
                      width: 200,
                    ),
                  ],
                ),
              if (_imageFile == null)
                const SizedBox(
                    height: 200,
                    child: Center(
                        child: Text(
                      "No image selected",
                      textAlign: TextAlign.center,
                    ))),
              const Expanded(child: SizedBox()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.upload),
                    onPressed: _createDocument,
                    label: const Text("Upload"),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.hMargin * 2),
            ],
          ),
        )));
  }
}
