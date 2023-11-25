import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/domain/services/data_service.dart';
import 'package:vk_app/ui/auth_vk/auth_widget.dart';
import 'package:vk_app/ui/auth_vk/web_view_model.dart';
import 'package:vk_app/ui/auth_vk/web_view_widget.dart';
import 'package:vk_app/ui/main_screen_vk/friend_info/friend_info_model.dart';
import 'package:vk_app/ui/main_screen_vk/friend_info/friend_widget.dart';
import 'package:vk_app/ui/main_screen_vk/list_friend/list_friend_model.dart';
import 'package:vk_app/ui/main_screen_vk/list_friend/list_friends_widget.dart';
import 'package:vk_app/ui/main_screen_vk/loader_widget/loader_view_model.dart';
import 'package:vk_app/ui/main_screen_vk/loader_widget/loader_widget.dart';
import 'package:vk_app/ui/main_screen_vk/main_screen/main_screen_widget.dart';
import 'package:vk_app/ui/main_screen_vk/news_feed/news_feed_model.dart';
import 'package:vk_app/ui/main_screen_vk/news_feed/news_feed_widget.dart';
import 'package:vk_app/ui/main_screen_vk/profile/profile_model.dart';
import 'package:vk_app/ui/main_screen_vk/profile/profile_widget.dart';

class ScreenFactory {
  final dataService = DataService();
  Widget makeLoader() {
    return Provider(
      create: (context) => LoaderViewModel(context),
      lazy: false,
      child: const LoaderWidget(),
    );
  }

  Widget makeWebView() {
    return Provider(
      create: (_) => WebViewWidgetViewModel(),
      child: const WebViewScreenWidget(),
    );
  }

  Widget makeAuth() {
    return const AuthWidgetWidget();
  }

  Widget makeMainScreen() {
    return const MainScreenWidget();
  }

  Widget makeProfile() {
    return ChangeNotifierProvider(
      child: const ProfileScreenWidget(),
      create: (_) => ProfileViewModel(),
    );
  }

  Widget makeMyListFriend() {
    return ChangeNotifierProvider(
      child: const MyListFriendWidget(),
      create: (_) => MyListFriendViewModel(dataService),
    );
  }

  Widget makeNewsFeed() {
    return ChangeNotifierProvider(
      child: const NewsFeedWidget(),
      create: (_) => NewsFeedWidgetViewModel(),
    );
  }

  Widget makeProfileFriends(int userId) {
    return ChangeNotifierProvider(
      child: const FriendInfoWidget(),
      create: (_) => FriendProfileViewModel(
        userId: userId,
        dataService: dataService,
      ),
    );
  }
}
