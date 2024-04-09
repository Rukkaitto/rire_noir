class EnvironmentService {
  String get env {
    return const String.fromEnvironment('ENV', defaultValue: 'local');
  }

  Uri get uri {
    switch (env) {
      case 'local':
        return Uri.http('localhost:3001');
      case 'prod':
        return Uri.https('lucasgoudin.com');
      default:
        throw Exception('Environment $env not found');
    }
  }
}
