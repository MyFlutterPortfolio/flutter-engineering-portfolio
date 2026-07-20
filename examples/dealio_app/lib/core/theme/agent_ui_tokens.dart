import 'package:flutter/material.dart';

class AgentUiTokens {
  const AgentUiTokens._();

  static bool compact(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 390;

  static double screenPadding(BuildContext context) =>
      compact(context) ? 14 : 16;

  static double sectionGap(BuildContext context) => compact(context) ? 10 : 12;

  static double headerTitleSize(BuildContext context) =>
      compact(context) ? 22 : 23;

  static double cardRadius(BuildContext context) => compact(context) ? 17 : 18;

  static double largeRadius(BuildContext context) => compact(context) ? 20 : 22;

  static double cardPadding(BuildContext context) => compact(context) ? 12 : 14;

  static double iconButton(BuildContext context) => compact(context) ? 34 : 36;

  static double iconBox(BuildContext context) => compact(context) ? 32 : 34;
}
