import '../models/options.dart';
import '../store/store.dart';
import '../api/send_post.dart';

import '../utils/validate_params.dart';
import '../utils/is_blocked_value_in_params.dart';
import '../utils/is_limit_rate_hit.dart';
import '../utils/create_default_storage.dart';

import '../errors/blocked_email_error.dart';
import '../errors/limit_rate_error.dart';

/// Sends the email through the [serviceID] using the ready-made [templateID].
///
/// It's possible to pass [templatePrams] dynamic variables,
/// and set the [options] for this call.
Future<EmailJSResponseStatus> send(
  String serviceID,
  String templateID, [
  Map<String, dynamic>? templatePrams,
  Options? options,
]) async {
  final publicKey = options?.publicKey ?? store.publicKey;
  final privateKey = options?.privateKey ?? store.privateKey;
  final storageProvider = options?.storageProvider ?? store.storageProvider ?? createDefaultStorage();
  final blockList = { ...store.blockList, ...options.blockList };
  final limitRate = { ...store.limitRate, ...options.limitRate };

  validateParams(publicKey, serviceID, templateID);

  if (templateParams != null && isBlockedValueInParams(blockList, templateParams)) {
    return Future.error(blockedEmailError());
  }

  if (await isLimitRateHit(limitRate, storageProvider)) {
    return Future.error(limitRateError());
  }

  final Map<String, dynamic> params = {
    'lib_version': '4.0.0',
    'user_id': publicKey,
    'accessToken': privateKey,
    'service_id': serviceID,
    'template_id': templateID,
    'template_params': templatePrams,
  };

  return sendPost('api/v1.0/email/send', json.encode(params));
}
