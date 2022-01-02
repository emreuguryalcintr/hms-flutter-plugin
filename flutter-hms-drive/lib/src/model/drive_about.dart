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

import 'storage_quota.dart';
import 'drive_user.dart';

class DriveAbout {
  /// Resource type, for example, `drive#about`.
  final String? category;

  /// Maximum size of a file that can be uploaded.
  final int? maxFileUploadSize;

  /// Maximum thumbnail size, in bytes.
  final int?maxThumbnailSize;

  /// Checks whether a user needs to update the security policy.
  final bool? needUpdate;

  /// Storage quota limits and usage of a user,
  final StorageQuota? storageQuota;

  /// Storage quota limits and usage of a user,
  final DriveUser? user;

  /// URL of the web page for updating the security policy.
  ///
  /// When the value of needUpdate is true, a URL is returned to the app. In this
  /// case, the app needs to call a browser to open the user authorization page.
  final String? updateUrl;

  DriveAbout({
    this.category,
    this.maxFileUploadSize,
    this.maxThumbnailSize,
    this.needUpdate,
    this.storageQuota,
    this.user,
    this.updateUrl,
  });

  DriveAbout clone({
    String? category,
    int? maxFileUploadSize,
    int? maxThumbnailSize,
    bool? needUpdate,
    StorageQuota? storageQuota,
    DriveUser? user,
    String? updateUrl,
  }) {
    return DriveAbout(
      category: category ?? this.category,
      maxFileUploadSize: maxFileUploadSize ?? this.maxFileUploadSize,
      maxThumbnailSize: maxThumbnailSize ?? this.maxThumbnailSize,
      needUpdate: needUpdate ?? this.needUpdate,
      storageQuota: storageQuota ?? this.storageQuota,
      user: user ?? this.user,
      updateUrl: updateUrl ?? this.updateUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'maxFileUploadSize': maxFileUploadSize,
      'maxThumbnailSize': maxThumbnailSize,
      'needUpdate': needUpdate,
      'storageQuota': storageQuota?.toMap(),
      'user': user?.toMap(),
      'updateUrl': updateUrl,
    };
  }

  factory DriveAbout.fromMap(Map<String, dynamic>? map) {
    if (map == null) return DriveAbout();

    return DriveAbout(
      category: map['category'],
      maxFileUploadSize: map['maxFileUploadSize'] != null
          ? int.parse(map['maxFileUploadSize'])
          : null,
      maxThumbnailSize: map['maxThumbnailSize'],
      needUpdate: map['needUpdate'],
      storageQuota: map['storageQuota'] != null
          ? StorageQuota.fromMap(map['storageQuota'])
          : null,
      user: map['user'] != null ? DriveUser.fromMap(map['user']) : null,
      updateUrl: map['updateUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DriveAbout.fromJson(String source) =>
      DriveAbout.fromMap(json.decode(source));

  @override
  String toString() {
    return 'About(category: $category, maxFileUploadSize: $maxFileUploadSize, maxThumbnailSize: $maxThumbnailSize, needUpdate: $needUpdate, storageQuota: $storageQuota, user: $user, updateUrl: $updateUrl)';
  }
}
