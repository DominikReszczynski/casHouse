import 'package:flutter/material.dart';

String apiUrl = "http://10.0.2.2:3000";

// ! Chosen section
ValueNotifier<Sections> chosenSectionNotifier =
    ValueNotifier<Sections>(Sections.Home);

// ! Chosen mode
ValueNotifier<ThemeMode> chosenMode = ValueNotifier(ThemeMode.light);

enum Sections {
  Home,
  User,
  Dashboard,
  Shopping,
  Family,
}

// ? Function to update chosenSection value
void changeChosenSection(Sections selectedSection) {
  chosenSectionNotifier.value = selectedSection;
}
