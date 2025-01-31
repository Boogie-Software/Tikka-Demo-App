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

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tikka_demo_app/adapter/repository/settings_data_source.dart';
import 'package:tikka/framework/abstract_data_source.dart';

class SharedPreferencesSettingsDataSource extends AbstractDataSource implements SettingsDataSource {

  final Future<SharedPreferences> sharedPreferencesFuture =
      SharedPreferences.getInstance();
      
  @override
  Future<bool> getSoundsOn({required bool defaultValue}) async {
    final future = await sharedPreferencesFuture;
    return future.getBool('soundsOn') ?? defaultValue;
  }

  @override
  Future<void> saveSoundsOn(bool value) async {
    final future = await sharedPreferencesFuture;
    await future.setBool('soundsOn', value);
  }

}