import 'package:dartz/dartz.dart';
import 'package:space_media_app/core/errors/failures.dart';
import 'package:space_media_app/core/usecases/usecases.dart';
import 'package:space_media_app/features/space_media/domain/entities/entities.dart';
import 'package:space_media_app/features/space_media/domain/repositories/repositories.dart';

class GetSpaceMediaFromDateUsecase implements Usecase<SpaceMediaEntity, DateTime> {
  final ISpaceMediaRepository repository;

  const GetSpaceMediaFromDateUsecase({required this.repository});

  @override
  Future<Either<Failure, SpaceMediaEntity>> call(DateTime date) async {
    return await repository.getSpaceMediaFromDate(date: date);
  }
}