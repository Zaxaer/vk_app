import 'package:flutter/material.dart';

import 'package:vk_app/domain/api_client/api_client_exaption.dart';
import 'package:vk_app/domain/entity/list_friends.dart';
import 'package:vk_app/domain/services/data_service.dart';
import 'package:vk_app/navigation/main_navigation.dart';

class MyListFriendData {
  final String photo;
  final String lastName;
  final String firstName;
  final int id;
  final int status;
  MyListFriendData({
    required this.photo,
    required this.lastName,
    required this.firstName,
    required this.id,
    required this.status,
  });
}

class _TabDataWidget {
  List<Tab> myTabs = const <Tab>[
    Tab(child: Text('Все друзья')),
    Tab(child: Text('Онлайн')),
  ];
}

class MyListFriendViewModel extends ChangeNotifier {
  final DataService _dataService;
  final tabData = _TabDataWidget();
  var _listFriend = <MyListFriendData>[];
  var errorTextListFriend = false;
  List<MyListFriendData> get listFriend => _listFriend;

  MyListFriendViewModel(
    this._dataService,
  ) {
    loadProfileListFriend();
  }

  Future<void> loadProfileListFriend() async {
    try {
      errorTextListFriend = false;
      final listFriend = await _dataService.loadProfileListFriend();
      updateScreen(listFriend);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionTipe.network:
          errorTextListFriend = true;
          notifyListeners();
          break;
      }
    }
  }

  void updateScreen(ListFriend listFriend) {
    if (listFriend.response.items.isEmpty) {
      notifyListeners();
      return;
    }
    _listFriend =
        listFriend.response.items.map<MyListFriendData>(_makeRowData).toList();
    notifyListeners();
  }

  MyListFriendData _makeRowData(Item item) {
    return MyListFriendData(
        firstName: item.firstName ?? '',
        id: item.id ?? 87473106,
        lastName: item.lastName ?? '',
        photo: item.photo_100 ?? '',
        status: item.online ?? 0);
  }

  void navigatorToFriendInfo(BuildContext context, int userId) {
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.friendInfo,
      arguments: userId,
    );
  }

  List<MyListFriendData> onlineFriendInfo() {
    final onlineFriend =
        _listFriend.where((element) => element.status == 1).toList();
    return onlineFriend;
  }

  int? status(int index) {
    final status = _listFriend[index].status;
    return status;
  }
}
