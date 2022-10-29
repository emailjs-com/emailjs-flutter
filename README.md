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
  await EmailJS.send('<YOUR_SERVICE_ID>','<YOUR_TEMPLATE_ID>', templateParams, '<YOUR_PUBLIC_KEY>');
  print('SUCCESS!');
} catch (error) {
  print(error.toString());
}
```
