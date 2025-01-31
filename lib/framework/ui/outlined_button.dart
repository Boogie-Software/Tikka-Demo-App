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
import 'package:provider/provider.dart';
import 'package:tikka_demo_app/domain/service_interface/audio_service.dart';
import 'package:tikka_demo_app/framework/theme/color_palette.dart';
import 'package:tikka_demo_app/framework/theme/constants.dart';
import 'package:tikka/ui/widget/spacings.dart';


OutlinedButton outlinecreateScreenButton(BuildContext context, String text, IconData icon, Function()? onPressedFunction, {double width = 140}) =>
    OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
      ),
      onPressed: () {
        context.watch<AudioService>().playButtonPressSfx();
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