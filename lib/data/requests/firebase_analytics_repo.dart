import 'package:firebase_analytics/firebase_analytics.dart';
import 'dart:async';

class FirebaseAnalyticsRepo {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future sendAnalyticsLikePhoto(int index) async {
    await FirebaseAnalytics.instance.logEvent(
      name: "like_photo",
      parameters: {
        "content_type": "image",
        "item_id": index,
      },
    );
  }

  Future sendAnalyticsRemovedLikePhoto(int index) async {
    await FirebaseAnalytics.instance.logEvent(
      name: "removed_like_photo",
      parameters: {
        "content_type": "image",
        "item_id": index,
      },
    );
  }
}
