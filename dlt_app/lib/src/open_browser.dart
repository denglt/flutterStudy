import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenBrowserPage extends StatefulWidget {
  @override
  _OpenBrowserPageState createState() => _OpenBrowserPageState();
}

class _OpenBrowserPageState extends State<OpenBrowserPage> {
  Future<void> _launched;
  String _phone = '';
  @override
  Widget build(BuildContext context) {
    const String toLaunch = 'https://www.cylog.org/headers/';
    return Scaffold(
      appBar: AppBar(
        title: Text('url_launcher'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.open_in_browser),
            onPressed: () {
              _launchURL();
            },
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                    onChanged: (String text) => _phone = text,
                    decoration: const InputDecoration(
                        hintText: 'Input the phone number to launch')),
              ),
              RaisedButton(
                onPressed: () => setState(() {
                      _launched = _makePhoneCall('tel:$_phone');
                    }),
                child: const Text('Make phone call'),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(toLaunch),
              ),
              RaisedButton(
                onPressed: () => setState(() {
                      _launched = _launchInBrowser(toLaunch);
                    }),
                child: const Text('Launch in browser'),
              ),
              const Padding(padding: EdgeInsets.all(16.0)),
              RaisedButton(
                onPressed: () => setState(() {
                      _launched = _launchInWebViewOrVC(toLaunch);
                    }),
                child: const Text('Launch in app'),
              ),
              RaisedButton(
                onPressed: () => setState(() {
                      _launched = _launchInWebViewWithJavaScript(toLaunch);
                    }),
                child: const Text('Launch in app(JavaScript ON)'),
              ),
              RaisedButton(
                onPressed: () => setState(() {
                      _launched = _launchInWebViewWithDomStorage(toLaunch);
                    }),
                child: const Text('Launch in app(DOM storage ON)'),
              ),
              const Padding(padding: EdgeInsets.all(16.0)),
              RaisedButton(
                onPressed: () => setState(() {
                      _launched = _launchUniversalLinkIos(toLaunch);
                    }),
                child: const Text(
                    'Launch a universal link in a native app, fallback to Safari.(Youtube)'),
              ),
              const Padding(padding: EdgeInsets.all(16.0)),
              RaisedButton(
                onPressed: () => setState(() {
                      _launched = _launchInWebViewOrVC(toLaunch);
                      Timer(const Duration(seconds: 5), () {
                        print('Closing WebView after 5 seconds...');
                        closeWebView();
                      });
                    }),
                child: const Text('Launch in app + close after 5 seconds'),
              ),
              const Padding(padding: EdgeInsets.all(16.0)),
              FutureBuilder<void>(future: _launched, builder: _launchStatus),
            ],
          ),
        ],
      ),
    );
  }

  _launchURL() {
    launch('https://flutter.dev',
        forceSafariVC: false, forceWebView: true); // launch in app
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false, // or true
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true, // or false
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchInWebViewWithJavaScript(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchInWebViewWithDomStorage(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableDomStorage: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchUniversalLinkIos(String url) async {
    if (await canLaunch('https://youtube.com')) {
      final bool nativeAppLaunchSucceeded = await launch(
        'https://youtube.com',
        forceSafariVC: false,
        universalLinksOnly: true,
      );
      print('nativeAppLaunchSucceeded -> $nativeAppLaunchSucceeded');
      if (!nativeAppLaunchSucceeded) {
        await launch(
          'https://youtube.com',
          forceSafariVC: true,
        );
      }
    }
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    //snapshot.data
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('open ok!');
    }
  }
}
