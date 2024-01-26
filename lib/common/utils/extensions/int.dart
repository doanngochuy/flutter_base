extension IntExtension on int {
  String toDigit(int digit) => toString().padLeft(digit, '0');
}