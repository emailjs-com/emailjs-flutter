import 'package:emailjs/emailjs.dart';
import 'package:emailjs/src/store/store.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  test('should call the init method with empty options and get default values', () {
    init(const Options());

    final newStore = Store();

    expect(store.host, newStore.host);
    expect(store.publicKey, newStore.publicKey);
    expect(store.privateKey, newStore.privateKey);
    expect(store.blockList, newStore.blockList);
    expect(store.limitRate, newStore.limitRate);
    expect(store.storeProvider, newStore.storeProvider);
    expect(store.client, newStore.client);
  });

  test('should call the init method with custom options', () {
    init(const Options(
      publicKey: 'C2JWGTestKeySomething',
      blockList: BlockList(
        list: ['block@email.com'],
      ),
      limitRate: LimitRate(
        throttle: 10000,
      ),
      origin: 'test.com',
    ));


    final newStore = Store(host: 'test.com');
    newStore.publicKey = 'C2JWGTestKeySomething';
    
    newStore.blockList = const BlockList(
      list: ['block@email.com'],
    );

    newStore.limitRate = const LimitRate(
      throttle: 10000,
    );

    expect(store.host, newStore.host);
    expect(store.publicKey, newStore.publicKey);
    expect(store.privateKey, newStore.privateKey);
    expect(store.blockList, newStore.blockList);
    expect(store.limitRate, newStore.limitRate);
    expect(store.storeProvider, newStore.storeProvider);
    expect(store.client, newStore.client);
  });
}
