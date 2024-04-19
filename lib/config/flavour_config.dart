enum Flavor {
  DEVELOPMENT,
  STAGING,
  PRODUCTION,
}

class FlavorValues {
  final String baseUrl;

  FlavorValues({required this.baseUrl});
}

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final FlavorValues values;

  static FlavorConfig? _instance;

  factory FlavorConfig({
    required Flavor flavor,
    required FlavorValues values,
  }) {
    _instance ??= FlavorConfig._internal(
      flavor,
      enumName(flavor.toString()),
      values
    );
    return _instance!;
  }

  FlavorConfig._internal(
      this.flavor,
      this.name,
      this.values,
      );

  static FlavorConfig get instance {
    return _instance!;
  }

  static String enumName(String enumToString) {
    var paths = enumToString.split('.');
    return paths[paths.length - 1];
  }

  static bool isProduction() => _instance?.flavor == Flavor.PRODUCTION;
  static bool isStaging() => _instance?.flavor == Flavor.STAGING;
  static bool isDevelopment() => _instance?.flavor == Flavor.DEVELOPMENT;
}