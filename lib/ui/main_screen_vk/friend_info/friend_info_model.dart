import 'package:flutter/material.dart';

import 'package:vk_app/domain/api_client/api_client_exaption.dart';
import 'package:vk_app/domain/entity/friend_info.dart';
import 'package:vk_app/domain/entity/profile_photo.dart';
import 'package:vk_app/domain/services/data_service.dart';

class _FriendProfileState {
  bool isLoading = true;
  String firstName = '';
  String lastName = '';
  String photo = '';
  String sex = '';
  String? bdate = '';
  String? country = '';
  String? city = '';
  String? interests = '';
  String? music = '';
  String? movies = '';
  String? games = '';
}

class FriendProfileViewModel extends ChangeNotifier {
  final profileFriendsState = _FriendProfileState();
  final DataService dataService;
  int userId;
  MyPhoto? _userPhoto;
  MyPhoto? get friendPhoto => _userPhoto;
  var errorTextFriendInfo = false;

  FriendProfileViewModel({required this.userId, required this.dataService}) {
    _initScreen();
  }

  void _initScreen() async {
    await loadFriendInfo();
  }

  Future<void> loadFriendInfo() async {
    try {
      final userInfo = await dataService.loadFriendInfo(userId);
      _updateProfileFriend(userInfo);
      await loadFriendPhoto();
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionTipe.network:
          errorTextFriendInfo = true;
          notifyListeners();
          break;
      }
    }
  }

  void _updateProfileFriend(FriendInfo? userInfo) {
    profileFriendsState.isLoading = userInfo == null;
    if (userInfo == null) {
      notifyListeners();
      return;
    }
    profileFriendsState.firstName = userInfo.response.first.firstName;
    profileFriendsState.lastName = userInfo.response.first.lastName;
    profileFriendsState.photo = userInfo.response.first.photo_100 ?? '';
    profileFriendsState.sex = genderSelect(userInfo);
    profileFriendsState.bdate = userInfo.response.first.bdate;
    profileFriendsState.country = userInfo.response.first.country?.title;
    profileFriendsState.city = userInfo.response.first.city?.title;
    profileFriendsState.interests = userInfo.response.first.interests;
    profileFriendsState.music = userInfo.response.first.music;
    profileFriendsState.movies = userInfo.response.first.movies;
    profileFriendsState.games = userInfo.response.first.games;
    notifyListeners();
  }

  String genderSelect(FriendInfo? userInfo) {
    var gender = '';
    if (userInfo?.response.first.gender == null) {
      gender = 'Не выбран';
    } else {
      switch (userInfo?.response.first.gender) {
        case (1):
          gender = 'Жениский';
          break;
        case (2):
          gender = 'Мужской';
      }
    }
    return gender;
  }

  String smallPhotoUrl(int index) {
    final url = _userPhoto?.response.items?[index].sizes?[2].url;
    return url ?? '';
  }

  String largePhotoUrl(int index) {
    final url = _userPhoto?.response.items?[index].sizes?.last.url;
    return url ?? '';
  }

  Future<void> loadFriendPhoto() async {
    final userPhoto = await dataService.myPhotoFriend(userId);
    _userPhoto = userPhoto;
    notifyListeners();
  }
}
