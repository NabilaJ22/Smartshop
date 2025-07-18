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
  SortOption? _sortOption;

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
    if (_sortOption == null) return products;

    switch (_sortOption!) {
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          PopupMenuButton<SortOption>(
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
              List<Product> products = _applySorting(snapshot.data!);
              return GridView.builder(
                padding: EdgeInsets.all(8),
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  return ProductCard(product: products[index]);
                },
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
