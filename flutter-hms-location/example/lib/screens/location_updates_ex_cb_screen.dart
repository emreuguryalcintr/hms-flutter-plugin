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

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_location/location/fused_location_provider_client.dart';
import 'package:huawei_location/location/location_callback.dart';
import 'package:huawei_location/location/location_request.dart';

import '../widgets/custom_button.dart' show Btn;

class LocationUpdatesExCbScreen extends StatefulWidget {
  static const String ROUTE_NAME = "LocationUpdatesExCbScreen";

  @override
  _LocationUpdatesExCbScreenState createState() =>
      _LocationUpdatesExCbScreenState();
}

class _LocationUpdatesExCbScreenState extends State<LocationUpdatesExCbScreen> {
  final FusedLocationProviderClient _locationService =
      FusedLocationProviderClient();
  final LocationRequest _locationRequest = LocationRequest()..interval = 500;

  String _topText = "";
  String _bottomText = "";
  int? _callbackId;
  late LocationCallback _locationCallback;

  @override
  void initState() {
    super.initState();

    _locationCallback = LocationCallback(
      onLocationResult: _onCallbackResult,
      onLocationAvailability: _onCallbackResult,
    );
  }

  void _onCallbackResult(result) {
    _appendToBottomText(result.toString());
  }

  void _requestLocationUpdatesExCb() async {
    if (_callbackId == null) {
      try {
        final int callbackId = await _locationService
            .requestLocationUpdatesExCb(_locationRequest, _locationCallback);
        _callbackId = callbackId;
        _setTopText("Location updates are requested successfully.");
      } on PlatformException catch (e) {
        _setTopText(e.toString());
      }
    } else {
      _setTopText(
          "Already requested location updates. Try removing location updates");
    }
  }

  void _removeLocationUpdatesExCb() async {
    _setTopText();
    if (_callbackId != null) {
      try {
        await _locationService.removeLocationUpdatesCb(_callbackId!);
        _callbackId = null;
        _setTopText("Location updates are removed successfully");
      } on PlatformException catch (e) {
        _setTopText(e.toString());
      }
    } else {
      _setTopText("callbackId does not exist. Request location updates first");
    }
  }

  void _removeLocationUpdatesOnDispose() async {
    if (_callbackId != null) {
      try {
        await _locationService.removeLocationUpdatesCb(_callbackId!);
        _callbackId = null;
      } on PlatformException catch (e) {
        log(e.toString());
      }
    }
  }

  void _setTopText([String text = ""]) {
    setState(() {
      _topText = text;
    });
  }

  void _appendToBottomText(String text) {
    setState(() {
      _bottomText = "$_bottomText\n\n$text";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Updates Ex with CB'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                top: 10,
              ),
              height: 90,
              child: Text(_topText),
            ),
            Divider(
              thickness: 0.1,
              color: Colors.black,
            ),
            Btn("Request Location Updates Ex with Callback",
                _requestLocationUpdatesExCb),
            Btn("Remove Location Updates", _removeLocationUpdatesExCb),
            Expanded(
              child: new SingleChildScrollView(
                child: Text(
                  _bottomText,
                  style: const TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _removeLocationUpdatesOnDispose();
  }
}
