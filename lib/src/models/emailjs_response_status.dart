class EmailJSResponseStatus {
  int status = 0;
  String text = 'Network Error';

  EmailJSResponseStatus(int? status, String? text) {
    this.status = status ?? 0;
    this.text = text ?? 'Network Error';
  }
}
