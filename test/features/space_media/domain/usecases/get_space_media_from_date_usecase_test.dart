import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:space_media_app/core/errors/errors.dart';
import 'package:space_media_app/features/space_media/domain/entities/entities.dart';
import 'package:space_media_app/features/space_media/domain/repositories/repositories.dart';
import 'package:space_media_app/features/space_media/domain/usecases/usecases.dart';

class MockSpaceMediaRepository extends Mock implements ISpaceMediaRepository {}

void main() {
  late GetSpaceMediaFromDateUsecase usecase;
  late ISpaceMediaRepository repository;

  setUp(() {
    repository = MockSpaceMediaRepository();
    usecase = GetSpaceMediaFromDateUsecase(repository: repository);
  });

  const tSpaceMedia = SpaceMediaEntity(
    description: 'description',
    mediaType: 'mediaType',
    title: 'title',
    mediaUrl: 'mediaUrl',
  );
  final tDate = DateTime(2024, 05, 05);

  test('Should get space media entity for a given date from the repository',
      () async {
    // Arrange
    when(() => repository.getSpaceMediaFromDate(date: tDate))
        .thenAnswer((_) async => const Right(tSpaceMedia));

    // Act
    final result = await usecase(tDate);

    // Assert
    expect(result, const Right(tSpaceMedia));
    verify(() => repository.getSpaceMediaFromDate(date: tDate)).called(1);
  });

  test('should return a ServerFailure when don\'t succeed', () async {
    // Arrange
    when(() => repository.getSpaceMediaFromDate(date: tDate)).thenAnswer(
        (_) async => Left<Failure, SpaceMediaEntity>(ServerFailure()));

    // Act
    final result = await usecase(tDate);

    // Assert
    expect(result, Left(ServerFailure()));
    verify(() => repository.getSpaceMediaFromDate(date: tDate)).called(1);
  });
  
}