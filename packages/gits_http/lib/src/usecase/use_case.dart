import '../errors/gits_failures.dart';
import '../utils/either.dart';

/// The interface for future use case
abstract interface class UseCase<Success, Body> {
  Future<Either<GitsFailure, Success>> call(Body body);
}
