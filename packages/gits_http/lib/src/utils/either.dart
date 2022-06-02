abstract class Either<S, F> {
  B fold<B>(
    B Function(S success) ifSuccess,
    B Function(F failure) ifFailure,
  );
}

class Left<L, R> extends Either<L, R> {
  Left(this._l);

  final L _l;
  L get value => _l;
  @override
  B fold<B>(
    B Function(L l) ifSuccess,
    B Function(R r) ifFailure,
  ) =>
      ifSuccess(_l);
  @override
  bool operator ==(other) => other is Left && other._l == _l;
  @override
  int get hashCode => _l.hashCode;
}

class Right<L, R> extends Either<L, R> {
  Right(this._r);

  final R _r;
  R get value => _r;
  @override
  B fold<B>(
    B Function(L l) ifSuccess,
    B Function(R r) ifFailure,
  ) =>
      ifFailure(_r);
  @override
  bool operator ==(other) => other is Right && other._r == _r;
  @override
  int get hashCode => _r.hashCode;
}
