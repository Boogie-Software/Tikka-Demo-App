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

import 'package:flutter/material.dart';
import 'package:tikka_demo_app/presentation/products/products_controller.dart';
import 'package:tikka_demo_app/presentation/products/products_view_event.dart';
import 'package:tikka_demo_app/presentation/products/products_view_state.dart';
import 'package:tikka_demo_app/framework/theme/material_colors.dart';
import 'package:tikka/ui/page/tikka_page.dart';
import 'package:tikka/ui/page/tikka_page_state.dart';

class ProductsPage extends TikkaPage<ProductsController> {
 
  const ProductsPage(super.controller, {super.key});
  
  @override
  State<StatefulWidget> createState() => _ProductsPageState();
}

class _ProductsPageState extends TikkaPageState<ProductsController, ProductsViewState, ProductsPage> {
  
  @override
  Widget build(BuildContext context) {

    if (viewState.loadingStatus.isInitial) {
      controller.onViewEvent(OnPageShown());
    }
    
    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: (viewState.loadingStatus.isSuccess) ? 
         Padding(
          padding: EdgeInsets.all(16),
          child: 
            ListView.builder(
              itemCount: viewState.products.length,
              itemBuilder: (context, index) {
                final product = viewState.products[index];
                return Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                  child: ListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    tileColor: MaterialColors.blueGrey100,
                    title: Text(product.title),
                    subtitle: Text(product.description),
                    contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                  ),
                );
              },
            ),
          ) :
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: CircularProgressIndicator())
            ],
          )
        )
      );
  }
}
