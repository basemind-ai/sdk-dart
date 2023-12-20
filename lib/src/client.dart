import 'package:grpc/grpc.dart';
import 'package:logging/logging.dart';

import "generated/gateway.pbgrpc.dart";

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
  final APIGatewayServiceClient _stub;
  final ClientChannel _channel;
  final bool _isDebug;
  final Logger _logger;

  BaseMindClient._internal(
      this._stub, this._channel, this._isDebug, this._logger);

  /// Instantiates and returns [BaseMindClient] instance.
  ///
  /// Receives an optional [ClientOptions] object.
  factory BaseMindClient(ClientOptions? options) {
    options ??= ClientOptions();

    var logger = options.logger ?? defaultLogger;

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

    return BaseMindClient._internal(stub, channel, options.debug, logger);
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
      Map<String, String> templateVariables) async {
    var request = PromptRequest();
    request.templateVariables.addAll(templateVariables);
    return await _stub.requestPrompt(request);
  }

  /// Requests an AI streaming prompt. The prompt is streamed from the API gateway in chunks.
  ///
  /// Param [templateVariables] is a map of template variables to use for the prompt request.
  /// throws [MissingPromptVariableException] if a template variable is missing.
  /// throws an [APIGatewayException] if the API gateway returns an error.
  Stream<StreamingPromptResponse> requestStreamingPrompt(
      Map<String, String> templateVariables) {
    var request = PromptRequest();
    request.templateVariables.addAll(templateVariables);
    return _stub.requestStreamingPrompt(request);
  }
}
