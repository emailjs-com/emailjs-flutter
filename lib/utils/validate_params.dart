bool validateParams(
  String publicKey,
  String serviceID,
  String templateID,
) {
  if (publicKey.isEmpty) {
    throw 'The public key is required. Visit https://dashboard.emailjs.com/admin/account';
  }

  if (serviceID.isEmpty) {
    throw 'The service ID is required. Visit https://dashboard.emailjs.com/admin';
  }

  if (templateID.isEmpty) {
    throw 'The template ID is required. Visit https://dashboard.emailjs.com/admin/templates';
  }

  return true;
}
