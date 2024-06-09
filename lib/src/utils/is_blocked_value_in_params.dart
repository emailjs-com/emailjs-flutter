import '../modles/block_list.dart';

bool isBlockedValueInParams(
  BlockList options,
  Map<String, dynamic> params,
) {
    final value = params[options.watchVariable];
    return options.list.contains(value);
}