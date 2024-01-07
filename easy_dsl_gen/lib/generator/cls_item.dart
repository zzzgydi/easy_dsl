class ClsItem {
  const ClsItem({
    required this.srcCls,
    required this.hashCls,
    required this.clsSet,
  });

  final String srcCls; // source className
  final String hashCls; // hash className
  final Set<String> clsSet;

  static ClsItem fromSrc(String srcCls) {
    final clsSet = srcCls
        .split(" ")
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toSet();

    return ClsItem(
      srcCls: srcCls,
      hashCls: clsSet.join(" "),
      clsSet: clsSet,
    );
  }
}
