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

import 'package:tikka_demo_app/domain/use_case/products_bloc.dart';
import 'package:tikka_demo_app/domain/use_case/products_intent.dart';
import 'package:tikka_demo_app/presentation/products/products_presenter.dart';
import 'package:tikka_demo_app/presentation/products/products_view_event.dart';
import 'package:tikka/presentation/controller.dart';

class ProductsController extends Controller<ProductsViewEvent, ProductsPresenter> {

  ProductsController(super.presenter);

  @override
  onViewEvent(ProductsViewEvent event) async {

    switch (event) {
      case OnPageShown _:
        final bloc = get<ProductsBloc>();
        bloc.subscribe(this, (state) { 
          presenter.onProductsStateChanged(state); 
          if (state.status.isFinished) { bloc.unsubscribe(this); }
        });
        bloc.add(GetProducts());
    }
  }

}