class LocationResponseEntity {
  final DriverEntity? driver;
  final StoreEntity? store;
  final UserEntity? user;

  LocationResponseEntity ({
    this.driver,
    this.store,
    this.user,
  });
}

class DriverEntity {
  final String? firstName;
  final String? lastName;
  final LocationEntity? location;
  final String? phone;
  final String? photo;

  DriverEntity ({
    this.firstName,
    this.lastName,
    this.location,
    this.phone,
    this.photo,
  });
}

class StoreEntity {
  final LocationEntity? location;

  StoreEntity ({
    this.location,
  });
}

class UserEntity {
  final LocationEntity? location;

  UserEntity ({
    this.location,
  });
}

class LocationEntity {
  final int? lat;
  final int? long;

  LocationEntity ({
    this.lat,
    this.long,
  });
}