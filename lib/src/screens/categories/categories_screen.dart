import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_touma_mobile/src/models/document_category_model.dart';
import 'package:smart_touma_mobile/src/providers/categories_provider.dart';
import 'package:smart_touma_mobile/theme/app_theme.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<CategoriesProvider>(context, listen: false).fetchCategories();
    });
  }

  void _updateCategory(DocumentCategory category) {
    Provider.of<CategoriesProvider>(context, listen: false)
        .updateCategory(category)
        .then((_) => Navigator.pop(context));
  }

  void _deleteCategory(DocumentCategory category) {
    Provider.of<CategoriesProvider>(context, listen: false)
        .deleteCategory(category)
        .then((_) => Navigator.pop(context));
  }

  void _selectCategory(DocumentCategory category) {
    _nameController.text = category.name;
    _descriptionController.text = category.description;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(
            left: AppTheme.hPadding,
            right: AppTheme.hPadding,
            top: AppTheme.vPadding,
            bottom:
                MediaQuery.of(context).viewInsets.bottom + AppTheme.vPadding,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Edit category',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Category name',
                ),
              ),
              const SizedBox(height: AppTheme.vMargin),
              TextField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Category description',
                  border: OutlineInputBorder(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      category.name = _nameController.text;
                      category.description = _descriptionController.text;
                      _updateCategory(category);
                    },
                    child: const Text('Save'),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _deleteCategory(category);
                      },
                      child: const Text('Delete'))
                ],
              )
            ],
          ),
        );
      },
    );
  }

  void _createCategory({required String name, required String description}) {
    Provider.of<CategoriesProvider>(context, listen: false)
        .createCategory(name: name, description: description)
        .then((_) => Navigator.pop(context));
  }

  void _createCategoryBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(
            left: AppTheme.hPadding,
            right: AppTheme.hPadding,
            top: AppTheme.vPadding,
            bottom:
                MediaQuery.of(context).viewInsets.bottom + AppTheme.vPadding,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Edit category',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Category name',
                ),
              ),
              const SizedBox(height: AppTheme.vMargin),
              TextField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Category description',
                  border: OutlineInputBorder(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _createCategory(
                        name: _nameController.text,
                        description: _descriptionController.text,
                      );
                    },
                    child: const Text('Save'),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'addCategory',
        onPressed: _createCategoryBottomSheet,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: Consumer<CategoriesProvider>(builder: (context, provider, _) {
        if (provider.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(provider.error!),
                TextButton(
                  onPressed: () {
                    provider.deleteError();
                    provider.fetchCategories();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Skeletonizer(
            enabled: provider.isLoading,
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: provider.categories.length,
              itemBuilder: (context, index) {
                final category = provider.categories[index];
                return ListTile(
                  title: Text(category.name),
                  subtitle: Text(category.description),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      _selectCategory(category);
                    },
                  ),
                  onTap: () {
                    _selectCategory(category);
                  },
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
