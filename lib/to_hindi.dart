extension IntExtension on int {
  String toHindi() {
    int number = this;
    int numberOfDigits = 0;

    for (int i = 1; ; i++) {
      number ~/= 10;

      if (number == 0) {
        numberOfDigits = i;
        break;
      }
    }

    number = this;

    final chars = List.filled(numberOfDigits, 0);

    for (int i = 0; i < numberOfDigits; i++) {
      chars[numberOfDigits - 1 - i] = 0x06F0 + (number % 10);
      number ~/= 10;
    }

    return String.fromCharCodes(chars);
  }
}
