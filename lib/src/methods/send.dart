import 'dart:convert';

import '../store/store.dart';
import '../api/send_post.dart';

import '../models/emailjs_response_status.dart';
import '../models/options.dart';
import '../models/storage_provider.dart';
import '../models/block_list.dart';
import '../models/limit_rate.dart';

import '../utils/validate_params.dart';
import '../utils/is_blocked_value_in_params.dart';
import '../utils/is_limit_rate_hit.dart';

import '../errors/blocked_email_error.dart';
import '../errors/limit_rate_error.dart';

/// Sends the email through the [serviceID] using the ready-made [templateID].
///
/// It's possible to pass [templateParams] dynamic variables,
/// and set the [options] for this call.
Future<EmailJSResponseStatus> send(
  String serviceID,
  String templateID, [
  Map<String, dynamic>? templateParams,
  Options? options,
]) async {
  final publicKey = options?.publicKey ?? store.publicKey;
  final privateKey = options?.privateKey ?? store.privateKey;
  final StorageProvider storageProvider = options?.storageProvider ?? store.storageProvider;

  final BlockList blockList = BlockList(
    list: options?.blockList?.list ?? store.blockList?.list,
    watchVariable: options?.blockList?.watchVariable ?? store.blockList?.watchVariable,
  );
  
  final LimitRate limitRate = LimitRate(
    id: options?.limitRate?.id ?? store.limitRate?.id,
    throttle: store.limitRate?.throttle ?? options?.limitRate?.throttle ?? 0,
  );

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
    'template_params': templateParams,
  };

  return sendPost('api/v1.0/email/send', json.encode(params));
}
