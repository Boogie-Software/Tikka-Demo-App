// Copyright 2025 Boogie Software Oy. All rights reserved.
//
// This file is licensed to you under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License. You may obtain a copy
// of the License at http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software distributed under
// the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR REPRESENTATIONS
// OF ANY KIND, either express or implied. See the License for the specific language
// governing permissions and limitations under the License.

import 'package:tikka_demo_app/domain/entity/product.dart';
import 'package:tikka_demo_app/domain/entity/review.dart';
import 'package:tikka_demo_app/adapter/repository/json_to_dimensions_converter.dart';
import 'package:tikka_demo_app/adapter/repository/json_to_meta_converter.dart';
import 'package:tikka_demo_app/adapter/repository/json_to_review_converter.dart';
import 'package:tikka/util/json_serializer.dart';

class JsonToProductConverter extends JsonSerializer {

  Product asProduct(Map<String, dynamic> json) =>
    Product(
      id: asInt(json["id"]),
      title: asString(json["title"]),
      description: asString(json["description"]),
      category: asString(json["category"]),
      price: asDouble(json["price"]),
      discountPercentage: asDouble(json["discountPercentage"]),
      rating: asDouble(json["rating"]),
      stock: asInt(json["stock"]),
      tags: asStringList(json["tags"]),
      brand: asString(json["brand"]),
      sku: asString(json["sku"]),
      weight: asDouble(json["weight"]),
      dimensions: JsonToDimensionsConverter().asDimensions(json["dimensions"]),
      warrantyInformation: asString(json["warrantyInformation"]),
      shippingInformation: asString(json["shippingInformation"]),
      availabilityStatus: asString(json["availabilityStatus"]),
      reviews: _asReviewList(json["reviews"]),
      returnPolicy: asString(json["returnPolicy"]),
      minimumOrderQuantity: asInt(json["minimumOrderQuantity"]),
      meta: JsonToMetaConverter().asMeta(json["meta"]),
      thumbnail: asString(json["thumbnail"]),
      images: asStringList(json["images"])
    );

  List<Review> _asReviewList(List? json) {
    if (json == null) return List.empty();
    return json.map((e) => JsonToReviewConverter().asReview(e)).toList();
  } 
   
}