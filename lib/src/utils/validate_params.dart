/// Validates required params
void validateParams(
  String? publicKey,
  String? serviceID,
  String? templateID,
) {
  if (publicKey == null || publicKey.isEmpty) {
    throw 'The public key is required. Visit https://dashboard.emailjs.com/admin/account';
  }

  if (serviceID == null || serviceID.isEmpty) {
    throw 'The service ID is required. Visit https://dashboard.emailjs.com/admin';
  }

  if (templateID == null || templateID.isEmpty) {
    throw 'The template ID is required. Visit https://dashboard.emailjs.com/admin/templates';
  }
}
