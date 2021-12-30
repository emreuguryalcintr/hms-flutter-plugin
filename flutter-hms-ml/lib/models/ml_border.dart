/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

class MLBorder {
  int? bottom;
  int? left;
  int? right;
  int? top;

  MLBorder({this.bottom, this.left, this.right, this.top});

  MLBorder.fromJson(Map<String, dynamic> json) {
    bottom = json['bottom'];
    left = json['left'];
    right = json['right'];
    top = json['top'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['top'] = this.top;
    data['left'] = this.left;
    data['bottom'] = this.bottom;
    data['right'] = this.right;
    return data;
  }
}
