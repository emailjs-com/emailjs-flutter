import 'package:http/http.dart';

import '../models/default_storage.dart';
import '../models/block_list.dart';
import '../models/limit_rate.dart';
import '../models/storage_provider.dart';

class Store {
  String host;
  String? publicKey;
  String? privateKey;
  BlockList? blockList;
  LimitRate? limitRate;
  StorageProvider? storeProvider;
  Client? client;

  set storageProvider(StorageProvider? provider) {
    if (provider != null) {
      storeProvider = provider;
    }
  }

  StorageProvider get storageProvider {
    storeProvider = storeProvider ?? DefaultStorage();
    return storeProvider!;
  }

  set origin(String? origin) {
    if (origin != null) {
      host = origin;
    }
  }

  Store({
    this.host = 'api.emailjs.com',
  });
}

final Store store = Store();
