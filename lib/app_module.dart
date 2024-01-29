
import 'package:flutter_modular/flutter_modular.dart';
import 'core/utils/converters/converters.dart';
import 'features/space_media/domain/usecases/usecases.dart';
import 'package:http/http.dart' as http;

import 'features/space_media/data/datasources/datasources.dart';
import 'features/space_media/data/repositories/repositories.dart';
import 'features/space_media/presenter/controllers/controllers.dart';
import 'features/space_media/presenter/pages/pages.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => HomeStore(usecase:  i())),
    Bind.lazySingleton((i) => GetSpaceMediaFromDateUsecase(repository:  i())),
    Bind.lazySingleton((i) => SpaceMediaRepositoryImpl(datasource:  i())),
    Bind.lazySingleton((i) => SpaceMediaDatasourceImpl(converter: i(), client: i())),
    Bind.lazySingleton((i) => http.Client()),
    Bind.lazySingleton((i) => DateToStringConverter()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => const HomePage()),
    ChildRoute('/picture', child: (_, args) => PicturePage.fromArgs(args.data)),
  ];
}
