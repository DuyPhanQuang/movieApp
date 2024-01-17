import '../../../core/entity/entity.dart';
import '../../constants/constants.dart';

class Movie extends BaseEntity {
  final int id;
  final bool adult;
  final String originalLanguage;
  final String originalTitle;
  final String backdropPath;
  final String posterPath;
  final String overview;
  final double popularity;
  final String releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Movie({
    required this.id,
    required this.adult,
    required this.originalLanguage,
    required this.originalTitle,
    required this.backdropPath,
    required this.posterPath,
    required this.overview,
    required this.popularity,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  // ignore: prefer_constructors_over_static_methods
  static Movie fromJson(Map<String, dynamic> json) {
    final popularity = double.tryParse('${json['popularity']}');
    final voteAverage = double.tryParse('${json['vote_average']}');
    final voteCount = int.tryParse('${json['vote_count']}');

    return Movie(
      id: json['id'],
      adult: json['adult'] ?? false,
      originalLanguage: json['original_language'] ?? ModelDefaultValue.string,
      originalTitle: json['original_title'] ?? ModelDefaultValue.string,
      backdropPath: json['backdrop_path'] ?? ModelDefaultValue.string,
      posterPath: json['poster_path'] ?? ModelDefaultValue.string,
      overview: json['overview'] ?? ModelDefaultValue.string,
      popularity: popularity ?? ModelDefaultValue.doubleNumber,
      releaseDate: json['release_date'] ?? ModelDefaultValue.string,
      title: json['title'] ?? ModelDefaultValue.string,
      video: json['video'] ?? false,
      voteAverage: voteAverage ?? ModelDefaultValue.doubleNumber,
      voteCount: voteCount ?? ModelDefaultValue.intNumber,
    );
  }

  /// follow business
  @override
  List<Object?> get props => [
        id,
        originalTitle,
        title,
        overview,
        releaseDate,
        posterPath,
      ];

  @override
  Map<String, dynamic>? toJson() => null;
}
