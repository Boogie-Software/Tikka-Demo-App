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

import 'package:tikka_demo_app/domain/entity/data_loading_status.dart';
import 'package:tikka_demo_app/domain/entity/product.dart';
import 'package:tikka/domain/entity/state.dart';

class ProductsState implements State {

  final String? error;
  final List<Product> products;
  final DataLoadingStatus status;

  bool get hasErrors => error != null;

  ProductsState({
    this.status = DataLoadingStatus.initial,
    this.products = const [],
    this.error
  });

  ProductsState copy({DataLoadingStatus? status, List<Product>? products, String? error}) =>
    ProductsState(
      status: status ?? this.status,
      products: products ?? this.products,
      error: error ?? this.error
    );
}