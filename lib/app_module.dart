import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_media/features/data/datasources/space_media_datasource_implementation.dart';
import 'package:nasa_media/features/data/repositories/space_media_repository_implementation.dart';
import 'package:nasa_media/features/domain/usecases/get_space_media_from_date_usecase.dart';
import 'package:nasa_media/features/presenter/controller/home_store.dart';
import 'package:nasa_media/features/presenter/pages/home_page.dart';
import 'package:http/http.dart' as http;
import 'core/utils/converters/date_input_formater.dart';
import 'features/presenter/pages/picture_page.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => HomeStore(i())),
        Bind.lazySingleton((i) => GetSpaceMediaFromDateUsecase(i())),
        Bind.lazySingleton((i) => SpaceMediaRepositoryImplementation(i())),
        Bind.lazySingleton((i) => http.Client()),
        Bind.lazySingleton((i) => DateInputConverter()),
        Bind.lazySingleton((i) =>
            SpaceMediaDatasouceImplementation(converter: i(), client: i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const HomePage()),
        ChildRoute('/picture',
            child: (_, args) => PicturePage.fromArgs(args.data)),
      ];
}
