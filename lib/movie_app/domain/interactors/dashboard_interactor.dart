
import '../../data/models/models.dart';

abstract class DashboardInteractor {
  Future<List<Movie>> getListTrending();

  Future<List<TV>> getListTopRate();
}