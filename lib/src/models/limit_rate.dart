class LimitRate {
  /// Sets the throttle ID
  final String? id;

  /// After how many milliseconds a next request is allowed
  final int throttle;

  const LimitRate({
    this.id,
    required this.throttle,
  });
}
