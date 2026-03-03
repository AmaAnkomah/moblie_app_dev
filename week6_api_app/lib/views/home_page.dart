import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/article_viewmodel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Access ViewModel using Provider
    final viewModel = Provider.of<ArticleViewModel>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Headlines'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => viewModel.refreshArticles(),
          ),
        ],
      ),
      body: _buildBody(context, viewModel),
    );
  }
  
  Widget _buildBody(BuildContext context, ArticleViewModel viewModel) {
    // Show loading indicator
    if (viewModel.isLoading && viewModel.articles.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    
    // Show error message
    if (viewModel.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 60, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Error loading news',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(viewModel.errorMessage!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => viewModel.loadArticles(),
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    }
    
    // Show empty state
    if (viewModel.articles.isEmpty) {
      return const Center(child: Text('No articles available'));
    }
    
    // Show list of articles
    return RefreshIndicator(
      onRefresh: () => viewModel.refreshArticles(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: viewModel.articles.length,
        itemBuilder: (context, index) {
          final article = viewModel.articles[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image if available
                  if (article.imageUrl != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        article.imageUrl!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 200,
                            color: Colors.grey[300],
                            child: const Center(child: Text('Image not available')),
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 12),
                  
                  // Title
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Description
                  Text(
                    article.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  
                  // Source and date row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        article.source,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        _formatDate(article.publishedAt),
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  
  String _formatDate(String dateString) {
    // Simple date formatting
    if (dateString.isEmpty) return '';
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return '';
    }
  }
}
