import 'package:meta/meta.dart';

import 'block_list.dart';
import 'limit_rate.dart';

@immutable
class Options {
  /// The public key is required to identify your account and is a required variable
  final String publicKey;

  /// Additionally, a private key can be used for authorization
  final String? privateKey;

  /// This configuration controls whether requests are blocked for certain values in the variable
  final BlockList? blockList;

  /// This option allows SDK to process requests no more often than specified in the throttle
  final LimitRate? limitRate;

  const Options({
    required this.publicKey,
    this.privateKey,
    this.blockList,
    this.limitRate,
  });
}
