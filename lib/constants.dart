class ApiConstants {
  static String baseUrl = 'https://wine.traefik.me';
  static String getUsersEndpoint = '/api/users';
  static String getCellarsEndpoint = '/api/cellars';
  static String getBottlesEndpoint = '/api/bottles?exists%5BemptyAt%5D=false';
  static String authenticateEndpoint = '/api/authenticate';
}
