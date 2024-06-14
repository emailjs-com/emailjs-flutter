# Official EmailJS SDK for Flutter

SDK for [EmailJS.com](https://www.emailjs.com) customers.
\
Use you EmailJS account for sending emails.

## Disclaimer

This is a flutter-only version, otherwise use
- [Browser SDK](https://www.npmjs.com/package/@emailjs/browser)
- [Node.js SDK](https://www.npmjs.com/package/@emailjs/nodejs)
- [React Native SDK](https://www.npmjs.com/package/@emailjs/react-native)
- [REST API](https://www.emailjs.com/docs/rest-api/send/)

## Links

[Official SDK Docs](https://www.emailjs.com/docs)

## Intro

EmailJS helps to send emails directly from your code.
No server is required – just connect EmailJS to one of the supported
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
import package:emailjs/emailjs.dart as emailjs

Map<String, dynamic> templateParams = {
  'name': 'James',
  'notes': 'Check this out!'
};

try {
  await emailjs.send(
    'YOUR_SERVICE_ID',
    'YOUR_TEMPLATE_ID',
    templateParams,
    const emailjs.Options(
      publicKey: 'YOUR_PUBLIC_KEY',
      privateKey: 'YOUR_PRIVATE_KEY',
    ),
  );
  print('SUCCESS!');
} catch (error) {
  print('$error');
}
```

**init (optional)**
```dart 
import package:emailjs/emailjs.dart as emailjs

// set Public Key as global settings
emailjs.init(const emailjs.Options(
  publicKey: 'YOUR_PUBLIC_KEY',
  privateKey: 'YOUR_PRIVATE_KEY',
));

try {
  // send the email without dynamic variables
  await emailjs.send(
    'YOUR_SERVICE_ID',
    'YOUR_TEMPLATE_ID',
  );
  print('SUCCESS!');
} catch (error) {
  print('$error');
}
```
