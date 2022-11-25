# Official EmailJS SDK for Flutter

SDK for [EmailJS.com](https://www.emailjs.com) customers.
\
Use you EmailJS account for sending emails.

## Disclaimer

This is a flutter-only version, otherwise use
- [Browser SDK](https://www.npmjs.com/package/@emailjs/browser)
- [Node.js SDK](https://www.npmjs.com/package/@emailjs/nodejs)
- [REST API](https://www.emailjs.com/docs/rest-api/send/)

## Links

[Official SDK Docs](https://www.emailjs.com/docs)

## Intro

EmailJS helps to send emails directly from your code.
No large knowledge is required – just connect EmailJS to one of the supported
email services, create an email template, and use our SDK
to trigger an email.

## Usage

Install EmailJS SDK:

```bash 
$ flutter pub add emailjs 
```

***Note***: By default, API requests are disabled for non-browser applications.
You need to activate them through [Account:Security](https://dashboard.emailjs.com/admin/account/security).

## FAQ

#### API calls are disabled for non-browser applications
You need to activate API requests
through [Account:Security](https://dashboard.emailjs.com/admin/account/security).

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
