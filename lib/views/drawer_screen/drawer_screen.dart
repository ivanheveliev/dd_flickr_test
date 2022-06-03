import 'package:dd_flickr_test/base/app_methods.dart';
import 'package:dd_flickr_test/icons/custom_icons_icons.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
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
    return Drawer(
      backgroundColor: const Color.fromRGBO(250, 250, 240, 1),
      child: _getBodyWidget(),
    );
  }

  Widget _getBodyWidget() {
    return Stack(
      children: [
        Container(
          height: 80,
          color: const Color.fromRGBO(187, 79, 57, 1),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Container(
                height: 84,
                width: 84,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(250, 250, 240, 1),
                  borderRadius: BorderRadius.all(Radius.circular(42)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      spreadRadius: 0.5,
                      blurRadius: 0.5,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    CustomIcons.avatar,
                    size: 40,
                    color: Colors.black,
                  ),
                  radius: 42,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Container(
                height: 0.5,
                color: Colors.black,
              ),
            ),
            const Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                'Do Digital Test App',
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  color: Color.fromRGBO(31, 31, 31, 0.296),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Container(
                height: 0.5,
                color: Colors.black,
              ),
            ),
          ],
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    'Version: ' + AppMethods.packageInfo!.version,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    '© 2016-2021 Do digital',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
