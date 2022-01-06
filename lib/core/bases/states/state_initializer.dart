// Created by Muhamad Fauzi Ridwan on 07/11/21.

part of '_states.dart';



enum StateInitializerDelay {
  min1,
  min5,
  min10,
  sec15,
}

/// An initializer with refresh indicatorKey.
class StateInitializer {
  /// Creates an [StateInitializer].
  StateInitializer({
    required String cacheKey,
    required this.rIndicator,
    required this.state,
    this.delay = StateInitializerDelay.sec15,
  })  : assert(cacheKey != '', 'dont empty'),
        ck = cacheKey;

  /// The [state] and [rIndicator] arguments must not be null
  String ck;
  GlobalKey<RefreshIndicatorState> rIndicator;
  bool state;
  StateInitializerDelay delay;

  void initialize() {
    SharedPreferences.getInstance().then((value) async {
      if (value.containsKey(ck)) {
        final date = value.getString(ck);
        if (getDelayTime(delay, date) && state) {
        } else {
          await value.setString(ck, DateTime.now().toIso8601String());
          await rIndicator.currentState?.show();
        }
      } else {
        await value.setString(ck, DateTime.now().toIso8601String());
        await rIndicator.currentState?.show();
      }
    });
  }
}

//todo(fauzi) recheck this class
// class SlightInitializer {
//   ReactiveModel rm;
//   String ck;
//   bool state;
//   Function whenTrigger;
//   StateInitializerDelay delay;
//
//   SlightInitializer(
//       {required ReactiveModel reactiveModel,
//       required String cacheKey,
//       required this.state,
//       required this.whenTrigger,
//       this.delay = StateInitializerDelay.sec15})
//       : assert(cacheKey != ''),
//         rm = reactiveModel,
//         ck = cacheKey;
//
//   void initialize() {
//     SharedPreferences.getInstance().then((value) async {
//       if (value.containsKey(ck)) {
//         var date = value.getString(ck);
//         if (_getDelayTime(delay, date) && state) {
//         } else {
//           await value.setString(ck, DateTime.now().toIso8601String());
//           whenTrigger();
//         }
//       } else {
//         await value.setString(ck, DateTime.now().toIso8601String());
//         whenTrigger();
//       }
//     });
//   }
// }

bool getDelayTime(StateInitializerDelay delay, String? date) {
  if (delay == StateInitializerDelay.min1) {
    return isDifferenceLessThanMin(date!);
  } else if (delay == StateInitializerDelay.min5) {
    return isDifferenceLessThanFiveMin(date!);
  } else if (delay == StateInitializerDelay.sec15) {
    return isDifferenceLessThanFifteen(date!);
  } else {
    return isDifferenceLessThanFiveMin(date!);
  }
}

bool isDifferenceLessThanThirtyMin(String time) {
  return DateTime.now().difference(DateTime.parse(time)) <
      const Duration(minutes: 30);
}

bool isDifferenceLessThanFiveMin(String time) {
  return DateTime.now().difference(DateTime.parse(time)) <
      const Duration(minutes: 5);
}

bool isDifferenceLessThanMin(String time) {
  return DateTime.now().difference(DateTime.parse(time)) <
      const Duration(minutes: 1);
}

bool isDifferenceLessThanFifteen(String time) {
  return DateTime.now().difference(DateTime.parse(time)) <
      const Duration(seconds: 15);
}
