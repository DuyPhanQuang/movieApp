import '../../../core/entity/entity.dart';
import '../../constants/constants.dart';

class TV extends BaseEntity {
  final int id;
  final String name;
  final String originalLanguage;
  final String originalName;
  final String backdropPath;
  final String posterPath;
  final String overview;
  final double popularity;
  final String firstAirDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  TV({
    required this.id,
    required this.name,
    required this.originalLanguage,
    required this.originalName,
    required this.backdropPath,
    required this.posterPath,
    required this.overview,
    required this.popularity,
    required this.firstAirDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  // ignore: prefer_constructors_over_static_methods
  static TV fromJson(Map<String, dynamic> json) {
    final popularity = double.tryParse(json['popularity']);
    final voteAverage = double.tryParse(json['vote_average']);
    final voteCount = int.tryParse(json['vote_count']);

    return TV(
      id: json['id'],
      name: json['name'] ?? ModelDefaultValue.string,
      originalLanguage: json['original_language'] ?? ModelDefaultValue.string,
      originalName: json['original_name'] ?? ModelDefaultValue.string,
      backdropPath: json['backdrop_path'] ?? ModelDefaultValue.string,
      posterPath: json['poster_path'] ?? ModelDefaultValue.string,
      overview: json['overview'] ?? ModelDefaultValue.string,
      popularity: popularity ?? ModelDefaultValue.doubleNumber,
      firstAirDate: json['first_air_date'] ?? ModelDefaultValue.string,
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
        originalName,
        title,
        overview,
        firstAirDate,
        posterPath,
      ];

  @override
  Map<String, dynamic>? toJson() => null;
}
