import '../../data/models/models.dart';
import '../../injector/injection.dart';

extension MovieExt on Movie {
  String get toGetImageUrl {
    return '${Injection().getMediaHost}$posterPath';
  }
}

extension ListMovieValidatorExt on List<Movie>? {
  bool get isNotNullAndEmpty {
    return this != null && this!.isNotEmpty;
  }
}
