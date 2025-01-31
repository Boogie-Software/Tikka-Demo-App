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
import 'package:tikka/presentation/view_state.dart';

class LoginViewState implements ViewState {
  
  final String userName;
  final String password;
  final DataLoadingStatus loadingStatus;

  LoginViewState({this.userName = "", this.password = "", this.loadingStatus = DataLoadingStatus.initial});

  LoginViewState copy({String? userName, String? password, DataLoadingStatus? loadingStatus}) =>
    LoginViewState(
      userName: userName ?? this.userName, 
      password: password ?? this.password,
      loadingStatus: loadingStatus ?? this.loadingStatus
    );
}