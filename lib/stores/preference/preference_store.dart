import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:grouu/constants/preference.dart';
import 'package:grouu/data/sqlite/db/database.dart';
import 'package:grouu/data/sqlite/service/preference_service.dart';
import 'package:grouu/di/components/service_locator.dart';
import 'package:grouu/stores/error/error_store.dart';
import 'package:grouu/stores/user/user_store.dart';
import 'package:mobx/mobx.dart';

part 'preference_store.g.dart';

class PreferenceStore = _PreferenceStore with _$PreferenceStore;

abstract class _PreferenceStore with Store {
  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();
  late PreferenceService preferenceService;

  UserStore userStore = getIt<UserStore>();

  BuildContext? preferenceContext;

  // constructor:---------------------------------------------------------------
  _PreferenceStore() {
    // setting up disposers
    preferenceService = PreferenceService();
    _setupDisposers();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
    ];
  }

  @observable
  List<PreferenceItem> listPreferenceItems = [
    PreferenceItem(1, "Birth Club", false),
    PreferenceItem(2, "Parents Life", false),
    PreferenceItem(3, "Komunitas", false),
    PreferenceItem(4, "Kehamilan", false),
    PreferenceItem(5, "Fertilitas", false),
    PreferenceItem(6, "Bayi 0-1 Tahun", false),
    PreferenceItem(7, "Toddler 1-3 Tahun", false),
    PreferenceItem(8, "Balita 4-5 Tahun", false),
  ];

  @action
  void setPreference(int id, bool value) {
    listPreferenceItems = listPreferenceItems.map((e) {
      var pref = e;
      if (e.id == id) {
        pref.active = value;
      }
      return pref;
    }).toList();
  }

  @observable
  dynamic preference;

  @observable
  int preferenceId = 0;

  @observable
  bool success = false;

  @observable
  bool loading = false;

  @observable
  Uint8List? profileImage;

  @action
  void setProfileImage(Uint8List value) {
    profileImage = value;
  }

  @action
  Future addPreference() async {
    loading = true;
    try {
      preference = await preferenceService.addPreference(
        userId: userStore.currentUserId,
        birthClub: listPreferenceItems[0].active,
        parentsLife: listPreferenceItems[1].active,
        community: listPreferenceItems[2].active,
        pregnancy: listPreferenceItems[3].active,
        fertility: listPreferenceItems[4].active,
        baby: listPreferenceItems[5].active,
        toddler: listPreferenceItems[6].active,
        balita: listPreferenceItems[7].active,
      );
      loading = false;
      success = true;
    } catch (e) {
      errorStore.errorMessage = "Something went wrong";
      loading = false;
      success = false;
      print(e);
    }
  }

  @action
  Future updatePreference() async {
    loading = true;
    try {
      await preferenceService.updatePreference(
        id: preference.id,
        birthClub: listPreferenceItems[0].active,
        parentsLife: listPreferenceItems[1].active,
        community: listPreferenceItems[2].active,
        pregnancy: listPreferenceItems[3].active,
        fertility: listPreferenceItems[4].active,
        baby: listPreferenceItems[5].active,
        toddler: listPreferenceItems[6].active,
        balita: listPreferenceItems[7].active,
      );
      loading = false;
      success = true;
    } catch (e) {
      errorStore.errorMessage = "Something went wrong";
      loading = false;
      success = false;
      print(e);
    }
  }

  @action
  Future getPreferenceByUser() async {
    loading = true;
    try {
      print(userStore.currentUserId);
      Preference data =
          await preferenceService.getPreferenceByUser(userStore.currentUserId);
      preference = data;
      preferenceId = data.id;
      listPreferenceItems[0].active = data.birthClub;
      listPreferenceItems[1].active = data.parentsLife;
      listPreferenceItems[2].active = data.community;
      listPreferenceItems[3].active = data.pregnancy;
      listPreferenceItems[4].active = data.fertility;
      listPreferenceItems[5].active = data.baby;
      listPreferenceItems[6].active = data.toddler;
      listPreferenceItems[7].active = data.balita;
      loading = false;
    } catch (e) {
      preference = null;
      preferenceId = 0;
      listPreferenceItems = listPreferenceItems.map((e) {
        e.active = false;
        return e;
      }).toList();
      print(e);
      loading = false;

      print(e);
    }
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }

    success = false;
    loading = false;
  }
}
