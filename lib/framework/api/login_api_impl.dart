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
import 'package:tikka_demo_app/adapter/api_interface/login_api.dart';
import 'package:tikka/util/rest_response.dart';
import 'package:tikka/framework/abstract_api.dart';

class LoginApiImpl extends AbstractApi implements LoginApi {

  static const baseUrl = "https://dummyjson.com/";
  static const loginUrl = "user/login";
  static const productsUrl = "products";

  @override
  Future<RestResponse> login(String userName, String password) async {
    var headers = {
      'Content-Type': 'application/json',
    };

    final dio = get<Dio>();

    dio.options.baseUrl = baseUrl;
    dio.options.headers.addAll(headers);
    
    final body = {
          'username': userName,
          'password': password,
          'expiresInMins': 30
        };

    try {
      final response = await dio.post(loginUrl, data: body);

      if (response.statusCode == 200) {
        return Success<Map<String, dynamic>>(response.data);
      } else {
        String error = "Failed to perform login. Error: ${response.statusMessage}";
        return Failure(error);
      }
    } on DioException catch (dioException, _) {
      String error = "Failed to perform login. Exception: ${dioException.message}";
      return Failure(error);
    } catch(e) {
      String error = "Failed to perform login. Exception: $e";
      return Failure(error);
    }
  }

}