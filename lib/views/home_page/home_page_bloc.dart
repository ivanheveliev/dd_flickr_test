import 'package:dd_flickr_test/data/models/unsplash_model.dart';
import 'package:dd_flickr_test/data/requests/requests_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// BLOC
class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(const HomePageState());

  final RequestsRepo _requestsRepo = RequestsRepo();

  get initialState => InitState();

  void getPhotoCollectionList(int page, int perPage) =>
      add(GetPhotoCollectionListEvent(page, perPage));

  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    if (event is GetPhotoCollectionListEvent) {
      yield* _getPhotoCollectionList(event.page, event.perPage);
    }
  }

  Stream<HomePageState> _getPhotoCollectionList(int page, int perPage) async* {
    yield LoadingState();
    final dynamic data =
        await _requestsRepo.getPhotoCollectionList(page, perPage);
    yield GotThePhotoCollectionListState(data);
  }
}

// STATES
@immutable
class HomePageState {
  final List propsList;

  const HomePageState([this.propsList = const []]);

  List<dynamic> get props => propsList;
}

class InitState extends HomePageState {}

class LoadingState extends HomePageState {}

class GotThePhotoCollectionListState extends HomePageState {
  final List<UnsplashResults> photoCollectionList;

  GotThePhotoCollectionListState(this.photoCollectionList)
      : super([
          photoCollectionList,
        ]);
}

class ErrorState extends HomePageState {
  final String error;

  ErrorState(this.error) : super([error]);
}

// EVENTS
@immutable
abstract class HomePageEvent {
  final List propsList;

  const HomePageEvent([this.propsList = const []]);

  List<dynamic> get props => propsList;
}

class GetPhotoCollectionListEvent extends HomePageEvent {
  final int page;
  final int perPage;

  GetPhotoCollectionListEvent(this.page, this.perPage) : super([page, perPage]);
}
