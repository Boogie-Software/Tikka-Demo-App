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
import 'package:tikka_demo_app/framework/theme/material_colors.dart';

class ColorPalette {
  Color get enabledIcon => MaterialColors.blueGrey900; // const Color(0xff455a64);
  Color get disabledIcon => MaterialColors.blueGrey200; //const Color(0xffcfd8dc);
  Color get enabledText => MaterialColors.blueGrey900; //const Color(0xff455a64);
  Color get disabledText => MaterialColors.blueGrey200; //const Color(0xffcfd8dc);  
  Color get pen => const Color(0xff1d75fb);
  Color get darkPen => const Color(0xFF0050bc);
  Color get redPen => const Color(0xFFd10841);
  Color get inkFullOpacity => const Color(0xff352b42);
  Color get ink => const Color(0xee352b42);
  Color get backgroundAnyPage => white;
  Color get backgroundHomePage => backgroundAnyPage;
  Color get backgroundInfoPage => backgroundAnyPage;
  Color get backgroundLevelsPage => backgroundAnyPage;
  Color get backgroundPuzzlePage => backgroundAnyPage;
  Color get background4 => const Color(0xffffd7ff);
  Color get backgroundSettingsPage => backgroundAnyPage;
  Color get white => const Color(0xffffffff);

  Color get textPageTitle => MaterialColors.blueGrey900;

  Color get puzzleUnsolved => MaterialColors.blueGrey800;
  Color get puzzleSolved => MaterialColors.greenA700;
  Color get puzzleFailed => MaterialColors.redA700;
}
