import 'package:dartz/dartz.dart';
import '../remote_data_source/movie_details_remote_data_source.dart';
import '../../domain/repos/movie_details_repo.dart';
import '../../../../../services/failure_service.dart';

class MovieDetailsRepoImpl implements MovieDetailsRepo {
  final MovieDetailsRemoteDataSource movieDetailsRemoteDataSource;

  MovieDetailsRepoImpl(this.movieDetailsRemoteDataSource);

  @override
  Future<Either<FailureService, List>> getCinemas(String movieName) async {
    try {
      final cinemas = await movieDetailsRemoteDataSource.getCinemas(movieName);

      return Right(cinemas);
    } catch (e) {
      return Left(ServiceFailure(e.toString()));
    }
  }

  @override
  Future<Either<FailureService, String>> getRate(String movieId) async {
    try {
      final rate = await movieDetailsRemoteDataSource.getRate(movieId);

      return Right(rate);
    } catch (e) {
      return Left(ServiceFailure(e.toString()));
    }
  }
}
