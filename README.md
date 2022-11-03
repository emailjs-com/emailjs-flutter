# Official EmailJS SDK for Flutter

SDK for [EmailJS.com](https://www.emailjs.com) customers.
\
Use you EmailJS account for sending emails.

## Disclaimer

This is a flutter-only version, otherwise use
the [REST API](https://www.emailjs.com/docs/rest-api/send/).

## Links

[Official SDK Docs](https://www.emailjs.com/docs)

## Intro

EmailJS helps to send emails using client-side technologies only.
No server is required – just connect EmailJS to one of the supported
email services, create an email template, and use our SDK
to trigger an email.

## Usage

Install EmailJS SDK:

```bash 
$ flutter pub add emailjs 
```

## Examples

**send email**

```dart 
import package:emailjs/emailjs.dart

Map<String, dynamic> templateParams = {
  'name': 'James',
  'notes': 'Check this out!'
};

try {
  await EmailJS.send(
    '<YOUR_SERVICE_ID>',
    '<YOUR_TEMPLATE_ID>',
    templateParams,
    const Options(
      publicKey: '<YOUR_PUBLIC_KEY>',
      privateKey: '<YOUR_PRIVATE_KEY>',
    ),
  );
  print('SUCCESS!');
} catch (error) {
  print(error.toString());
}
```

**init (optional)**
```dart 
import package:emailjs/emailjs.dart

// set Public Key as global settings
EmailJS.init(const Options(
  publicKey: '<YOUR_PUBLIC_KEY>',
  privateKey: '<YOUR_PRIVATE_KEY>',
));

try {
  // send the email without dynamic variables
  await EmailJS.send(
    '<YOUR_SERVICE_ID>',
    '<YOUR_TEMPLATE_ID>',
  );
  print('SUCCESS!');
} catch (error) {
  print(error.toString());
}
```
