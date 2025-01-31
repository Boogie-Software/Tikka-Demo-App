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
import 'package:tikka_demo_app/domain/entity/products_state.dart';
import 'package:tikka_demo_app/domain/repository_interface/products_repository.dart';
import 'package:tikka_demo_app/domain/use_case/products_intent.dart';
import 'package:tikka/util/rest_response.dart';
import 'package:tikka/domain/use_case/use_case_bloc.dart';

class ProductsBloc extends UseCaseBloc<ProductsState, ProductsIntent>  {

  ProductsBloc() : super(ProductsState()) {
    on<GetProducts>((event, emit) async {
      final repository = get<ProductsRepository>();

      emit(state.copy(status: DataLoadingStatus.loading));
      
      final response = await repository
        .getProducts()
        .whenComplete(() {})
        .catchError((error) { return Failure(error.toString()); });

      if (response is Success) {
        emit(state.copy(status: DataLoadingStatus.success, products: response.data));
      } else {
        emit(state.copy(status: DataLoadingStatus.failure));
      }
    }); 
  }
}