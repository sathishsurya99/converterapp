class UnitConverter {
  static double convertLength(double value, String from, String to) {
    const Map<String, double> meters = {
      'Meters': 1,
      'Kilometers': 0.001,
      'Centimeters': 100,
      'Inches': 39.3701,
      'Feet': 3.28084,
    };

    return value / meters[from]! * meters[to]!;
  }

  static double convertWeight(double value, String from, String to) {
    const Map<String, double> grams = {
      'Grams': 1,
      'Kilograms': 0.001,
      'Pounds': 0.00220462,
      'Ounces': 0.035274,
    };
    return value / grams[from]! * grams[to]!;
  }

  static double convertTemperature(double value, String from, String to) {
    if (from == to) return value;

    if (from == 'Celsius') {
      return to == 'Fahrenheit' ? (value * 9 / 5) + 32 : value + 273.15;
    } else if (from == 'Fahrenheit') {
      return to == 'Celsius'
          ? (value - 32) * 5 / 9
          : (value - 32) * 5 / 9 + 273.15;
    } else {
      return to == 'Celsius' ? value - 273.15 : (value - 273.15) * 9 / 5 + 32;
    }
  }
}
