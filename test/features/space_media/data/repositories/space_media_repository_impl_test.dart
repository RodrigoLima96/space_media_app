import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:space_media_app/core/errors/errors.dart';
import 'package:space_media_app/features/space_media/data/datasources/datasources.dart';
import 'package:space_media_app/features/space_media/data/models/models.dart';
import 'package:space_media_app/features/space_media/data/repositories/repositories.dart';

class MockSpaceMediaDatasource extends Mock implements ISpaceMediaDatasource {}

void main() {
  late SpaceMediaRepositoryImpl repository;
  late ISpaceMediaDatasource dataSource;

  setUp(() {
    dataSource = MockSpaceMediaDatasource();
    repository = SpaceMediaRepositoryImpl(datasource: dataSource);
  });

  final tDate = DateTime(2024, 05, 05);
  const tSpaceMediaModel = SpaceMediaModel(
    description: 'description',
    mediaType: 'mediaType',
    title: 'title',
    mediaUrl: 'mediaUrl',
  );

  test('Should return SpaceMediaModel when calls the datasource', () async {
    // Arrange
    when(() => dataSource.getSpaceMediaFromDate(date: tDate))
        .thenAnswer((_) async => tSpaceMediaModel);

    // Act
    final result = await repository.getSpaceMediaFromDate(date: tDate);

    // Assert
    expect(result, const Right(tSpaceMediaModel));
    verify(() => dataSource.getSpaceMediaFromDate(date: tDate)).called(1);
  });

  test(
      'Should return a Server Failure when the call to datasource is unsuccessful',
      () async {
    // Arrange
    when(() => dataSource.getSpaceMediaFromDate(date: tDate))
        .thenThrow(ServerException());

    // Act
    final result = await repository.getSpaceMediaFromDate(date: tDate);
    // Assert
    expect(result, Left(ServerFailure()));
    verify(() => dataSource.getSpaceMediaFromDate(date: tDate)).called(1);
  });
}
