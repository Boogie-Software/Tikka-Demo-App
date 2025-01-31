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
import 'package:go_router/go_router.dart';
import 'package:injector/injector.dart';
import 'package:tikka_demo_app/app/route_path.dart';
import 'package:tikka_demo_app/presentation/home/home_controller.dart';
import 'package:tikka_demo_app/framework/ui/home/home_page.dart';
import 'package:tikka_demo_app/presentation/login/login_controller.dart';
import 'package:tikka_demo_app/framework/ui/login/login_page.dart';
import 'package:tikka_demo_app/presentation/products/products_controller.dart';
import 'package:tikka_demo_app/framework/ui/products/products_page.dart';

// GoRouter based navigation implementation
final router = GoRouter(
  routes: [
    GoRoute(
      path: RoutePath.home,
      builder: (context, state) {
        return HomePage(_get<HomeController>(), key: Key('page_home'), title: 'Home');
      },
      routes: [
        GoRoute(
          path: RoutePath.login.relative(),
          builder: (context, state) {
            return LoginPage(_get<LoginController>(), key: Key('page_login'));
          }
        ),
        GoRoute(
          path: RoutePath.products.relative(),
          builder: (context, state) {
            return ProductsPage(_get<ProductsController>(), key: Key('page_products'));
          }
        ),
      ]
    )
  ]
);

T _get<T>({String dependencyName = ""}) => Injector.appInstance.get<T>(dependencyName: dependencyName);

extension on String {
  relative() => replaceFirst("/", "");
}
