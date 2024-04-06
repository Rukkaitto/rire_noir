import 'dart:math';

class PinCodeGenerator {
  static String generateRandomPin() {
    final random = Random();
    final intLength = 3; // Number of digits in the pin
    final alphaLength = 3; // Number of alphabets in the pin

    // Generate random digits
    final digits = List.generate(intLength, (_) => random.nextInt(10));

    // Generate random alphabets
    final alphabets = List.generate(
        alphaLength, (_) => String.fromCharCode(random.nextInt(26) + 65));

    // Combine digits and alphabets
    final pin = List.generate(intLength + alphaLength, (index) {
      if (index % 2 == 0) {
        return digits[index ~/ 2].toString();
      } else {
        return alphabets[index ~/ 2];
      }
    }).join();

    return pin;
  }
}
