class BlockList {
  /// The list of strings contains suspended values
  final List<String> list;

  /// A name of the variable to be watched
  final String watchVariable;

  const BlockList({
    required this.list,
    required this.watchVariable,
  });
}
