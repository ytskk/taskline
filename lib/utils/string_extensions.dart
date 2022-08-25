extension StringExtensions on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${this.substring(1)}';
  }
}
