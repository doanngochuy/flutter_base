# flutter_base

Rebuild project with multi-flatform mobile, web app.

## Getting Started

1. Run `flutter pub run build_runner build` (run again if code has changed)
   or `flutter pub run build_runner watch` (changed automatically on save code) in terminal to
   generate file `*.g.dart` (Json serializable, hive, chopper)
2. Install Extension "Flutter Intl" (https://plugins.jetbrains.com/plugin/13666-flutter-intl).
   Run `flutter pub get` in terminal and save the code to generate language (`lib/generated/*`)

## Run product flavor (or environment)

1. Go to `lib/`
2. Choose a file `main_*.dart` and run debug mode with a desired flavor (or environment)
   ex: `main_prod.dart` to run production environment