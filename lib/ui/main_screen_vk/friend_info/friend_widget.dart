import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/ui/main_screen_vk/friend_info/friend_info_model.dart';

class FriendInfoWidget extends StatefulWidget {
  const FriendInfoWidget({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FriendInfoWidgetState createState() => _FriendInfoWidgetState();
}

class _FriendInfoWidgetState extends State<FriendInfoWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final error = context.watch<FriendProfileViewModel>().errorTextFriendInfo;
    if (error == true) {
      Future.microtask(() => ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('error'))));
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileFriendsData = context
        .select((FriendProfileViewModel value) => value.profileFriendsState);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.blue,
      ),
      body: profileFriendsData.isLoading
          ? const Center(child: CircularProgressIndicator())
          : const _ProfileFriendsWidget(),
    );
  }
}

class _ProfileFriendsWidget extends StatelessWidget {
  const _ProfileFriendsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<FriendProfileViewModel>();
    return RefreshIndicator(
      onRefresh: () => model.loadFriendInfo(),
      child: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            children: [
              _PhotoAndNameWidget(),
              SizedBox(height: 15),
              _ProfileInfoWidget(),
              SizedBox(height: 15),
              Center(
                  child: Text(
                'Фотографии',
                style: TextStyle(fontSize: 20),
              )),
              SizedBox(height: 15),
              _PhotoViewWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _PhotoAndNameWidget extends StatelessWidget {
  const _PhotoAndNameWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileFriendsData = context
        .select((FriendProfileViewModel value) => value.profileFriendsState);
    return Row(
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: profileFriendsData.photo.isNotEmpty
                ? Image.network(profileFriendsData.photo)
                : const SizedBox.shrink(),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${profileFriendsData.firstName} ${profileFriendsData.lastName}',
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            const SizedBox(height: 10),
          ],
        )
      ],
    );
  }
}

class _ProfileInfoWidget extends StatelessWidget {
  const _ProfileInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileFriendsData = context
        .select((FriendProfileViewModel value) => value.profileFriendsState);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _TextInfoWidget(textInfo: 'Пол', textGet: profileFriendsData.sex),
        _TextInfoWidget(
            textInfo: 'Дата рождения', textGet: profileFriendsData.bdate),
        _TextInfoWidget(
            textInfo: 'Страна', textGet: profileFriendsData.country),
        _TextInfoWidget(textInfo: 'Город', textGet: profileFriendsData.city),
        _TextInfoWidget(
            textInfo: 'Интересы', textGet: profileFriendsData.interests),
        _TextInfoWidget(textInfo: 'Музыка', textGet: profileFriendsData.music),
        _TextInfoWidget(textInfo: 'Фильмы', textGet: profileFriendsData.movies),
        _TextInfoWidget(textInfo: 'Книги', textGet: profileFriendsData.games),
      ],
    );
  }
}

class _TextInfoWidget extends StatelessWidget {
  final String? textInfo;
  final String? textGet;

  const _TextInfoWidget(
      {Key? key, required this.textInfo, required this.textGet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (textGet == null || textGet == '') return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            '$textInfo: $textGet',
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}

class _PhotoViewWidget extends StatelessWidget {
  const _PhotoViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final friendPhoto =
        context.select((FriendProfileViewModel value) => value.friendPhoto);
    return Container(
      decoration: const BoxDecoration(
        border: Border(
            bottom: BorderSide(width: 2, color: Colors.blue),
            top: BorderSide(width: 2, color: Colors.blue)),
      ),
      height: 400,
      width: double.infinity,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: friendPhoto?.response.items?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: _PhotoWidget(index: index),
          );
        },
      ),
    );
  }
}

class _PhotoWidget extends StatelessWidget {
  final int index;
  const _PhotoWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final minPhotoUrl = context
        .select((FriendProfileViewModel value) => value.smallPhotoUrl(index));
    final maxPhotoUrl = context
        .select((FriendProfileViewModel value) => value.largePhotoUrl(index));
    return GestureDetector(
      child: Hero(
        tag: 'tag$index',
        child: minPhotoUrl != ''
            ? Image.network(minPhotoUrl)
            : const SizedBox.shrink(),
      ),
      onTap: () {
        Navigator.push<_DetailScreenWidget>(context,
            MaterialPageRoute(builder: (_) {
          return _DetailScreenWidget(url: maxPhotoUrl);
        }));
      },
    );
  }
}

class _DetailScreenWidget extends StatelessWidget {
  final String url;
  const _DetailScreenWidget({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Hero(
            tag: 'tag',
            child: url != '' ? Image.network(url) : const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
