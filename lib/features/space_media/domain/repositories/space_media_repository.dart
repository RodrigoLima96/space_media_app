import 'package:dartz/dartz.dart';
import '../../../../core/errors/errors.dart';
import '../entities/entities.dart';

abstract class ISpaceMediaRepository {
  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaFromDate({required DateTime date});
}