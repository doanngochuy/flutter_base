import 'package:EMO/common/generated/l10n.dart';

enum Gender {
  men(1),
  women(2),
  other(0);

  final int value;

  const Gender(this.value);

  String get text {
    switch (this) {
      case Gender.other:
        return S.current.Khac;
      case Gender.men:
        return S.current.Nam;
      case Gender.women:
        return S.current.Nu;
    }
  }
}
