import '../errors/gits_failures.dart';
import '../utils/either.dart';

abstract class UseCase<Success, Body> {
  Future<Either<GitsFailure, Success>> call(Body body);
}
