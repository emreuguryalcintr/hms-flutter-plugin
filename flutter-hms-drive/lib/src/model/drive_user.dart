/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License")
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import 'dart:convert';

/// User details class.
class DriveUser {
  /// Resource type. The value is always drive#user.
  String? category;

  /// Display name of the user.
  String? displayName;

  /// Whether a user is the current requesting user.
  bool? me;

  /// ID of the user's permission.
  String? permissionId;

  /// Link to the user's profile picture.
  String? profilePhotoLink;

  ///	Account of the user.
  String? userAccount;

  DriveUser({
    this.category,
    this.displayName,
    this.me,
    this.permissionId,
    this.profilePhotoLink,
    this.userAccount,
  });

  DriveUser clone({
    String? category,
    String? displayName,
    bool? me,
    String? permissionId,
    String? profilePhotoLink,
    String? userAccount,
  }) {
    return DriveUser(
      category: category ?? this.category,
      displayName: displayName ?? this.displayName,
      me: me ?? this.me,
      permissionId: permissionId ?? this.permissionId,
      profilePhotoLink: profilePhotoLink ?? this.profilePhotoLink,
      userAccount: userAccount ?? this.userAccount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'displayName': displayName,
      'me': me,
      'permissionId': permissionId,
      'profilePhotoLink': profilePhotoLink,
      'userAccount': userAccount,
    };
  }

  factory DriveUser.fromMap(Map<String, dynamic>? map) {
    if (map == null) return DriveUser();

    return DriveUser(
      category: map['category'],
      displayName: map['displayName'],
      me: map['me'],
      permissionId: map['permissionId'],
      profilePhotoLink: map['profilePhotoLink'],
      userAccount: map['userAccount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DriveUser.fromJson(String source) =>
      DriveUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(category: $category, displayName: $displayName, me: $me, permissionId: $permissionId, profilePhotoLink: $profilePhotoLink, userAccount: $userAccount)';
  }
}
