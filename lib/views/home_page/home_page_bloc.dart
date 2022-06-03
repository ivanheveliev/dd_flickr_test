import 'package:dd_flickr_test/data/models/unsplash_model.dart';
import 'package:dd_flickr_test/data/requests/firebase_analytics_repo.dart';
import 'package:dd_flickr_test/data/requests/requests_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// BLOC
class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(const HomePageState());

  final FirebaseAnalyticsRepo _firebaseAnalyticsRepo = FirebaseAnalyticsRepo();

  get initialState => InitState();

  void sendAnalyticsLikePhoto(int index) =>
      add(SendAnalyticsLikePhotoEvent(index));

  void sendAnalyticsRemovedLikePhoto(int index) =>
      add(SendAnalyticsRemovedLikePhotoEvent(index));

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    if (event is SendAnalyticsLikePhotoEvent) {
      yield* _sendAnalyticsLikePhoto(event.index);
    } else if (event is SendAnalyticsRemovedLikePhotoEvent) {
      yield* _sendAnalyticsRemovedLikePhoto(event.index);
    }
  }

  Stream<HomePageState> _sendAnalyticsLikePhoto(int index) async* {
    yield LoadingState();
    final dynamic data =
        await _firebaseAnalyticsRepo.sendAnalyticsLikePhoto(index);
    yield LoadedState();
  }

  Stream<HomePageState> _sendAnalyticsRemovedLikePhoto(int index) async* {
    yield LoadingState();
    final dynamic data =
        await _firebaseAnalyticsRepo.sendAnalyticsRemovedLikePhoto(index);
    yield LoadedState();
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

class LoadedState extends HomePageState {}

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

class SendAnalyticsLikePhotoEvent extends HomePageEvent {
  final int index;

  SendAnalyticsLikePhotoEvent(this.index) : super([index]);
}

class SendAnalyticsRemovedLikePhotoEvent extends HomePageEvent {
  final int index;

  SendAnalyticsRemovedLikePhotoEvent(this.index) : super([index]);
}
