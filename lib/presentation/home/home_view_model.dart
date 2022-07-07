import 'package:flutter/material.dart';
import 'package:ric_and_mort_movie/presentation/characters/list/characters_screen.dart';
import 'package:ric_and_mort_movie/presentation/episodes/list/episodes_screen.dart';
import 'package:ric_and_mort_movie/presentation/locations/list/locations_screen.dart';
import 'package:ric_and_mort_movie/presentation/settings/settings_screen.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  List<Widget> pages = <Widget>[
    const CharactersScreen(),
    const EpisodesScreen(),
    const LocationsScreen(),
    const SettingsScreen()
  ];

  int selectedIndex = 0;

  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  Widget getPages() => pages.elementAt(selectedIndex);
}
