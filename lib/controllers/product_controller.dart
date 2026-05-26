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

  Future<Map<String,int>> stockByCategory() async {
    List<ProductModel> products = await fetchAllProducts();

    Map<String, int> categoryStockData = {};
    for (var product in products) {
      categoryStockData[product.category] = (categoryStockData[product.category] ?? 0) + product.stock;
    }
    return categoryStockData;
  }

  Future<Map<String,int>> countByRating() async {
    List<ProductModel> products = await fetchAllProducts();
    Map<String, int> categoryCount = {};
    for (var product in products) {
      categoryCount[product.rating.round().toString()] = (categoryCount[product.rating.round().toString()] ?? 0) + 1;
    }
   
    return categoryCount;
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