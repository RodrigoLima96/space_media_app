import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:space_media_app/features/space_media/data/models/models.dart';
import 'package:space_media_app/features/space_media/domain/entities/entities.dart';

import '../../mocks/space_media_mock.dart';

void main() {
  const tSpaceMediaModel = SpaceMediaModel(
    description: 'description',
    mediaType: 'mediaType',
    title: 'title',
    mediaUrl: 'mediaUrl',
  );

  test('Should be a subclass of SpaceMediaEntity', () {
    expect(tSpaceMediaModel, isA<SpaceMediaEntity>());
  });

  test('Should return a valid model', () {
    // Arrange
    final Map<String, dynamic> jsonMap = json.decode(spaceMediaMock);

    // Act
    final result = SpaceMediaModel.fromJson(jsonMap);

    // Assert
    expect(result, tSpaceMediaModel);
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
    final result = tSpaceMediaModel.toJson();

    // Assert
    expect(result, expectedMap);
  });
}