import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:space_media_app/core/errors/errors.dart';
import 'package:space_media_app/features/space_media/domain/usecases/usecases.dart';
import 'package:space_media_app/features/space_media/presenter/controllers/controllers.dart';

import '../../mocks/date_mock.dart';
import '../../mocks/space_media_entity_mock.dart';

class MockGetSpaceMediaFromDateUsecase extends Mock
    implements GetSpaceMediaFromDateUsecase {}

void main() {
  late HomeStore store;
  late GetSpaceMediaFromDateUsecase mockUsecase;

  setUp(() {
    mockUsecase = MockGetSpaceMediaFromDateUsecase();
    store = HomeStore(usecase: mockUsecase);
  });

  test('Should return a SpaceMediaEntity from the usecase', () async {
    // Arrange
    when(() => mockUsecase(any()))
        .thenAnswer((_) async => const Right(tSpaceMediaEntityMock));

    // Act
    await store.getSpaceMediaFromDate(date: tDate);

    // Assert
    store.observer(onState: (state) {
      expect(state, tSpaceMediaEntityMock);
      verify(() => mockUsecase(tDate)).called(1);
    });
  });

  test('Should return a Failure from the usecase when there is an error',
      () async {
    // Assert
    final tFailure = ServerFailure();
    when(() => mockUsecase(any())).thenAnswer((_) async => Left(tFailure));

    // Act
    await store.getSpaceMediaFromDate(date: tDate);

    // Assert
    store.observer(onError: (error) {
      expect(error, tFailure);
      verify(() => mockUsecase(tDate)).called(1);
    });
  });
}
