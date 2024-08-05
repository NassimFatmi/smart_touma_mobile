import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_touma_mobile/src/providers/home_provider.dart';
import 'package:smart_touma_mobile/src/screens/documents/scan_documents_screen.dart';
import 'package:smart_touma_mobile/src/screens/home/documents_list_screen.dart';
import 'package:smart_touma_mobile/src/screens/home/widgets/search_field.dart';
import 'package:smart_touma_mobile/src/widgets/document_card.dart';
import 'package:smart_touma_mobile/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<HomeProvider>(context, listen: false).fetchHomeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "scanpdf",
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ScanDocumentsScreen()),
        ),
        child: const FaIcon(FontAwesomeIcons.camera),
      ),
      appBar: AppBar(
        title: Text(
          "Smart Touma",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_outlined),
            onPressed: () {
              showSearch(context: context, delegate: SearchField());
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Consumer<HomeProvider>(
          builder: (context, provider, _) {
            if (provider.error != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(provider.error!),
                    TextButton(
                      onPressed: () {
                        provider.deleteError();
                        provider.fetchHomeData();
                      },
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              );
            }

            return Padding(
                padding: const EdgeInsets.all(AppTheme.hPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recent documents",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        TextButton(
                          onPressed: _viewRecentDocs,
                          child: const Text(
                            "View All",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: AppTheme.vMargin,
                    ),
                    if (provider.homeData?.recentDocuments.isEmpty ?? true)
                      const SizedBox(
                        height: 150,
                        child: Center(child: Text("No recent documents")),
                      ),
                    if (provider.homeData?.recentDocuments.isNotEmpty ?? false)
                      SizedBox(
                        height: 150,
                        child: Skeletonizer(
                          enabled: provider.isLoading,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                provider.homeData?.recentDocuments.length ?? 0,
                            itemBuilder: (context, index) {
                              return DocumentCard(
                                document:
                                    provider.homeData!.recentDocuments[index],
                              );
                            },
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: AppTheme.vMargin,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Shared with me",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        TextButton(
                          onPressed: _viewRecentDocs,
                          child: const Text(
                            "View All",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: AppTheme.vMargin,
                    ),
                    if (provider.homeData?.sharedDocuments.isEmpty ?? true)
                      const SizedBox(
                          height: 150,
                          child: Center(child: Text("No shared documents"))),
                    if (provider.homeData?.sharedDocuments.isNotEmpty ?? false)
                      SizedBox(
                        height: 150,
                        child: Skeletonizer(
                          enabled: provider.isLoading,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                provider.homeData?.sharedDocuments.length,
                            itemBuilder: (context, index) {
                              return DocumentCard(
                                document:
                                    provider.homeData!.sharedDocuments[index],
                              );
                            },
                          ),
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Latest Categories",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: AppTheme.vMargin,
                    ),
                    if (provider.homeData?.latestCategories.isEmpty ?? true)
                      const SizedBox(
                        height: 40,
                        child: Center(child: Text("No categories")),
                      ),
                    if (provider.homeData?.latestCategories.isNotEmpty ?? false)
                      SizedBox(
                        height: 40,
                        child: Skeletonizer(
                          enabled: provider.isLoading,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                provider.homeData?.latestCategories.length,
                            itemBuilder: (context, index) {
                              final categpry =
                                  provider.homeData!.latestCategories[index];

                              return Chip(label: Text(categpry.name));
                            },
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: AppTheme.vMargin,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Latest Templates",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: AppTheme.vMargin,
                    ),
                    if (provider.homeData?.latestTemplates.isEmpty ?? true)
                      const SizedBox(
                          height: 150,
                          child: Center(child: Text("No templates"))),
                    if (provider.homeData?.latestTemplates.isNotEmpty ?? false)
                      SizedBox(
                        height: 150,
                        child: Skeletonizer(
                          enabled: provider.isLoading,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                provider.homeData?.latestTemplates.length,
                            itemBuilder: (context, index) {
                              final template =
                                  provider.homeData!.latestTemplates[index];
                              return Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(template.name),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                  ],
                ));
          },
        ),
      ),
    );
  }

  void _viewRecentDocs() {
    if (mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const DocumentsListScreen(),
        ),
      );
    }
  }
}
