import 'package:http/http.dart';
import '../models/options.dart';
import '../store/store.dart';

/// Global configuration for EmailJS
///
/// Sets globally the EmailJS [options]
void init(Options options, [Client? client]) {
  store.publicKey = options.publicKey;
  store.privateKey = options.privateKey;
  store.blockList = options.blockList;
  store.limitRate = options.limitRate;
  store.storageProvider = options.storageProvider;
  store.origin = options.origin;

  // for testing porpose
  store.client = client;
}
