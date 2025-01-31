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

import 'package:flutter_test/flutter_test.dart';
import 'package:tikka_demo_app/domain/entity/data_loading_status.dart';
import 'package:tikka_demo_app/domain/entity/product.dart';
import 'package:tikka_demo_app/domain/entity/products_state.dart';

void main() {
  group('ProductsState', () {
    test('Initial state', () {
      final state = ProductsState();
      expect(state.status, DataLoadingStatus.initial);
      expect(state.products, isEmpty);
      expect(state.error, isNull);
      expect(state.hasErrors, isFalse);
    });

    test('State with products', () {
      final products = [
        Product(id: 1, title: 'Product 1'),
        Product(id: 2, title: 'Product 2'),
      ];
      final state = ProductsState(status: DataLoadingStatus.success, products: products);
      expect(state.status, DataLoadingStatus.success);
      expect(state.products, products);
      expect(state.error, isNull);
      expect(state.hasErrors, isFalse);
    });

    test('State with error', () {
      final state = ProductsState(status: DataLoadingStatus.failure, error: 'Error message');
      expect(state.status, DataLoadingStatus.failure);
      expect(state.products, isEmpty);
      expect(state.error, 'Error message');
      expect(state.hasErrors, isTrue);
    });

    test('Copy with changes', () {
      final initialState = ProductsState();
      final products = [Product(id: 1, title: 'Product 1')];
      final newState = initialState.copy(
        status: DataLoadingStatus.success,
        products: products,
        error: 'New error',
      );

      expect(newState.status, DataLoadingStatus.success);
      expect(newState.products, products);
      expect(newState.error, 'New error');
      expect(newState.hasErrors, isTrue);


      // Verify original state is unchanged. 
      expect(initialState.status, DataLoadingStatus.initial);
      expect(initialState.products, isEmpty);
      expect(initialState.error, isNull);
    });

    test('Copy with no changes', () {
      final initialState = ProductsState(
        status: DataLoadingStatus.success,
        products: [Product(id: 1)],
        error: "initial error"
      );
      final newState = initialState.copy();

      expect(newState.status, initialState.status);
      expect(newState.products, initialState.products);
      expect(newState.error, initialState.error);
      expect(newState.hasErrors, initialState.hasErrors);
    });
  });
}
