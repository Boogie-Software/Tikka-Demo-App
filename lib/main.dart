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

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injector/injector.dart';
import 'package:tikka_demo_app/presentation/home/home_controller.dart';
import 'package:tikka_demo_app/presentation/home/home_presenter.dart';
import 'package:tikka_demo_app/presentation/home/home_view_state.dart';
import 'package:tikka_demo_app/presentation/login/login_controller.dart';
import 'package:tikka_demo_app/presentation/login/login_presenter.dart';
import 'package:tikka_demo_app/presentation/login/login_view_state.dart';
import 'package:tikka_demo_app/presentation/products/products_controller.dart';
import 'package:tikka_demo_app/presentation/products/products_presenter.dart';
import 'package:tikka_demo_app/presentation/products/products_view_state.dart';
import 'package:tikka_demo_app/domain/repository_interface/settings_repository.dart';
import 'package:tikka_demo_app/domain/service_interface/audio_service.dart';
import 'package:tikka_demo_app/domain/service_interface/login_service.dart';
import 'package:tikka_demo_app/domain/use_case/login_bloc.dart';
import 'package:tikka_demo_app/domain/use_case/products_bloc.dart';
import 'package:tikka_demo_app/domain/repository_interface/products_repository.dart';
import 'package:tikka_demo_app/adapter/repository/settings_data_source.dart';
import 'package:tikka_demo_app/adapter/repository/products_repository_impl.dart';
import 'package:tikka_demo_app/adapter/repository/settings_repository_impl.dart';
import 'package:tikka_demo_app/adapter/api_interface/login_api.dart';
import 'package:tikka_demo_app/adapter/data_source_interface/products_data_source.dart';
import 'package:tikka_demo_app/adapter/service/audio_manager.dart';
import 'package:tikka_demo_app/adapter/service/audio_service_impl.dart';
import 'package:tikka_demo_app/adapter/service/login_service_impl.dart';
import 'package:tikka_demo_app/framework/data_source/products_data_source_impl.dart';
import 'package:tikka_demo_app/framework/data_source/shared_preferences_settings_data_source.dart';
import 'package:tikka_demo_app/framework/api/login_api_impl.dart';
import 'package:tikka_demo_app/framework/ui/audio_manager_impl.dart';
import 'app/tikka_app.dart';

// Then main function
void main() async {
  // Optional set up for loggin
  /*
  Logger.root.level = kDebugMode ? Level.FINE : Level.INFO;
  Logger.root.onRecord.listen((record) {
    dev.log(
      record.message,
      time: record.time,
      level: record.level.value,
      name: record.loggerName,
    );
  });*/

  WidgetsFlutterBinding.ensureInitialized();
  
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  setupInjector();
  
  runApp(const TikkaApp());
}

T get<T>({String dependencyName = ""}) => Injector.appInstance.get<T>(dependencyName: dependencyName);

// Sets up the dependencies by using Injector
void setupInjector() {
  final Injector injector = Injector.appInstance;

  injector
  ..registerSingleton<LoginBloc>(() { return LoginBloc(); })
  ..registerSingleton<ProductsBloc>(() { return ProductsBloc(); })

  ..registerSingleton<Dio>(() { return Dio(); })

  ..registerSingleton<AudioManager>(() { return AudioManagerImpl(); })
  ..registerSingleton<AudioService>(() { return AudioServiceImpl(); })
  
  ..registerSingleton<LoginService>(() { return LoginServiceImpl(); })
  ..registerSingleton<LoginApi>(() { return LoginApiImpl(); })
  
  ..registerSingleton<ProductsRepository>(() { return ProductsRepositoryImpl(); })
  ..registerSingleton<ProductsDataSource>(() { return ProductsDataSourceImpl(); })

  ..registerSingleton<SettingsRepository>(() { return SettingsRepositoryImpl(); })
  ..registerSingleton<SettingsDataSource>(() { return SharedPreferencesSettingsDataSource(); })

  ..registerDependency<HomeViewState>(() { return HomeViewState(); })
  ..registerDependency<HomePresenter>(() { return HomePresenter(get<HomeViewState>()); })
  ..registerDependency<HomeController>(() { return HomeController(get<HomePresenter>()); })

  ..registerDependency<LoginViewState>(() { return LoginViewState(); })
  ..registerDependency<LoginPresenter>(() { return LoginPresenter(get<LoginViewState>()); })
  ..registerDependency<LoginController>(() { return LoginController(get<LoginPresenter>()); })

  ..registerDependency<ProductsViewState>(() { return ProductsViewState(); })
  ..registerDependency<ProductsPresenter>(() { return ProductsPresenter(get<ProductsViewState>()); })
  ..registerDependency<ProductsController>(() { return ProductsController(get<ProductsPresenter>()); });
}

