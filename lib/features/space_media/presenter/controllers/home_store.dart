import 'package:flutter_triple/flutter_triple.dart';
import 'package:space_media_app/core/errors/errors.dart';
import 'package:space_media_app/features/space_media/domain/entities/entities.dart';
import 'package:space_media_app/features/space_media/domain/usecases/usecases.dart';

class HomeStore extends NotifierStore<Failure, SpaceMediaEntity> {
  final GetSpaceMediaFromDateUsecase usecase;

  HomeStore({required this.usecase})
      : super(
          const SpaceMediaEntity(
            description: '',
            mediaType: '',
            title: '',
            mediaUrl: '',
          ),
        );

  getSpaceMediaFromDate({required DateTime date}) async {
    final result = await usecase(date);
    result.fold(
      (failure) => setError(failure),
      (spaceMedia) => update(spaceMedia),
    );
  }
}
