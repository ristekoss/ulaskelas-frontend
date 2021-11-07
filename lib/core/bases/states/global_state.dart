part of '_states.dart';

class GlobalState {
  static List<Injectable> injectDataMocks({FirebaseAuth? authInstance}) {
    return <Injectable>[
      Inject(() => ThemeState(
              themeData: ThemeData(
            primaryColor: HoumiColors.houmiPrimary,
            secondaryHeaderColor: HoumiColors.houmiSecondary,
            accentColor: HoumiColors.houmiAccent,
          ))),
      Inject(() => ProfileState()),
      Inject(() => NavigationServiceState()),
      Inject(() => AuthState(instance: authInstance)),
      Inject(() => LoginFormState()),
      Inject(() => RegisterFormState()),
      Inject(() => ForgotPasswordState()),
      Inject(() => NotificationState()),
      Inject(() => NewsState()),
      Inject(() => FilePickerState()),
      Inject(() => StorageState()),
    ];
  }

  static List<Injectable> injectData = <Injectable>[
    Inject(() => ThemeState()),
    Inject(() => ProfileState()),
    Inject(() => NavigationServiceState()),
    Inject(() => AuthState()),
    Inject(() => LoginFormState()),
    Inject(() => RegisterFormState()),
    Inject(() => ForgotPasswordState()),
    Inject(() => NotificationState()),
    Inject(() => NewsState()),
    Inject(() => FilePickerState()),
    Inject(() => StorageState()),
  ];

  static ReactiveModel<ThemeState> theme() {
    return Injector.getAsReactive<ThemeState>();
  }

  static ReactiveModel<ProfileState> profile() {
    return Injector.getAsReactive<ProfileState>();
  }

  static ReactiveModel<NavigationServiceState> navigation() {
    return Injector.getAsReactive<NavigationServiceState>();
  }

  static ReactiveModel<AuthState> auth() {
    return Injector.getAsReactive<AuthState>();
  }

  static ReactiveModel<LoginFormState> loginForm() {
    return Injector.getAsReactive<LoginFormState>();
  }

  static ReactiveModel<RegisterFormState> registerForm() {
    return Injector.getAsReactive<RegisterFormState>();
  }

  static ReactiveModel<ForgotPasswordState> forgotPassword() {
    return Injector.getAsReactive<ForgotPasswordState>();
  }

  static ReactiveModel<NotificationState> notification() {
    return Injector.getAsReactive<NotificationState>();
  }

  static ReactiveModel<NewsState> news() {
    return Injector.getAsReactive<NewsState>();
  }

  static ReactiveModel<FilePickerState> file() {
    return Injector.getAsReactive<FilePickerState>();
  }

  static ReactiveModel<StorageState> storage() {
    return Injector.getAsReactive<StorageState>();
  }
}
