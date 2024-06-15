void validateLimitRateParams(int throttle, [String? id]) {
  if (throttle < 0) {
    throw 'The LimitRate throttle has to be a positive number';
  }

  if (id != null && id.isEmpty) {
    throw 'The LimitRate ID has to be a non-empty string';
  }
}
