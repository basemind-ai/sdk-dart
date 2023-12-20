/// Base exception for all BaseMind exceptions.
abstract class BaseMindException implements Exception {
  String cause;
  BaseMindException(this.cause);
}

/// Thrown when the API key is an empty string.
class MissingAPIKeyException extends BaseMindException {
  MissingAPIKeyException(super.cause);
}

/// Thrown when a client method is called without passing in at least one expected prompt variable key.
class MissingPromptVariableException extends BaseMindException {
  MissingPromptVariableException(super.cause);
}

/// Thrown when the API gateway returns an error other than an invalid argument.
class APIGatewayException extends BaseMindException {
  APIGatewayException(super.cause);
}
