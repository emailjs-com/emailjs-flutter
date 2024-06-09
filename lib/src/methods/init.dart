import 'src/models/options.dart';
import 'src/store/store.dart';

void init(Options options) {
  store.publicKey = options.publicKey;
  store.privateKey = options.privateKey;
  store.blockList = options.blockList;
  store.limitRate = options.limitRate;
  store.origin = options.origin ?? 'https://api.emailjs.com';
}
