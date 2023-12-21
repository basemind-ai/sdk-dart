/// Base exception for all BaseMind exceptions.
abstract class BaseMindException implements Exception {
  String message;
  BaseMindException(this.message);
}

/// Thrown when the API key is an empty string.
class MissingAPIKeyException extends BaseMindException {
  MissingAPIKeyException(super.message);
}

/// Thrown when a client method is called without passing in at least one expected prompt variable key.
class MissingPromptVariableException extends BaseMindException {
  MissingPromptVariableException(super.message);
}

/// Thrown when the API gateway returns an error other than an invalid argument.
class APIGatewayException extends BaseMindException {
  APIGatewayException(super.message);
}
