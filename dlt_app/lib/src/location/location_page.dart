import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'package:http/http.dart' as http;

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  Location _location;
  LocationData _currentLocation;

  Map _addressInfo;
  @override
  void initState() {
    super.initState();
    _location = Location();
    _location.changeSettings(interval: 1000);
    _location.getLocation().then((LocationData locationData) async {
      await _getAddress(locationData);
      setState(() {
        _currentLocation = locationData;
      });
    });
    _location.onLocationChanged().listen((LocationData locationData) async {
      await _getAddress(locationData);
      setState(() {
        _currentLocation = locationData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPS定位'),
      ),
      body: Container(
        child: Center(
          child: _currentLocation == null
              ? CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('latitude : ${_currentLocation.latitude}'),
                    Text('longitude : ${_currentLocation.longitude}'),
                    Text('accuracy : ${_currentLocation.accuracy}'),
                    Text('speed : ${_currentLocation.speed}'),
                    Text('speedAccuracy : ${_currentLocation.speedAccuracy}'),
                    Text('heading : ${_currentLocation.heading}'),
                    Text('time : ${_currentLocation.time}'),
                    _buildAddress(),
                  ],
                ),
        ),
      ),
    );
  }

  _getAddress(LocationData location) async {
    //  if (_currentLocation != null && )
    //   return null;
    String url =
        'https://api.map.baidu.com/reverse_geocoding/v3/?ak=sClTsWXP7PQunMEujUAgQmVHOhZHfmTC&output=json&coordtype=wgs84ll&location=${location.latitude},${location.longitude}';
    //print(url);
    http.Response response = await http.post(
      url,
      headers: null,
      body: null,
      encoding: null,
    );
    //print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');
    Map locationMap = json.decode(response.body);
    if (locationMap['status'] == 0) {
      print(locationMap['result']['location']);
      Map addressComponent = locationMap['result']['addressComponent'];
      addressComponent['cityCode'] = locationMap['result']['cityCode'];
      _addressInfo = addressComponent;
    } else {
      print('请求百度地图失败，错误码${locationMap['status']}');
    }
  }

  Widget _buildAddress() {
    if (_addressInfo == null) {
      return Text('没有地址信息');
    } else {
      var list = _addressInfo.entries
          .map((t) => Text('${t.key} : ${t.value}'))
          .toList();
      list.insert(0, Text('地址信息如下:                                          '));
      return Column(
        children: list,
      );
    }
  }
}
