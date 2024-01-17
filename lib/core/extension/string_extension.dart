import '../regex/regex.dart';

extension StringExt on String {
  String uriPath() {
    final uri = Uri.tryParse(this);
    return uri!.path;
  }
}

extension StringValidatorExt on String? {
  bool get isNotNullAndEmpty => this != null && this!.isNotEmpty;

  bool get isNullOrEmpty => (this != null ? this!.trim() : '').isEmpty;

  bool isURL() => RegExp(RegexConstants.validUrlRegex, caseSensitive: false)
      .hasMatch(this!);
}
