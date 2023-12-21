import 'package:grpc/grpc.dart';
import 'package:logging/logging.dart';

import 'exceptions.dart';
import 'generated/gateway.pbgrpc.dart';

const _missingTemplateVariableMessage =
    "a value for an expected template variable was not passed to the request";
const _apiGatewayErrorMessage = "the API gateway returned an error";

const defaultApiGatewayAddress = "gateway.basemind.ai";
const defaultApiGatewayPort = 443;

final defaultLogger = Logger("BaseMindClient");

/// Options for instantiating a [BaseMindClient].
class ClientOptions {
  /// The address of the basemind gateway to connect to.
  final String serverAddress;

  /// The server port to use.
  final int serverPort;

  /// Controls outputting debug log messages. Defaults to 'false'.
  final bool debug;

  ///  A logger instance to use. If not provided the default logger will be used.
  final Logger? logger;

  /// gRPC channel options.
  final ChannelOptions? channelOptions;

  ClientOptions({
    this.serverAddress = defaultApiGatewayAddress,
    this.serverPort = defaultApiGatewayPort,
    this.debug = false,
    this.logger,
    this.channelOptions,
  });
}

class BaseMindClient {
  final String _apiToken;
  final String? _promptConfigId;
  final APIGatewayServiceClient _stub;
  final ClientChannel _channel;
  final bool _isDebug;
  final Logger _logger;

  BaseMindClient._internal(this._apiToken, this._promptConfigId, this._stub,
      this._channel, this._isDebug, this._logger);

  /// Instantiates and returns [BaseMindClient] instance.
  ///
  /// Param [apiToken] is the API token to use for authentication. This parameter is required.
  /// Param [promptConfigId] is the prompt config id to use for the prompt request. If not provided the default prompt config will be used.
  /// Param [ClientOptions] is an optional options object.
  factory BaseMindClient(String apiToken,
      [String? promptConfigId, ClientOptions? options]) {
    if (apiToken.isEmpty) {
      throw MissingAPIKeyException("apiToken must not be empty");
    }

    options ??= ClientOptions();

    var logger = options.logger ?? defaultLogger;

    if (options.debug) {
      logger.fine("creating client instance");
    }

    var channelOptions = options.channelOptions ??
        ChannelOptions(
          credentials: ChannelCredentials.secure(),
        );

    var channel = ClientChannel(
      options.serverAddress,
      port: options.serverPort,
      options: channelOptions,
    );

    var stub = APIGatewayServiceClient(channel);

    return BaseMindClient._internal(
        apiToken, promptConfigId, stub, channel, options.debug, logger);
  }

  _createPromptRequest(Map<String, String>? templateVariables) {
    var request = PromptRequest();

    if (templateVariables != null) {
      request.templateVariables.addAll(templateVariables);
    }

    if (_promptConfigId != null) {
      request.promptConfigId = _promptConfigId!;
    }

    return request;
  }

  /// Closes the gRPC channel and cancels pending RPC calls.
  ///
  /// This method should be called when discarding the client.
  /// For example, when shutting down the application.
  Future<void> close() async {
    await _channel.shutdown();
  }

  /// Requests an AI prompt. The prompt is returned as a single response.
  ///
  /// Param [templateVariables] is a map of template variables to use for the prompt request.
  /// throws [MissingPromptVariableException] if a template variable is missing.
  /// throws an [APIGatewayException] if the API gateway returns an error.
  Future<PromptResponse> requestPrompt(
    Map<String, String>? templateVariables,
  ) async {
    if (_isDebug) {
      _logger.fine("requesting prompt");
    }

    try {
      return await _stub.requestPrompt(
        _createPromptRequest(templateVariables),
        options: CallOptions(metadata: {
          "authorization": "Bearer $_apiToken",
        }),
      );
    } on GrpcError catch (e) {
      if (_isDebug) {
        _logger.fine("exception requesting prompt: $e");
      }
      if (e.code == StatusCode.invalidArgument) {
        throw MissingPromptVariableException(
            e.message ?? _missingTemplateVariableMessage);
      }
      throw APIGatewayException(e.message ?? _apiGatewayErrorMessage);
    }
  }

  /// Requests an AI streaming prompt. The prompt is streamed from the API gateway in chunks.
  ///
  /// Param [templateVariables] is a map of template variables to use for the prompt request.
  /// throws [MissingPromptVariableException] if a template variable is missing.
  /// throws an [APIGatewayException] if the API gateway returns an error.
  Stream<StreamingPromptResponse> requestStream(
    Map<String, String>? templateVariables,
  ) {
    if (_isDebug) {
      _logger.fine("requesting streaming prompt");
    }

    final stream = _stub.requestStreamingPrompt(
      _createPromptRequest(templateVariables),
      options: CallOptions(
        metadata: {
          "authorization": "Bearer $_apiToken",
        },
      ),
    );

    return stream.handleError((e) {
      if (_isDebug) {
        _logger.fine("exception streaming prompt: $e");
      }
      if (e.code == StatusCode.invalidArgument) {
        throw MissingPromptVariableException(
            e.message ?? _missingTemplateVariableMessage);
      }
      throw APIGatewayException(e.message ?? _apiGatewayErrorMessage);
    });
  }
}
