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
import 'package:tikka_demo_app/presentation/login/login_controller.dart';
import 'package:tikka_demo_app/presentation/login/login_view_event.dart';
import 'package:tikka_demo_app/presentation/login/login_view_state.dart';
import 'package:tikka/ui/page/tikka_page.dart';
import 'package:tikka/ui/page/tikka_page_state.dart';

class LoginPage extends TikkaPage<LoginController> {
 
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginPage(super.controller, {super.key});
  
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends TikkaPageState<LoginController, LoginViewState, LoginPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: viewState.loadingStatus.isSuccess
        ? Padding(
          padding: EdgeInsets.all(16),
          child: 
          Center(child: Text('Login succeeded!', style: TextStyle(color: Colors.green, fontSize: 24))),
        )
        : viewState.loadingStatus.isFailure 
        ? Padding(
          padding: EdgeInsets.all(16),
          child: 
          Center(child: Text('Login failed!', style: TextStyle(color: Colors.red, fontSize: 24))),
        )
        : Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: widget._usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: widget._passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: viewState.loadingStatus.isLoading
                    ? null // Disable button while loading
                    : () {
                        final userName = widget._usernameController.text;
                        final password = widget._passwordController.text;
                        controller.onViewEvent(LoginButtonPressed(userName, password));
                      },
                child: viewState.loadingStatus.isLoading
                    ? CircularProgressIndicator() // Show indicator
                    : Text('Login'),
              ),
            ],
          )
        )
      );
  }
}
