import 'package:flutter/material.dart';

/// Configuration class for application localization and language settings.
/// Defines the supported languages and provides logic for selecting the app's locale.
class LocaleConfig {
  /// The list of languages officially supported by the application.
  /// Currently includes English, Turkish, Spanish, Russian, German, French, Italian, and Portuguese.
  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('tr'),
    Locale('es'),
    Locale('ru'),
    Locale('de'),
    Locale('fr'),
    Locale('it'),
    Locale('pt'),
  ];

  /// A callback that determines which supported locale should be used by the application
  /// based on the user's device settings.
  /// 
  /// - [deviceLocale] is the locale detected from the user's device.
  /// - [supportedLocales] is the list of locales the app provides translations for.
  /// 
  /// Returns the matching supported locale if found; otherwise, defaults to English ('en').
  static Locale? localeResolutionCallback(
      Locale? deviceLocale, Iterable<Locale> supportedLocales) {
    // Fallback to English if the device locale cannot be determined.
    if (deviceLocale == null) {
      return const Locale('en');
    }

    // Check if the device's language is one of the supported languages.
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == deviceLocale.languageCode) {
        return supportedLocale;
      }
    }

    // Default to English if the device language is not supported.
    return const Locale('en');
  }
}
