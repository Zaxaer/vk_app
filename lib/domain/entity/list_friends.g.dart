// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_friends.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListFriend _$ListFriendFromJson(Map<String, dynamic> json) => ListFriend(
      response: Response.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ListFriendToJson(ListFriend instance) =>
    <String, dynamic>{
      'response': instance.response,
    };

Response _$ResponseFromJson(Map<String, dynamic> json) => Response(
      count: json['count'] as int,
      items: (json['items'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
      'count': instance.count,
      'items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      firstName: json['first_name'] as String?,
      id: json['id'] as int?,
      lastName: json['last_name'] as String?,
      canAccessClosed: json['can_access_closed'] as bool?,
      isClosed: json['is_closed'] as bool?,
      domain: json['domain'] as String?,
      city: json['city'] == null
          ? null
          : City.fromJson(json['city'] as Map<String, dynamic>),
      canInviteToChats: json['can_invite_to_chats'] as bool?,
      trackCode: json['trackCode'] as String?,
      online: json['online'] as int?,
      photo_100: json['photo_100'] as String?,
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'first_name': instance.firstName,
      'id': instance.id,
      'last_name': instance.lastName,
      'can_access_closed': instance.canAccessClosed,
      'is_closed': instance.isClosed,
      'domain': instance.domain,
      'city': instance.city,
      'can_invite_to_chats': instance.canInviteToChats,
      'trackCode': instance.trackCode,
      'photo_100': instance.photo_100,
      'online': instance.online,
    };

City _$CityFromJson(Map<String, dynamic> json) => City(
      id: json['id'] as int?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
