import 'package:flutter/material.dart';

/// Used for all animations in the  app

/// Times if it have animations
/// eg: -10% color, +10% color
Color shift(Color c, double amt) {
  var hslc = HSLColor.fromColor(c); // Convert to HSL
  double lightness =
      (hslc.lightness + amt).clamp(0, 1.0) as double; // Add/Remove lightness
  return hslc.withLightness(lightness).toColor(); // Convert back to Color
}

class Times {
  static const Duration fastest = Duration(milliseconds: 150);
  static const fast = Duration(milliseconds: 250);
  static const medium = Duration(milliseconds: 350);
  static const slow = Duration(milliseconds: 700);
  static const slower = Duration(milliseconds: 1000);
  static const verySlower = Duration(milliseconds: 1500);
}

class Sizes {
  static double hitScale = 1;

  static void setHitScale(double value) {
    hitScale = value;
  }

  static double get hit => 40 * hitScale;
}

class IconSizes {
  static double scale = 1;

  static void setScale(double value) {
    scale = value;
  }

  static double get xs => 14 * scale;

  static double get sm => 18 * scale;

  static double get med => 24 * scale;

  static double get mid => 28 * scale;

  static double get lg => 32 * scale;

  static double get xl => 40 * scale;
}

/// Padding
class Insets {
  static double scale = 1;
  static double offsetScale = 1;

  static void setScale(double value) {
    scale = value;
    offsetScale = value;
  }

  // Regular paddings
  static double get xs => 4 * scale;

  static double get sm => 8 * scale;

  static double get med => 12 * scale;

  static double get lg => 18 * scale;

  static double get xl => 32 * scale;

  // Offset, used for the edge of the window, or to separate large sections in the app
  static double get offset => 40 * offsetScale;
}

/// Height
class Height {
  static double scale = 1;

  static void setScale(double value) {
    scale = value;
  }

  static double get xs => 32 * scale;

  static double get sm => 36 * scale;

  static double get med => 40 * scale;

  static double get lg => 44 * scale;

  static double get xl => 48 * scale;
}

/// Border radius
class Corners {
  static const double sm = 3;
  static const BorderRadius smBorder = BorderRadius.all(smRadius);
  static const Radius smRadius = Radius.circular(sm);

  static const double med = 5;
  static const BorderRadius medBorder = BorderRadius.all(medRadius);
  static const Radius medRadius = Radius.circular(med);

  static const double lg = 8;
  static const BorderRadius lgBorder = BorderRadius.all(lgRadius);
  static const Radius lgRadius = Radius.circular(lg);

  static const double xl = 11;
  static const BorderRadius xlBorder = BorderRadius.all(xlRadius);
  static const Radius xlRadius = Radius.circular(xl);

  static const double custom20 = 20;
  static const BorderRadius custom20Border = BorderRadius.all(custom20Radius);
  static const Radius custom20Radius = Radius.circular(custom20);

  static const double custom25 = 25;
  static const BorderRadius custom25Border = BorderRadius.all(custom25Radius);
  static const Radius custom25Radius = Radius.circular(custom25);
}

/// Border width
class Strokes {
  static const double thin = 1;
  static const double med = 2;
  static const double thick = 4;
}

class Shadows {
  static List<BoxShadow> get cards => [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          blurRadius: 4.0,
          spreadRadius: 1.0,
          offset: const Offset(0.0, 0.0),
        )
      ];

  static List<BoxShadow> get primaryShadow => [
        BoxShadow(
          color: const Color.fromARGB(38, 27, 27, 29).withOpacity(.15),
          offset: const Offset(0, 5),
          blurRadius: 10,
        )
      ];

  static List<BoxShadow> get universal => [
        BoxShadow(
          color: const Color(0xff333333).withOpacity(.15),
          spreadRadius: 0,
          blurRadius: 10,
        ),
      ];

  static List<BoxShadow> get small => [
        BoxShadow(
          color: const Color(0xff333333).withOpacity(.15),
          spreadRadius: 0,
          blurRadius: 3,
          offset: const Offset(0, 1),
        ),
      ];
}

/// You can use these directly if you need, but usually there should be a predefined styles in TextStyles.
class FontSizes {
  /// Provides the ability to nudge the app-wide font scale in either direction
  static double scale = 1;

  static void setScale(double value) {
    scale = value;
  }

  static double get s10 => 10 * scale;

  static double get s11 => 11 * scale;

  static double get s12 => 12 * scale;

  static double get s14 => 14 * scale;

  static double get s16 => 16 * scale;

  static double get s18 => 18 * scale;

  static double get s24 => 24 * scale;

  static double get s48 => 48 * scale;
}

/// Fonts - A list of Font Families, this is uses by the TextStyles class to create concrete styles.
class Fonts {
  static const String roboto = "Roboto";
  static const String googleSans = "GoogleSans";
}

/// TextStyles - All the core text styles for the app should be declared here.
/// Don't try and create every variant in existence here, just the high level ones.
/// More specific variants can be created on the fly using `styles.copyWith()`
/// `newStyle = TextStyles.body1.copyWith(lineHeight: 2, color: Colors.red)`
class TextStyles {
  /// Declare a base styles for each Family
  static const TextStyle roboto = TextStyle(
    fontFamily: Fonts.roboto,
    fontWeight: FontWeight.w400,
    height: 1,
    overflow: TextOverflow.ellipsis,
  );
  static const TextStyle googleSans = TextStyle(
    fontFamily: Fonts.googleSans,
    fontWeight: FontWeight.w400,
    height: 1,
    overflow: TextOverflow.ellipsis,
  );

  static TextStyle get h1 => googleSans.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: FontSizes.s48,
        letterSpacing: -1,
        height: 1.17,
      );

  static TextStyle get h2 => h1.copyWith(
        fontSize: FontSizes.s24,
        letterSpacing: -.5,
        height: 1.16,
      );

  static TextStyle get h3 => h1.copyWith(
        fontSize: FontSizes.s14,
        letterSpacing: -.05,
        height: 1.29,
      );

  static TextStyle get title1 => googleSans.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: FontSizes.s16,
        height: 1.31,
      );

  static TextStyle get title2 => title1.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: FontSizes.s14,
        height: 1.36,
      );

  static TextStyle get button1 => googleSans.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: FontSizes.s14,
        height: 1,
      );

  static TextStyle get input1 => googleSans.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: FontSizes.s14,
        height: 1,
      );

  static TextStyle get body1 => googleSans.copyWith(
        fontWeight: FontWeight.normal,
        fontSize: FontSizes.s14,
        height: 1.71,
      );

  static TextStyle get body2 => body1.copyWith(
        fontSize: FontSizes.s12,
        height: 1.5,
        letterSpacing: .2,
      );

  static TextStyle get body3 => body1.copyWith(
        fontSize: FontSizes.s12,
        height: 1.5,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get callout1 => googleSans.copyWith(
        fontWeight: FontWeight.w800,
        fontSize: FontSizes.s12,
        height: 1.17,
        letterSpacing: .5,
      );

  static TextStyle get callout2 => callout1.copyWith(
        fontSize: FontSizes.s10,
        height: 1,
        letterSpacing: .25,
      );

  static TextStyle get caption => googleSans.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: FontSizes.s11,
        height: 1.36,
      );
}
