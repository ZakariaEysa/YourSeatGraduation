import 'package:dartz/dartz.dart';
import '../../../../../services/failure_service.dart';

abstract class MovieDetailsRepo {
  Future<Either<FailureService, List>> getCinemas(String movieName);
  Future<Either<FailureService, String>> getRate(String movieId);
}
