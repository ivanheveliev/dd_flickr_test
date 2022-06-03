import 'package:dd_flickr_test/base/app_constants.dart';
import 'package:dd_flickr_test/base/app_methods.dart';
import 'package:dd_flickr_test/data/models/unsplash_model.dart';
import 'package:dd_flickr_test/data/requests/requests_repo.dart';
import 'package:dd_flickr_test/icons/emotions_icons.dart';
import 'package:dd_flickr_test/views/fullscreen_page.dart/fullscreen_photo_page.dart';
import 'package:dd_flickr_test/views/home_page/home_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final HomePageBloc _homePageBloc = HomePageBloc();
  bool _isLoading = true;
  List<UnsplashResults> _listMap = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _homePageBloc.close();
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
            'Do Digital Test',
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: IconButton(
              icon: const Icon(Icons.menu),
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
                    AppBaseMethods().launchURL(AppConstants.doDigitalLink);
                  },
                  child: Image.asset(
                    'assets/dd_logo.png',
                  ),
                ),
              ),
            ),
          ],
        ),
        body: BlocConsumer(
          bloc: _homePageBloc,
          listener: (BuildContext context, HomePageState state) async {
            if (state is InitState) {
            } else if (state is ErrorState) {
            } else if (state is LoadingState) {
            } else if (state is GotThePhotoCollectionListState) {}
          },
          builder: (BuildContext context, HomePageState state) {
            return _getBodyContainer();
          },
        ),
      ),
    );
  }

  Widget _getBodyContainer() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height -
                    80 -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
                width: MediaQuery.of(context).size.width,
                child: PagewiseListView(
                  pageSize: 10,
                  itemBuilder: _itemBuilder,
                  loadingBuilder: (context) => _isLoading
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height -
                              80 -
                              MediaQuery.of(context).padding.top,
                          child: _showLoader(context),
                        )
                      : _showLoader(context),
                  pageFuture: (pageIndex) {
                    return _fetchData(pageIndex! * 10, 10)
                        .then((value) => value);
                  },
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _itemBuilder(context, UnsplashResults a, index) {
    int _index = index + 1;
    bool _isLiked = AppBaseMethods().getInfoAboutLikesFromSP(_index) ?? false;
    return Padding(
      padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
      child: InkWell(
        onTap: () async {
          await Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, _, __) => FullScreenPhotoPage(
                index: _index,
                child: Image.network(
                  a.urls!.full!,
                ),
                isLiked: _isLiked,
              ),
            ),
          );
          setState(() {
            _isLiked =
                AppBaseMethods().getInfoAboutLikesFromSP(_index) ?? false;
          });
        },
        child: Card(
          color: const Color.fromRGBO(250, 250, 240, 1),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 84,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(250, 250, 240, 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  spreadRadius: 0.5,
                                  blurRadius: 0.5,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(45),
                              child: SizedBox(
                                width: 64,
                                height: 64,
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 32,
                                  backgroundImage: Image.network(
                                    a.user!.profileImage!.medium!,
                                  ).image,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 110,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            a.user!.name!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Color.fromRGBO(26, 30, 33, 1)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, right: 10, bottom: 10),
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  spreadRadius: 0.5,
                                  blurRadius: 0.5,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                a.urls!.small!,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        DateFormat('dd.MM.yyyy')
                            .format(DateTime.parse(a.createdAt!))
                            .toString(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 60,
                          height: 30,
                          color: const Color.fromRGBO(187, 79, 57, 1)
                              .withOpacity(0.1),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                AppBaseMethods()
                                    .setInfoAboutLikeInSP(!_isLiked, _index);
                              });
                            },
                            child: _isLiked
                                ? const Icon(
                                    Emotions.like,
                                    color: Color.fromRGBO(184, 7, 29, 1),
                                  )
                                : const Icon(Emotions.heart),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getIconWidget(int index) {
    bool? isLike = AppBaseMethods().getInfoAboutLikesFromSP(index);
    try {
      if (isLike!) {
        return const Icon(Emotions.heart);
      } else {
        return const Icon(Emotions.like);
      }
    } catch (e) {
      return const Icon(Emotions.heart);
    }
  }

  Widget _showLoader(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.transparent,
        valueColor: AlwaysStoppedAnimation<Color>(
          Color.fromRGBO(187, 79, 57, 1),
        ),
      ),
    );
  }

  Future<List<UnsplashResults>> _fetchData(int page, int perPage) async {
    _listMap = await RequestsRepo().getPhotoCollectionList(page, perPage);
    _isLoading = false;
    return _listMap;
  }
}
