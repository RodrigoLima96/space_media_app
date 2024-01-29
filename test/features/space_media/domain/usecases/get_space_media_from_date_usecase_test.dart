import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:space_media_app/core/errors/errors.dart';
import 'package:space_media_app/features/space_media/domain/entities/entities.dart';
import 'package:space_media_app/features/space_media/domain/repositories/repositories.dart';
import 'package:space_media_app/features/space_media/domain/usecases/usecases.dart';

import '../../mocks/date_mock.dart';
import '../../mocks/space_media_entity_mock.dart';

class MockSpaceMediaRepository extends Mock implements ISpaceMediaRepository {}

void main() {
  late GetSpaceMediaFromDateUsecase usecase;
  late ISpaceMediaRepository repository;

  setUp(() {
    repository = MockSpaceMediaRepository();
    usecase = GetSpaceMediaFromDateUsecase(repository: repository);
  });

  test('Should get space media entity for a given date from the repository',
      () async {
    // Arrange
    when(() => repository.getSpaceMediaFromDate(date: tDate))
        .thenAnswer((_) async => const Right(tSpaceMediaEntityMock));

    // Act
    final result = await usecase(tDate);

    // Assert
    expect(result, const Right(tSpaceMediaEntityMock));
    verify(() => repository.getSpaceMediaFromDate(date: tDate)).called(1);
  });

  test('should return a ServerFailure when don\'t succeed', () async {
    // Arrange
    when(() => repository.getSpaceMediaFromDate(date: any(named: 'date')))
        .thenAnswer(
            (_) async => Left<Failure, SpaceMediaEntity>(ServerFailure()));

    // Act
    final result = await usecase(tDate);

    // Assert
    expect(result, Left(ServerFailure()));
    verify(() => repository.getSpaceMediaFromDate(date: tDate)).called(1);
  });

  test('Should return a NullParamsFailure when receives a null param',
      () async {
    // Arrange

    // Act
    final result = await usecase(null);

    // Assert
    expect(result, Left(NullParamsFailure()));
    verifyNever(() => repository.getSpaceMediaFromDate(date: tDate));
  });
}
