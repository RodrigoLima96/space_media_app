import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:space_media_app/features/space_media/data/models/models.dart';
import 'package:space_media_app/features/space_media/domain/entities/entities.dart';

import '../../mocks/space_media_json_mock.dart';
import '../../mocks/space_media_model_mock.dart';

void main() {
  test('Should be a subclass of SpaceMediaEntity', () {
    expect(tSpaceMediaModelMock, isA<SpaceMediaEntity>());
  });

  test('Should return a valid model', () {
    // Arrange
    final Map<String, dynamic> jsonMap = json.decode(spaceMediaJsonMock);

    // Act
    final result = SpaceMediaModel.fromJson(jsonMap);

    // Assert
    expect(result, tSpaceMediaModelMock);
  });

  test('Should return a json map containing the proper data', () {
    // Arrange
    const expectedMap = {
      "explanation": "description",
      "media_type": "mediaType",
      "title": "title",
      "url": "mediaUrl"
    };

    // Act
    final result = tSpaceMediaModelMock.toJson();

    // Assert
    expect(result, expectedMap);
  });
}