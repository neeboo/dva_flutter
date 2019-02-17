import 'package:dva_dart/dva_dart.dart';
import './models/models.dart' as models;

final DvaStore store =
    DvaStore(models: [models.counterPageModel, models.playPageModel]);
