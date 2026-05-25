import '../models/product_model.dart';
import '../services/get_products.dart';

class ProductController {

  final ProductService _productService = ProductService();

  Future<List<ProductModel>> fetchAllProducts() async {
    try {
      return await _productService.getAllProducts();
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  Future<List<ProductModel>> fetchSmartphones() async {
    try {
      return await _productService.getSmartphones();
    } catch (e) {
      throw Exception('Error fetching smartphones: $e');
    }
  }

  Future<List<ProductModel>> fetchLaptops() async {
    try {
      return await _productService.getLaptops();
    } catch (e) {
      throw Exception('Error fetching laptops: $e');
    }
  }
  Future<List<ProductModel>> fetchByCategory(String category) async {
    try {
      return await _productService.getByCategory(category);
    } catch (e) {
      throw Exception('Error fetching products by category: $e');
    }
  }

}