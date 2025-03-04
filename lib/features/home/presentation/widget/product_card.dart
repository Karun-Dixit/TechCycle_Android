import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint1/app/constants/api_endpoints.dart';
import 'package:sprint1/features/home/data/model/product.dart';
import 'package:sprint1/features/home/presentation/bloc/home_bloc.dart';
import 'package:sprint1/features/home/presentation/view/home_view.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    String? imageUrl = product.image != null
        ? "${ApiEndpoints.imageUrl}${product.image!.split('/').last}"
        : null;

    return GestureDetector(
      onTap: () {
        // Get the HomeBloc instance from the current context
        final homeBloc = BlocProvider.of<HomeBloc>(context);
        // Navigate with BlocProvider.value to pass the HomeBloc
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: homeBloc, // Pass the existing HomeBloc instance
              child: ProductDetailScreen(product: product),
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 4.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(8.0)),
                child: imageUrl != null
                    ? CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.image_not_supported, size: 100),
                      )
                    : const Icon(Icons.image_not_supported, size: 100),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Rs. ${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.green),
                  ),
                  if (product.status.isNotEmpty)
                    Text(
                      'Status: ${product.status}',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
