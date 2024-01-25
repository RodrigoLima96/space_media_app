import 'package:dartz/dartz.dart';
import '../../../../core/errors/errors.dart';
import '../datasources/datasource.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';

class SpaceMediaRepositoryImpl implements ISpaceMediaRepository {
  final ISpaceMediaDatasource datasource;

  const SpaceMediaRepositoryImpl({required this.datasource});
  @override
  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaFromDate({
    required DateTime date,
  }) async {
    try {
      final result = await datasource.getSpaceMediaFromDate(date: date);
      return Right(result);
    } on Exception {
      return Left(ServerFailure());
    }
  }
}
