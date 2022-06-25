/// Interface for [Either] data value in [Left] or [Right]
abstract class Either<L, R> {
  /// Function to call function if in [Left] and if in [Right]
  B fold<B>(
    B Function(L left) ifLeft,
    B Function(R right) ifRight,
  );
}

/// Class value [Either] if in [Left]
class Left<L, R> extends Either<L, R> {
  Left(this._l);

  final L _l;
  L get value => _l;
  @override
  B fold<B>(
    B Function(L l) ifLeft,
    B Function(R r) ifRight,
  ) =>
      ifLeft(_l);
  @override
  bool operator ==(other) => other is Left && other._l == _l;
  @override
  int get hashCode => _l.hashCode;
}

/// Class value [Either] if in [Right]
class Right<L, R> extends Either<L, R> {
  Right(this._r);

  final R _r;
  R get value => _r;
  @override
  B fold<B>(
    B Function(L l) ifLeft,
    B Function(R r) ifRight,
  ) =>
      ifRight(_r);
  @override
  bool operator ==(other) => other is Right && other._r == _r;
  @override
  int get hashCode => _r.hashCode;
}
