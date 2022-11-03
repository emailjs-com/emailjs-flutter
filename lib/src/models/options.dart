class Options {
  /// The public key is passed unmodified to API call.
  final String publicKey;

  /// The private key is passed unmodified to API call.
  final String? privateKey;

  const Options({
    this.publicKey = '',
    this.privateKey,
  });
}
