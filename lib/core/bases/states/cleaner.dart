part of '_states.dart';

abstract class StateCleaner {
  void cleanState();

  void cleanWhenLogout();
}

class Cleaner implements StateCleaner {
  @override
  void cleanState() {}

  @override
  void cleanWhenLogout() {
    for (final key in PreferencesKeys.removableKeys) {
      Pref.removeKey(key);
    }
  }
}
