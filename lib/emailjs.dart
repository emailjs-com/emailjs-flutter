library emailjs;

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'src/models/emailjs_response_status.dart';
import 'src/models/options.dart';
export 'src/models/block_list.dart';
export 'src/models/limit_rate.dart';
import 'src/models/storage_provider.dart';
import 'src/methods/init';
import 'src/methods/send';

export 'src/models/emailjs_response_status.dart';
export 'src/models/options.dart';
export 'src/models/block_list.dart';
export 'src/models/limit_rate.dart';
export 'src/models/storage_provider.dart';
export 'src/methods/init';
export 'src/methods/send';

export default {
  init: init,
  send: send,
  EmailJSResponseStatus: EmailJSResponseStatus,
  Options: Options,
  LimitRate: LimitRate,
  BlockList: BlockList,
  StorageProvider: StorageProvider,
};
