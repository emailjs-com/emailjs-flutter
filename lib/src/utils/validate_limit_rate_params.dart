void validateLimitRateParams(int throttle) {
  if (throttle < 0) {
    throw 'The LimitRate throttle has to be a positive number';
  }
}