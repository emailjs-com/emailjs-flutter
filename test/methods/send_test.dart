import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:emailjs/emailjs.dart';

class MockClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

class MockStorage extends Mock implements StorageProvider {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeUri());

    final mockHttpClient = MockClient();
    when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => http.Response('OK', 200));
    init(const Options(), mockHttpClient);
  });

  setUp(() async {
    final Map<String, Object> values = <String, Object>{};
    SharedPreferences.setMockInitialValues(values);
  });
  
  test('should call the send method and fail on the public key', () {
    expect(
      () => send('default_service', 'my_test_template'),
      throwsA(startsWith('The public key is required')),
    );
  });

  test('should call the send method and fail on the service ID', () {
    expect(
      () => send('', 'my_test_template', null, const Options(
        publicKey: 'C2JWGTestKeySomething',
      )),
      throwsA(startsWith('The service ID is required')),
    );
  });

  test('should call the send method and fail on the template ID', () {
    expect(
      () => send('default_service', '', null, const Options(
        publicKey: 'C2JWGTestKeySomething',
      )),
      throwsA(startsWith('The template ID is required')),
    );
  });

  test('should call the send method and fail on blocklist', () async {
    try {
      final response = await send('default_service', 'my_test_template', {
        'email': 'bar@emailjs.com',
      }, const Options(
        publicKey: 'C2JWGTestKeySomething',
        blockList: BlockList(
          list: ['foo@emailjs.com', 'bar@emailjs.com'],
          watchVariable: 'email',
        ),
      ));

      expect(response, isNull);
    } catch (error) {
      expect('$error', '[403] Forbidden');
    }
  });

  test('should call the send method and fail on blocklist as future', () {
    send('default_service', 'my_test_template', {
        'email': 'bar@emailjs.com',
      }, const Options(
        publicKey: 'C2JWGTestKeySomething',
        blockList: BlockList(
          list: ['foo@emailjs.com', 'bar@emailjs.com'],
          watchVariable: 'email',
        ),
      )).then((result) {
        expect(result, isNull);
      }).catchError((error) {
        expect('$error', '[403] Forbidden');
      });
  });

  test('should call the send method and fail on limit rate', () async {
    sendEmail() {
      return send('default_service', 'my_test_template', null, const Options(
        publicKey: 'C2JWGTestKeySomething',
        limitRate: LimitRate(
          id: 'async-send',
          throttle: 100,
        ),
      ));
    }

    try {
      final response = await sendEmail();
      expect('$response', '[200] OK');
    } catch (error) {
      expect(error, isNull);
    }

    try {
      final response = await sendEmail();
      expect(response, isNull);
    } catch (error) {
      expect('$error', '[429] Too Many Requests');
    }
  });

  test('should call the send method and fail on limit rate as future', () {
    sendEmail() {
      return send('default_service', 'my_test_template', null, const Options(
        publicKey: 'C2JWGTestKeySomething',
        limitRate: LimitRate(
          id: 'future-send',
          throttle: 1000,
        ),
      ));
    }

    sendEmail().then((response) {
      expect('$response', '[200] OK');

      sendEmail().then((response) {
        expect(response, isNull);
      }).catchError((error) {
        expect('$error', '[429] Too Many Requests');
      });
    }).catchError((error) {
      expect(error, isNull);
    });
  });

  test('should call the send method successfully with 4 params', () async {
    try {
      final response = await send('default_service', 'my_test_template', {}, const Options(
        publicKey: 'C2JWGTestKeySomething',
      ));

      expect('$response', '[200] OK');
    } catch (error) {
      expect(error, isNull);
    }
  });

  test('should call the send method successfully with 4 params as future', () {
    send('default_service', 'my_test_template', {}, const Options(
      publicKey: 'C2JWGTestKeySomething',
    )).then((response) {
      expect('$response', '[200] OK');
    }).catchError((error) {
      expect(error, isNull);
    });
  });
}
