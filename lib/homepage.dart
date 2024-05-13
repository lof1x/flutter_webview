import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:full_webview/check_internet.dart';
import 'webview/example2.dart';
import 'webview/example3.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  String _url = "https://github.com/Cleaner192/KZHyberSportLearning";
  int checkInt = 0;

  var options = InAppBrowserClassOptions(
    crossPlatform: InAppBrowserOptions(
        hideUrlBar: false, toolbarTopBackgroundColor: Colors.blue),
    inAppWebViewGroupOptions: InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        javaScriptEnabled: true,
        cacheEnabled: true,
        transparentBackground: true,
      ),
    ),
  );

  @override
  void initState() {
    super.initState();
    Future<int> a = CheckInternet().checkInternetConnection();
    a.then((value) {
      if (value == 0) {
        setState(() {
          checkInt = 0;
        });
        print('No internet connect');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('No internet connection!'),
        ));
      } else {
        setState(() {
          checkInt = 1;
        });
        print('Internet connected');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Connected to the internet'),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Количество табов
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('X-Games'),
          centerTitle: true,
          elevation: 0,
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Новости',
              ),
              Tab(
                text: 'Уроки',
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(3, 6, 3, 6),
          child: RichText(
            text: TextSpan(
              text: 'Powered by X-Game',
              style: TextStyle(color: Colors.black),
              recognizer: TapGestureRecognizer()..onTap = () => _launchURL(),
              children: [],
            ),
            textAlign: TextAlign.center,
          ),
        ),
        body: TabBarView(
          children: [
            WebExampleTwo(url: _url),
            WebExampleOne(url: _url),
          ],
        ),
      ),
    );
  }

  void _launchURL() async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
}
