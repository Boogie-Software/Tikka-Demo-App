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

import 'package:tikka_demo_app/domain/repository_interface/settings_repository.dart';
import 'package:tikka_demo_app/adapter/repository/settings_data_source.dart';
import 'package:tikka/adapters/abstract_repository.dart';

class SettingsRepositoryImpl extends AbstractRepository implements  SettingsRepository {

  late final SettingsDataSource _settingsDataSource;
  bool _soundsOn = true;
  
  @override
  bool get isSoundsOn => _soundsOn;

  SettingsRepositoryImpl() {
    _settingsDataSource = get<SettingsDataSource>();
    _loadStateFromPersistence();
  }
  
  @override
  void toggleSoundsOn() {
    _soundsOn = !_soundsOn;
    _settingsDataSource.saveSoundsOn(_soundsOn);
  }

  Future<void> _loadStateFromPersistence() async {
    await Future.wait([
      _settingsDataSource
          .getSoundsOn(defaultValue: true)
          .then((value) => _soundsOn = value)
    ]);
  }
  
}