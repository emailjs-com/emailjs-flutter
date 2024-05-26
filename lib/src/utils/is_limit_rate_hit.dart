import '../modles/limit_rate.dart';
import '../modles/storage_provider.dart';
import 'validate_limit_rate_params.dart';

Future<int> getLeftTime(
  String id,
  int throttle,
  StorageProvider storage,
) async {
  final int lastTime = storage.getInt(id) ?? 0;
  return throttle - DateTime.now().millisecondsSinceEpoch + lastTime;
}

Future<bool> isLimitRateHit(
  String defaultID,
  LimitRate options,
  StorageProvider? storage,
) async {
  if (storage == null) {
    return false;
  }

  validateLimitRateParams(options.throttle);

  final id = options.id ?? 'default';
  final leftTime = getLeftTime(id, options.throttle);

  if (leftTime > 0) {
    return true;
  }

  await storage.setInt(id, DateTime.now().millisecondsSinceEpoch);
  return false;
}
