import '../models/limit_rate.dart';
import '../models/storage_provider.dart';
import 'validate_limit_rate_params.dart';

Future<int> getLeftTime(
  String id,
  int throttle,
  StorageProvider storage,
) async {
  final int lastTime = await storage.get(id) ?? 0;
  return throttle - DateTime.now().millisecondsSinceEpoch + lastTime;
}

Future<bool> isLimitRateHit(
  LimitRate options,
  StorageProvider? storage,
) async {
  if (storage == null || options.throttle == null || options.throttle == 0) {
    return false;
  }

  final id = options.id ?? 'default';
  
  validateLimitRateParams(options.throttle!, id);

  final leftTime = await getLeftTime(id, options.throttle!, storage);

  if (leftTime > 0) {
    return true;
  }

  await storage.set(id, DateTime.now().millisecondsSinceEpoch);
  return false;
}
