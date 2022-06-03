import 'package:dd_flickr_test/base/app_methods.dart';
import 'package:dd_flickr_test/icons/emotions_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FullScreenPhotoPage extends StatefulWidget {
  final Image child;
  final int index;
  final bool isLiked;

  const FullScreenPhotoPage({
    Key? key,
    required this.child,
    required this.index,
    required this.isLiked,
  }) : super(key: key);
  @override
  _FullScreenPhotoPageState createState() => _FullScreenPhotoPageState();
}

class _FullScreenPhotoPageState extends State<FullScreenPhotoPage> {
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: _getBodyContainer(),
    );
  }

  Widget _getBodyContainer() {
    bool _isLiked =
        AppBaseMethods().getInfoAboutLikesFromSP(widget.index) ?? false;
    return Stack(
      children: [
        Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 333),
              curve: Curves.fastOutSlowIn,
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: InteractiveViewer(
                panEnabled: true,
                minScale: 0.5,
                maxScale: 4,
                child: widget.child,
              ),
            ),
          ],
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  padding: const EdgeInsets.all(15),
                  elevation: 0,
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 25,
                  ),
                  color: Colors.black12,
                  highlightElevation: 0,
                  minWidth: double.minPositive,
                  height: double.minPositive,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                MaterialButton(
                  padding: const EdgeInsets.all(15),
                  elevation: 0,
                  child: _isLiked
                      ? const Icon(
                          Emotions.like,
                          size: 25,
                          color: Color.fromRGBO(184, 7, 29, 1),
                        )
                      : const Icon(Emotions.heart, size: 25),
                  color: Colors.white.withOpacity(0.5),
                  highlightElevation: 0,
                  minWidth: double.minPositive,
                  height: double.minPositive,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  onPressed: () {
                    setState(() {
                      AppBaseMethods()
                          .setInfoAboutLikeInSP(!_isLiked, widget.index);
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
