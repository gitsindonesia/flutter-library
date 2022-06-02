import '../errors/gits_failures.dart';
import '../utils/either.dart';

abstract class StreamUseCase<Success, Body> {
  Stream<Either<GitsFailure, Success>> call(Body body);
}
