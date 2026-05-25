class ProductModel {
   int id;
   String title;
   String description;
   String category;
   double price;
   double discountPercentage;
   double rating;
   int stock;
   List<String> tags;
   String? brand;
   String sku;
   int weight;
   Dimensions dimensions;
   String warrantyInformation;
   String shippingInformation;
   String   availabilityStatus;
   List<Review> reviews;
   String returnPolicy;
   int minimumOrderQuantity;
   Meta meta;
   List<String> images;
   String thumbnail;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.images,
    required this.thumbnail,
  });

  @override
String toString() {
  return 'ProductModel(id: $id, title: $title, price: $price, category: $category)';
}
}

class Dimensions {
   double width;
  double height;
  double depth;

  Dimensions({
    required this.width,
    required this.height,
    required this.depth,
  });
}

class Review {
   int rating;
 String comment;
 DateTime date;
  String reviewerName;
String reviewerEmail;

  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });
  }
class Meta {
   DateTime createdAt;
   DateTime updatedAt;
   String barcode;
   String qrCode;

  Meta({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });
}