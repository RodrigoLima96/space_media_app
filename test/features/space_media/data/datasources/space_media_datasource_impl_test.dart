import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:space_media_app/core/errors/errors.dart';
import 'package:space_media_app/core/http/http.dart';
import 'package:space_media_app/core/utils/converters/date_to_string_converter.dart';
import 'package:space_media_app/features/space_media/data/datasources/datasources.dart';
import 'package:space_media_app/features/space_media/data/models/models.dart';

import '../../mocks/space_media_json_mock.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  late ISpaceMediaDatasource datasource;
  late HttpClient client;

  setUp(() {
    client = HttpClientMock();
    datasource = NasaDatasourceImpl(client: client);
  });

  final tDate = DateTime(2024, 05, 05);
  const tUrl = 'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY';
  final tDateString = DateToStringConverter.convert(date: tDate);

  void successMock() {
    when(() => client.get(url: any(named: 'url'))).thenAnswer(
        (_) async => const HttpResponse(data: spaceMediaJsonMock, statusCode: 200));
  }

  test('Should call the get method with correct url', () async {
    // Arrange
    successMock();

    // Act
    await datasource.getSpaceMediaFromDate(date: tDate);

    // Assert
    verify(() => client.get(url: '$tUrl&date=$tDateString')).called(1);
  });

  test('Should return a SpaceMediaModel when is success', () async {
    // Arrange
    successMock();
    const tSapaceMediaModel = SpaceMediaModel(
      description: 'description',
      mediaType: 'mediaType',
      title: 'title',
      mediaUrl: 'mediaUrl',
    );

    // Act
    final result = await datasource.getSpaceMediaFromDate(date: tDate);

    // Assert
    expect(result, tSapaceMediaModel);
  });

  test('Should throw a ServerException when the call is unsuccessful', () {
    // Arrange
    when(() => client.get(url: any(named: 'url'))).thenAnswer(
      (_) async =>
          const HttpResponse(data: 'Something went wrong', statusCode: 400),
    );

    // Act
    final result = datasource.getSpaceMediaFromDate(date: tDate);

    // Assert
    expect(() => result, throwsA(ServerException()));
  });
}
