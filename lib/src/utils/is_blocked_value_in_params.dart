import '../models/block_list.dart';

bool isBlockListDisabled(BlockList options) {
  return options.list == null || options.list!.isEmpty || options.watchVariable == null;
}

bool isBlockedValueInParams(
  BlockList options,
  Map<String, dynamic> params,
) {
    if (isBlockListDisabled(options)) return false;

    final value = params[options.watchVariable];
    return options.list!.contains(value);
}
