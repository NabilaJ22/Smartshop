import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import '../providers/favourites_provider.dart';
import '../widgets/product_card.dart';
import '../widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

enum SortOption { priceLow, priceHigh, rating }

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> _futureProducts;
  SortOption _sortOption = SortOption.priceLow;

  @override
  void initState() {
    super.initState();
    _futureProducts = ApiService.fetchProducts();
  }

  Future<void> _refreshProducts() async {
    setState(() {
      _futureProducts = ApiService.fetchProducts();
    });
  }

  List<Product> _applySorting(List<Product> products) {
    switch (_sortOption) {
      case SortOption.priceLow:
        products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortOption.priceHigh:
        products.sort((a, b) => b.price.compareTo(a.price));
        break;
      case SortOption.rating:
        products.sort((a, b) => b.rating.compareTo(a.rating));
        break;
    }
    return products;
  }

  Map<String, List<Product>> _groupProductsByCategory(List<Product> products) {
    final Map<String, List<Product>> grouped = {};
    for (var product in products) {
      grouped.putIfAbsent(product.category, () => []).add(product);
    }
    return grouped;
  }

  Widget _buildCategorySection(String category, List<Product> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: Text(
            category.toUpperCase(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 8),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            return ProductCard(product: products[index]);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          PopupMenuButton<SortOption>(
            initialValue: _sortOption,
            onSelected: (value) {
              setState(() {
                _sortOption = value;
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: SortOption.priceLow, child: Text('Price: Low → High')),
              PopupMenuItem(value: SortOption.priceHigh, child: Text('Price: High → Low')),
              PopupMenuItem(value: SortOption.rating, child: Text('Rating')),
            ],
            icon: Icon(Icons.sort),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshProducts,
        child: FutureBuilder<List<Product>>(
          future: _futureProducts,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product> sortedProducts = _applySorting(snapshot.data!);
              final grouped = _groupProductsByCategory(sortedProducts);

              return ListView(
                children: grouped.entries
                    .map((entry) => _buildCategorySection(entry.key, entry.value))
                    .toList(),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Failed to load products'));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
