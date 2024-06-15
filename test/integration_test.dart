import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:emailjs/emailjs.dart' as emailjs;

class MockClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

class MockStorage extends Mock implements emailjs.StorageProvider {}

initMockRequest({int? status = 200}) {
  final mockHttpClient = MockClient();
  when(() => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        )).thenAnswer((_) async => http.Response('OK', status!));

  return mockHttpClient;
}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeUri());
  });

  setUp(() async {
    final Map<String, Object> values = <String, Object>{};
    SharedPreferences.setMockInitialValues(values);
  });

  group('send method', () {
    test('should call the send method and fail on http error', () async {
      final mockHttpClient = initMockRequest(status: 400);
      
      emailjs.init(
        const emailjs.Options(
          publicKey: 'LC2JWGTestKeySomething',
          privateKey: 'PrKeyTestKeySomething',
        ),
        mockHttpClient,
      );

      try {
        final response = await emailjs.send(
          'default_service',
          'my_test_template',
        );
        expect(response, isNull);
      } catch (error) {
        expect('$error', '[400] OK');
      }
    });

    test('should call the send method and fail on http error as future', () async {
      final mockHttpClient = initMockRequest(status: 400);
      
      emailjs.init(
        const emailjs.Options(
          publicKey: 'LC2JWGTestKeySomething',
          privateKey: 'PrKeyTestKeySomething',
        ),
        mockHttpClient,
      );

      emailjs.send(
        'default_service',
        'my_test_template',
      ).then((response) {
        expect(response, isNull);
      }).catchError((error) {
        expect('$error', '[400] OK');
      });
    });

    test('should call the init and the send method successfully', () async {
      final mockHttpClient = initMockRequest();
      
      emailjs.init(
        const emailjs.Options(
          publicKey: 'LC2JWGTestKeySomething',
          privateKey: 'PrKeyTestKeySomething',
        ),
        mockHttpClient,
      );

      try {
        final response = await emailjs.send(
          'default_service',
          'my_test_template',
        );
        expect('$response', '[200] OK');
      } catch (error) {
        expect(error, isNull);
      }
    });

    test('should call the init and the send method successfully as future', () {
      final mockHttpClient = initMockRequest();
      
      emailjs.init(
        const emailjs.Options(
          publicKey: 'LC2JWGTestKeySomething',
          privateKey: 'PrKeyTestKeySomething',
        ),
        mockHttpClient,
      );

      emailjs.send(
        'default_service',
        'my_test_template',
      ).then((response) {
        expect('$response', '[200] OK');
      }).catchError((error) {
        expect(error, isNull);
      });
    });
  });
}
