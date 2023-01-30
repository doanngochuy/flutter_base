abstract class Functor<T> {
  Functor<U> fmap<U>(U Function(T value) f);
}

abstract class Applicative<T> {
  Applicative<U> apply<U>(Applicative<U Function(T value)> other);
}

abstract class Monad<T> {
  Monad<U> bind<U>(Monad<U> Function(T value) f);
}

/// The Maybe type encapsulates an optional value.
/// Using Maybe is a good way to deal with errors or
/// exceptional cases without resorting to
/// drastic measures such as error.
abstract class Maybe<T> implements Functor<T>, Applicative<T>, Monad<T> {}

/// Represents a value of type Maybe that contains a value
/// (represented as Just a).
class Just<T> extends Maybe<T> {
  T value;

  Just(this.value);

  @override
  Maybe<U> apply<U>(covariant Maybe<U Function(T)> f) => f.fmap((ff) => ff(value)) as Maybe<U>;

  @override
  Maybe<U> bind<U>(covariant Maybe<U> Function(T value) f) => f(value);

  @override
  Maybe<U> fmap<U>(U Function(T value) f) => Just(f(value));

  @override
  String toString() => 'Just($value)';
}

/// Represents an empty Maybe that holds nothing
/// (in which case it has the value of Nothing)
class Nothing<T> extends Maybe<T> {
  Nothing();

  @override
  Maybe<U> apply<U>(covariant Maybe<U Function(T)> other) => Nothing();

  @override
  Maybe<U> bind<U>(covariant Maybe<U> Function(T value) f) => Nothing();

  @override
  Maybe<U> fmap<U>(U Function(T value) f) => Nothing();

  @override
  String toString() => 'Nothing';
}

/// test
// ignore_for_file: avoid_print
// ignore_for_file: prefer_function_declarations_over_variables
void main() {
  plus3(int x) => x + 3;
  final minus7 = (int x) => x - 7;
  final times2 = (int x) => x * 2;
  final divideBy2 = (int x) => x / 2;

  // Functor
  print(Just(20).fmap(plus3).fmap(minus7).fmap(times2).fmap(times2).fmap(divideBy2));
  print(Nothing<int>().fmap(plus3));

  // Applicative
  print(Just(5).apply(Just(plus3)).apply(Just(times2)).apply(Just(divideBy2)));

  // Monad
  final maybePlus3 = (int a) => Just(a + 3);
  final half = (int a) => a.isEven ? Just<int>(a ~/ 2) : Nothing<int>();

  print(Just(5).bind(maybePlus3).bind(half));
}
