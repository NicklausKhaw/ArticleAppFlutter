import 'package:flutter/material.dart';
import '../viewmodels/home_view_model.dart';
import '../widgets/article_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel();
    _viewModel.onStateChanged = () {
      setState(() {});
    };
    // Load articles when the page is first created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.loadArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('NYT Articles'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              _viewModel.setPeriod(value);
              _viewModel.loadArticles();
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: '1', child: Text('1 Day')),
              const PopupMenuItem(value: '7', child: Text('7 Days')),
              const PopupMenuItem(value: '30', child: Text('30 Days')),
            ],
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.filter_list),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Article Type Dropdown
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: DropdownButtonFormField<String>(
              value: _viewModel.selectedType,
              decoration: const InputDecoration(
                labelText: 'Article Type',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
              items: HomeViewModel.articleTypes.map((String type) {
                return DropdownMenuItem<String>(value: type, child: Text(type));
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  _viewModel.setArticleType(newValue);
                  _viewModel.loadArticles();
                }
              },
            ),
          ),
          // Articles List
          Expanded(child: _buildArticlesList()),
        ],
      ),
    );
  }

  Widget _buildArticlesList() {
    if (_viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_viewModel.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Error loading articles',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              _viewModel.error!,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _viewModel.clearError();
                _viewModel.loadArticles();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_viewModel.articles.isEmpty) {
      return const Center(child: Text('No articles found'));
    }

    return RefreshIndicator(
      onRefresh: () => _viewModel.loadArticles(),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _viewModel.articles.length,
        itemBuilder: (context, index) {
          final article = _viewModel.articles[index];
          return ArticleCard(
            article: article,
            onTap: () {
              // TODO: Navigate to article detail page or open URL
            },
          );
        },
      ),
    );
  }
}
