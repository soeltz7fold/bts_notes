
class OfRoutes {
  static const root = "/";
  static const auth = "/auth";
  static const splash = "/splash";
  static const signin = "/signin";
  static const signup = "/signup";
  static const notes = "/notes";

  static const home = "/home";
  static const settings = '/settings';

  // static const streams = "/streams";
  // static const liveHost = "live_host";

}
class AppConfig {
  static const bool launchClearUser = false;
}

extension RouteStr on String {
  String get asPath => "/$this";

  String get asNamed => substring((indexOf("/") + 1), length);
}
