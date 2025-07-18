import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/favourites_provider.dart';
import '../providers/cart_provider.dart'; // ✅ Import CartProvider
import 'rating_starts.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavouritesProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context); // ✅ Use CartProvider
    bool isFav = favProvider.isFavourite(product.id);

    return Card(
      margin: EdgeInsets.all(6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Image.network(product.image, height: 100),
            SizedBox(height: 8),
            Text(
              product.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('\$${product.price.toStringAsFixed(2)}'),
            RatingStars(rating: product.rating),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: isFav ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    favProvider.toggleFavourite(product);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.shopping_cart_outlined),
                  onPressed: () {
                    cartProvider.addToCart(product); // ✅ Add to cart
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.title} added to cart!'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
