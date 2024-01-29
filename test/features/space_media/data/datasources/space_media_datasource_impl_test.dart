import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:space_media_app/core/errors/errors.dart';
import 'package:space_media_app/core/utils/converters/date_to_string_converter.dart';
import 'package:space_media_app/features/space_media/data/datasources/datasources.dart';
import 'package:http/http.dart' as http;

import '../../mocks/space_media_json_mock.dart';
import '../../mocks/space_media_model_mock.dart';

class MockDateInputConverter extends Mock implements DateToStringConverter {}

class HttpClientMock extends Mock implements http.Client {}

void main() {
  late MockDateInputConverter converter;
  late SpaceMediaDatasourceImpl datasource;
  late http.Client client;

  setUp(() {
    converter = MockDateInputConverter();
    client = HttpClientMock();
    datasource = SpaceMediaDatasourceImpl(client: client, converter: converter);
    registerFallbackValue(Uri());
  });

  const tDateString = '2024-05-05';
  final tDate = DateTime(2024, 05, 05);

  void successMock() {
    when(() => converter.convert(date: any(named: 'date')))
        .thenReturn(tDateString);
    when(() => client.get(any()))
        .thenAnswer((_) async => http.Response(spaceMediaJsonMock, 200));
  }

  test(
      'Should call DateToStringConverter to convert the DateTime into a String',
      () async {
    // Arrange
    successMock();

    // Act
    await datasource.getSpaceMediaFromDate(date: tDate);

    // Assert
    verify(() => converter.convert(date: tDate)).called(1);
  });

  test('Should call the get method with correct url', () async {
    // Arrange
    successMock();

    // Act
    await datasource.getSpaceMediaFromDate(date: tDate);

    // Assert
    verify(() => client.get(Uri.https('api.nasa.gov', '/planetary/apod', {
          'api_key': 'DEMO_KEY',
          'date': '2024-05-05',
        }))).called(1);
  });

  test('Should return a SpaceMediaModel when the call is successful', () async {
    // Arrange
    successMock();

    // Act
    final result = await datasource.getSpaceMediaFromDate(date: tDate);

    // Assert
    expect(result, tSpaceMediaModelMock);
    verify(() => converter.convert(date: tDate)).called(1);
  });

  test('Should throw a ServerException when the call is unsuccessful',
      () async {
    // Arrange
    when(() => converter.convert(date: any(named: 'date')))
        .thenReturn(tDateString);

    when(() => client.get(any())).thenAnswer(
      (_) async => http.Response('Something went wrong', 400));

    // Act
    final result = datasource.getSpaceMediaFromDate(date: tDate);

    // Assert
    expect(() => result, throwsA(ServerException()));
    verify(() => converter.convert(date: tDate)).called(1);
  });
}
