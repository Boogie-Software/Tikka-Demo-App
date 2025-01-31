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
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';
import 'package:tikka_demo_app/app/app_lifecycle_observer.dart';
import 'package:tikka_demo_app/app/app_router.dart';
import 'package:tikka_demo_app/domain/repository_interface/settings_repository.dart';
import 'package:tikka_demo_app/domain/service_interface/audio_service.dart';
import 'package:tikka_demo_app/domain/use_case/login_bloc.dart';
import 'package:tikka_demo_app/adapter/repository/settings_data_source.dart';
import 'package:tikka_demo_app/adapter/service/audio_manager.dart';
import 'package:tikka_demo_app/framework/theme/color_palette.dart';
import 'package:tikka_demo_app/framework/theme/material_colors.dart';

class TikkaApp extends StatelessWidget {
  const TikkaApp({super.key});

  // The root widget of this application.
  @override
  Widget build(BuildContext context) {
    return AppLifecycleObserver(
      child: MultiProvider(
        // Add Providers here for global dependency injection
        providers: [
          Provider(create: (context) => ColorPalette()),
          Provider(create: (context) => get<LoginBloc>()),
          Provider(create: (context) => get<AudioManager>()),
          Provider(create: (context) => get<AudioService>()),
          Provider(create: (context) => get<SettingsRepository>()),
          Provider(create: (context) => get<SettingsDataSource>())
        ],
        child: Builder(builder: (context) {
          final palette = context.watch<ColorPalette>();

          return MaterialApp.router(
            title: 'Tikka Demo App',
            theme: ThemeData.from(
              colorScheme: ColorScheme.fromSeed(
                seedColor: MaterialColors.blueGrey800,
                surface: palette.backgroundAnyPage,
              ),
              textTheme: TextTheme(
                bodyMedium: TextStyle(color: palette.ink),
              ),
              useMaterial3: true,
            ).copyWith(
              // Make buttons more fun.
              filledButtonTheme: FilledButtonThemeData(
                style: FilledButton.styleFrom(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            routerConfig: router,
          );
        }),
      ),
    );
  }

  // A utility method for dependency injection
  T get<T>({String dependencyName = ""}) => Injector.appInstance.get<T>(dependencyName: dependencyName);
}
