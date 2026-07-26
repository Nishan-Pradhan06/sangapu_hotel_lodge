extension RoutePath on String {
  String get path {
    return "/$this";
  }

  String get rootPath {
    return "/";
  }
}
