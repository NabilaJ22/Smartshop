import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favourites_provider.dart';
import '../widgets/product_card.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavouritesProvider>(context);
    final favItems = favProvider.favourites;

    return Scaffold(
      appBar: AppBar(title: Text('Favourites')),
      body: favItems.isEmpty
          ? Center(child: Text('No favourite products yet.'))
          : GridView.builder(
        padding: EdgeInsets.all(8),
        itemCount: favItems.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.65,
        ),
        itemBuilder: (context, index) {
          return ProductCard(product: favItems[index]);
        },
      ),
    );
  }
}
