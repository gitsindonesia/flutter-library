import '../errors/gits_failures.dart';
import '../utils/either.dart';

/// The interface for stream use case
abstract class StreamUseCase<Success, Body> {
  Stream<Either<GitsFailure, Success>> call(Body body);
}
