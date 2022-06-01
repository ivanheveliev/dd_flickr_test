import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const Drawer(
          child: Center(
            child: Text(
              'Wait for the next app update...',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text(
            'Flickr Test',
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 50),
              child: SizedBox(
                width: 25,
                height: 25,
                child: GestureDetector(
                  onTap: () {
                    _launchURL();
                  },
                  child: Image.asset(
                    'assets/dd_logo.png',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _launchURL() async {
    const _url = 'https://www.dodigital.ru/';
    if (await canLaunchUrl(Uri.parse(_url))) {
      await launchUrl(Uri.parse(_url));
    }
  }
}
