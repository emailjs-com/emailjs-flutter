/// Response status from EmailJS API
class EmailJSResponseStatus {
  /// Response status code
  final int status;

  /// Response text
  final String text;

  const EmailJSResponseStatus({
    this.status = 0,
    this.text = 'Network Error',
  });
}
