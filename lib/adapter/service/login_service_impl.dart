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


import 'package:tikka_demo_app/domain/service_interface/login_service.dart';
import 'package:tikka_demo_app/adapter/api_interface/login_api.dart';
import 'package:tikka/adapters/abstract_service.dart';
import 'package:tikka/util/rest_response.dart';

class LoginServiceImpl extends AbstractService implements LoginService {

  @override
  Future<RestResponse> login(String username, String password) async {
    LoginApi api = get<LoginApi>();
    
    try {
      final response = await api.login(username, password);

      if (response is Success) {
        return Success("");
      } else {
        return response as Failure;
      }
    } catch (e) {
      return Failure("Failed to perform login. Error: $e");
    }
  }

}