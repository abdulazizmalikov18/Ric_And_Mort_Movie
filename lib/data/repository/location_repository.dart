import 'package:retrofit/retrofit.dart';
import 'package:ric_and_mort_movie/data/model/remote/location/LocationInfo.dart';
import 'package:ric_and_mort_movie/data/model/remote/location/LocationResponse.dart';
import 'package:ric_and_mort_movie/data/remote/service/location/location_service.dart';

class LocationRepository {
  final LocationService _locationService;

  LocationRepository(this._locationService);

  Future<HttpResponse<LocationResponse>> getLocations(
    int page,
    Map<String, String>? options,
  ) => _locationService.getLocations(page, options);

  Future<HttpResponse<LocationInfo>> getLocation(int id) =>
      _locationService.getLocation(id);
}
