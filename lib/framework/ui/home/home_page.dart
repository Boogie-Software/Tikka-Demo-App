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
import 'package:provider/provider.dart';
import 'package:tikka_demo_app/app/route_path.dart';
import 'package:tikka_demo_app/domain/service_interface/audio_service.dart';
import 'package:tikka_demo_app/presentation/home/home_controller.dart';
import 'package:tikka_demo_app/presentation/home/home_view_state.dart';
import 'package:tikka_demo_app/framework/theme/color_palette.dart';
import 'package:tikka_demo_app/framework/theme/constants.dart';
import 'package:tikka/ui/widget/spacings.dart';
import 'package:tikka/ui/page/tikka_page.dart';
import 'package:tikka/ui/page/tikka_page_state.dart';

class HomePage extends TikkaPage<HomeController> {

  final String title;

  const HomePage(super.controller,{super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends TikkaPageState<HomeController, HomeViewState, HomePage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Image.asset('assets/images/tikka_logo_512x512.png', width: 512, height: 512 ), 
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                createScreenButton(
                  context, 
                  'Login Demo', 
                  Icons.login, 
                  () { GoRouter.of(context).push(RoutePath.login); }, 
                  width: 220),
            
                createScreenButton(
                  context, 
                  'Products List Demo', 
                  Icons.store_outlined, 
                  () { GoRouter.of(context).push(RoutePath.products); }, 
                  width: 220),
                Spacings.spacing32
              ],
            ),
          ),
        ]
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () { GoRouter.of(context).push(RoutePath.login); },
      //   tooltip: 'Login',
      //   child: const Icon(Icons.login),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  OutlinedButton createScreenButton(BuildContext context, String text, IconData icon, Function()? onPressedFunction, {double width = 140}) =>
    OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
      ),
      onPressed: () {
        context.read<AudioService>().playButtonPressSfx();
        onPressedFunction?.call();
      }, 
      child: SizedBox(
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon,
              color: context.watch<ColorPalette>().enabledIcon,
              size: Constants.screenButtonIconSize,
            ),
            Spacings.spacing8,
            Text(text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Jura',
                fontSize: Constants.screenButtonFontSize,
                height: 1,
                fontStyle: FontStyle.normal,
                fontWeight: Constants.screenButtonFontWeight
              ),
            ),
          ],
        ),
      ),
    );  
}