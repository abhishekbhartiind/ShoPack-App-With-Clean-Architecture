// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ProductsEntity extends Equatable {
  final bool success;
  final List<ProductEntity> products;
  final int filteredProductsCount;

  ProductsEntity(
    this.success,
    this.products,
    this.filteredProductsCount,
  );

  @override
  List<Object> get props => [success, products, filteredProductsCount];
}

class ProductEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final int price;
  final num ratings;
  final List<ImageEntity> images;
  final String category;
  final int stock;
  final int numOfReviews;
  final String user;
  final List<ReviewEntity>? reviews;
  ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.ratings,
    required this.images,
    required this.category,
    required this.stock,
    required this.numOfReviews,
    required this.user,
    required this.reviews,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      description,
      price,
      ratings,
      images,
      category,
      stock,
      numOfReviews,
      user,
      reviews,
    ];
  }
}

class ImageEntity extends Equatable {
  final String publicid;
  final String url;

  const ImageEntity(this.publicid, this.url);

  @override
  List<Object> get props => [publicid, url];
}

class ReviewEntity extends Equatable {
  final String? user;
  final String? name;
  final int? rating;
  final String? comment;

  ReviewEntity(this.user, this.name,this.rating, this.comment);

  @override
  List<Object?> get props => [user, name,rating, comment];
}