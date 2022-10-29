import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

import 'package:emailjs/emailjs.dart';

class MockClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeUri());
  });

  group('required params validator', () {
    test('should send method and fail on the public key', () {
      expect(
        () => EmailJS.send('default_service', 'my_test_template'),
        throwsA(startsWith('The public key is required')),
      );
    });

    test('should send method and fail on the service ID', () {
      EmailJS.init('LC2JWGTestKeySomething');

      expect(
        () => EmailJS.send('', 'my_test_template'),
        throwsA(startsWith('The service ID is required')),
      );
    });

    test('should send method and fail on the template ID', () {
      EmailJS.init('LC2JWGTestKeySomething');

      expect(
        () => EmailJS.send('default_service', ''),
        throwsA(startsWith('The template ID is required')),
      );
    });
  });

  group('EmailJS.send method', () {
    test('should init and send method successfully', () async {
      final mockHttpClient = MockClient();

      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => http.Response('OK', 200));

      EmailJS.init('LC2JWGTestKeySomething', null, mockHttpClient);

      try {
        final result = await EmailJS.send(
          'default_service',
          'my_test_template',
        );
        expect(result, equals('OK'));
      } catch (error) {
        expect(error, isNull);
      }
    });

    test('should send method successfully with 4 params', () async {
      final mockHttpClient = MockClient();

      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => http.Response('OK', 200));

      // pass the mock http client
      EmailJS.init('', null, mockHttpClient);

      try {
        final result = await EmailJS.send(
          'default_service',
          'my_test_template',
          null,
          'LC2JWGTestKeySomething',
        );
        expect(result, equals('OK'));
      } catch (error) {
        expect(error, isNull);
      }
    });

    test('should send method and fail', () async {
      final mockHttpClient = MockClient();

      when(() => mockHttpClient.post(
        any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      )).thenAnswer((_) async => http.Response('The Public Key is required', 403));

      // pass the mock http client
      EmailJS.init('LC2JWGTestKeySomething', null, mockHttpClient);

      try {
        final result = await EmailJS.send(
          'default_service',
          'my_test_template',
        );
        expect(result, isNull);
      } catch (error) {
        expect(error, equals('The Public Key is required'));
      }
    });
  });
}
