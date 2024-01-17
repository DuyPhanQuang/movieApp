import '../../data/models/models.dart';
import '../../injector/injection.dart';

extension TVExt on TV {
  String get toGetImageUrl {
    return '${Injection().getMediaHost}$posterPath';
  }
}

extension ListTVValidatorExt on List<TV>? {
  bool get isNotNullAndEmpty {
    return this != null && this!.isNotEmpty;
  }
}
