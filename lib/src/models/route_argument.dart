class RouteArgument {
  String id;
  String heroTag;

  RouteArgument({this.id, this.heroTag});

  @override
  String toString() {
    return '{id: $id, heroTag:${heroTag.toString()}}';
  }
}
