import 'package:chart_widgets/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductService {
  static const String _baseUrl = 'https://dummyjson.com';


  Future<List<ProductModel>> _fetchProducts(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<ProductModel>.from(
        data['products'].map((item) => _mapProduct(item)),
      );
    } else {
      throw Exception('Failed to load products');
    }
  }


  Future<List<ProductModel>> getAllProducts() async {
    return _fetchProducts('$_baseUrl/products');
  }


  Future<List<ProductModel>> getSmartphones() async {
    return _fetchProducts('$_baseUrl/products/category/smartphones');
  }


  Future<List<ProductModel>> getLaptops() async {
    return _fetchProducts('$_baseUrl/products/category/laptops');
  }

  Future<List<ProductModel>> getByCategory(String category) async {
    return _fetchProducts('$_baseUrl/products/category/$category');
  }


  // Map JSON to ProductModel
  ProductModel _mapProduct(Map<String, dynamic> item) {
    return ProductModel(
      id: item['id'],
      title: item['title'],
      description: item['description'],
      category: item['category'],
      price: (item['price'] as num).toDouble(),
      discountPercentage: (item['discountPercentage'] as num).toDouble(),
      rating: (item['rating'] as num).toDouble(),
      stock: item['stock'],
      tags: List<String>.from(item['tags']),
      brand: item['brand'],
      sku: item['sku'] ,
      weight: item['weight'] ,
      dimensions: Dimensions(
        width: (item['dimensions']['width'] as num).toDouble(),
        height: (item['dimensions']['height'] as num).toDouble(),
        depth: (item['dimensions']['depth'] as num).toDouble(),
      ),
      warrantyInformation: item['warrantyInformation'] ,
      shippingInformation: item['shippingInformation'] ,
      availabilityStatus: item['availabilityStatus'] ,
      reviews: List<Review>.from(
        (item['reviews'] ?? []).map((review) => Review(
          reviewerName: review['reviewerName'],
          rating: review['rating'],
          comment: review['comment'],
          date: DateTime.parse(review['date']),
          reviewerEmail: review['reviewerEmail'],
        )),
      ),
      returnPolicy: item['returnPolicy'] ,
      minimumOrderQuantity: item['minimumOrderQuantity'],
      meta: Meta(
        createdAt: DateTime.parse(item['meta']['createdAt']),
        updatedAt: DateTime.parse(item['meta']['updatedAt']),
        barcode: item['meta']['barcode'],
        qrCode: item['meta']['qrCode'],
      ),
      images: List<String>.from(item['images']),
      thumbnail: item['thumbnail'],
    );
  }
}
