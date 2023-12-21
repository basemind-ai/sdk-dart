import 'package:basemind/src/client.dart';
import 'package:basemind/src/exceptions.dart';
import 'package:basemind/src/generated/gateway.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'package:logging/logging.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

// Annotation which generates the cat.mocks.dart library and the MockCat class.
@GenerateNiceMocks([MockSpec<Logger>()])
import 'package_test.mocks.dart';

class MockAPIGatewayServer extends APIGatewayServiceBase {
  Exception? exc;
  String? templateVariableValue;
  String? promptConfigId;
  Map<String, String>? metadata;

  @override
  Future<PromptResponse> requestPrompt(
    ServiceCall call,
    PromptRequest request,
  ) async {
    if (exc != null) {
      throw exc!;
    }

    metadata = call.clientMetadata;
    promptConfigId = request.promptConfigId;
    templateVariableValue = request.templateVariables['key'];
    return PromptResponse()..content = 'test prompt';
  }

  @override
  Stream<StreamingPromptResponse> requestStreamingPrompt(
    ServiceCall call,
    PromptRequest request,
  ) {
    if (exc != null) {
      throw exc!;
    }

    metadata = call.clientMetadata;
    promptConfigId = request.promptConfigId;
    templateVariableValue = request.templateVariables['key'];
    return Stream.fromIterable(
        ['1', '2', '3'].map((e) => StreamingPromptResponse()..content = e));
  }
}

void main() {
  group('ClientOptions', () {
    test('Default values are set correctly', () {
      final options = ClientOptions();
      expect(options.serverAddress, equals(defaultApiGatewayAddress));
      expect(options.serverPort, equals(defaultApiGatewayPort));
      expect(options.debug, equals(false));
      expect(options.logger, isNull);
      expect(options.channelOptions, isNull);
    });

    test('ClientOptions allows setting all attributes', () {
      final options = ClientOptions(
        serverAddress: 'testAddress',
        serverPort: 1234,
        debug: true,
        logger: Logger('testLogger'),
        channelOptions:
            ChannelOptions(credentials: ChannelCredentials.insecure()),
      );
      expect(options.serverAddress, equals('testAddress'));
      expect(options.serverPort, equals(1234));
      expect(options.debug, equals(true));
      expect(options.logger, isNotNull);
      expect(options.channelOptions, isNotNull);
    });
  });

  group('BaseMindClient', () {
    test('Factory constructor creates instance correctly', () {
      final client = BaseMindClient('validToken', null, null);
      expect(client, isNotNull);
    });

    test('Factory constructor throws with empty API token', () {
      expect(() => BaseMindClient('', null, null),
          throwsA(isA<MissingAPIKeyException>()));
    });

    test('requestPrompt returns valid response', () async {
      final server = Server.create(services: [MockAPIGatewayServer()]);
      await server.serve(address: 'localhost', port: 0);

      final options = ClientOptions(
        serverAddress: 'localhost',
        serverPort: server.port!,
        channelOptions:
            ChannelOptions(credentials: ChannelCredentials.insecure()),
      );

      final client = BaseMindClient('validToken', null, options);
      final response = await client.requestPrompt({'key': 'value'});
      expect(response.content, equals('test prompt'));

      await client.close();
      await server.shutdown();
    });

    test("requestPrompt sends template variables", () async {
      final mockService = MockAPIGatewayServer();
      final server = Server.create(services: [mockService]);
      await server.serve(address: 'localhost', port: 0);

      final options = ClientOptions(
        serverAddress: 'localhost',
        serverPort: server.port!,
        channelOptions:
            ChannelOptions(credentials: ChannelCredentials.insecure()),
      );

      final client = BaseMindClient('validToken', null, options);
      await client.requestPrompt({'key': 'value'});

      expect(mockService.templateVariableValue, equals('value'));

      await client.close();
      await server.shutdown();
    });

    test("requestPrompt sends promptConfigId", () async {
      final mockService = MockAPIGatewayServer();
      final server = Server.create(services: [mockService]);
      await server.serve(address: 'localhost', port: 0);

      final options = ClientOptions(
        serverAddress: 'localhost',
        serverPort: server.port!,
        channelOptions:
            ChannelOptions(credentials: ChannelCredentials.insecure()),
      );

      final client = BaseMindClient('validToken', "abc", options);
      await client.requestPrompt({'key': 'value'});

      expect(mockService.promptConfigId, equals("abc"));

      await client.close();
      await server.shutdown();
    });

    test("requestPrompt sends auth header", () async {
      final mockService = MockAPIGatewayServer();
      final server = Server.create(services: [mockService]);
      await server.serve(address: 'localhost', port: 0);

      final options = ClientOptions(
        serverAddress: 'localhost',
        serverPort: server.port!,
        channelOptions:
            ChannelOptions(credentials: ChannelCredentials.insecure()),
      );

      final client = BaseMindClient('validToken', null, options);
      await client.requestPrompt({'key': 'value'});

      expect(
          mockService.metadata!["authorization"], equals("Bearer validToken"));

      await client.close();
      await server.shutdown();
    });

    test(
        'requestPrompt throws MissingPromptVariableException when the server returns invalidArgument',
        () async {
      var mockService = MockAPIGatewayServer();
      mockService.exc =
          GrpcError.invalidArgument('missing template variable test');

      final server = Server.create(services: [mockService]);
      await server.serve(address: 'localhost', port: 0);

      final options = ClientOptions(
        serverAddress: 'localhost',
        serverPort: server.port!,
        channelOptions:
            ChannelOptions(credentials: ChannelCredentials.insecure()),
      );

      final client = BaseMindClient('validToken', null, options);
      try {
        await client.requestPrompt({'key': 'value'});
        fail('expected exception');
      } on MissingPromptVariableException catch (e) {
        expect(e.message, equals('missing template variable test'));
      }

      await client.close();
      await server.shutdown();
    });

    test(
        'requestPrompt throws MissingPromptVariableException with default message when the server returns invalidArgument without a message',
        () async {
      var mockService = MockAPIGatewayServer();
      mockService.exc = GrpcError.invalidArgument();

      final server = Server.create(services: [mockService]);
      await server.serve(address: 'localhost', port: 0);

      final options = ClientOptions(
        serverAddress: 'localhost',
        serverPort: server.port!,
        channelOptions:
            ChannelOptions(credentials: ChannelCredentials.insecure()),
      );

      final client = BaseMindClient('validToken', null, options);
      try {
        await client.requestPrompt({'key': 'value'});
        fail('expected exception');
      } on MissingPromptVariableException catch (e) {
        expect(
            e.message,
            equals(
                'a value for an expected template variable was not passed to the request'));
      }

      await client.close();
      await server.shutdown();
    });

    test(
        'requestPrompt throws APIGatewayException when the server returns a non-invalidArgument error',
        () async {
      var mockService = MockAPIGatewayServer();
      mockService.exc = GrpcError.internal('something went wrong');

      final server = Server.create(services: [mockService]);
      await server.serve(address: 'localhost', port: 0);

      final options = ClientOptions(
        serverAddress: 'localhost',
        serverPort: server.port!,
        channelOptions:
            ChannelOptions(credentials: ChannelCredentials.insecure()),
      );

      final client = BaseMindClient('validToken', null, options);
      try {
        await client.requestPrompt({'key': 'value'});
        fail('expected exception');
      } on APIGatewayException catch (e) {
        expect(e.message, equals('something went wrong'));
      }

      await client.close();
      await server.shutdown();
    });

    test(
        'requestPrompt throws APIGatewayException with default message when the server returns a non-invalidArgument error without a message',
        () async {
      var mockService = MockAPIGatewayServer();
      mockService.exc = GrpcError.internal();

      final server = Server.create(services: [mockService]);
      await server.serve(address: 'localhost', port: 0);

      final options = ClientOptions(
        serverAddress: 'localhost',
        serverPort: server.port!,
        channelOptions:
            ChannelOptions(credentials: ChannelCredentials.insecure()),
      );

      final client = BaseMindClient('validToken', null, options);
      try {
        await client.requestPrompt({'key': 'value'});
        fail('expected exception');
      } on APIGatewayException catch (e) {
        expect(e.message, equals('the API gateway returned an error'));
      }

      await client.close();
      await server.shutdown();
    });

    test("request prompt logs message when requesting prompt", () async {
      final server = Server.create(services: [MockAPIGatewayServer()]);
      await server.serve(address: 'localhost', port: 0);

      final mock = MockLogger();

      final options = ClientOptions(
        serverAddress: 'localhost',
        serverPort: server.port!,
        debug: true,
        logger: mock,
        channelOptions:
            ChannelOptions(credentials: ChannelCredentials.insecure()),
      );

      final client = BaseMindClient('validToken', null, options);
      await client.requestPrompt({'key': 'value'});

      verify(mock.fine("creating client instance")).called(1);
      verify(mock.fine("requesting prompt")).called(1);

      await client.close();
      await server.shutdown();
    });
  });

  test("request prompt logs message when catching exception", () async {
    var mockService = MockAPIGatewayServer();
    mockService.exc = GrpcError.internal('something went wrong');

    final server = Server.create(services: [mockService]);
    await server.serve(address: 'localhost', port: 0);

    final mockLogger = MockLogger();

    final options = ClientOptions(
      serverAddress: 'localhost',
      serverPort: server.port!,
      logger: mockLogger,
      debug: true,
      channelOptions:
          ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

    final client = BaseMindClient('validToken', null, options);
    try {
      await client.requestPrompt({'key': 'value'});
      fail('expected exception');
    } on APIGatewayException catch (_) {
      expect(verify(mockLogger.fine(captureAny)).captured, hasLength(3));
    }

    await client.close();
    await server.shutdown();
  });

  test('requestStreamingPrompt streams valid responses', () async {
    final server = Server.create(services: [MockAPIGatewayServer()]);
    await server.serve(address: 'localhost', port: 0);

    final options = ClientOptions(
      serverAddress: 'localhost',
      serverPort: server.port!,
      channelOptions:
          ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

    final client = BaseMindClient('validToken', null, options);
    var stream = client.requestStreamingPrompt({'key': 'value'});

    var chunks = [];

    await for (var chunk in stream) {
      chunks.add(chunk.content);
    }

    expect(chunks, equals(['1', '2', '3']));

    await client.close();
    await server.shutdown();
  });
  test("requestStreamingPrompt sends template variables", () async {
    final mockService = MockAPIGatewayServer();
    final server = Server.create(services: [mockService]);
    await server.serve(address: 'localhost', port: 0);

    final options = ClientOptions(
      serverAddress: 'localhost',
      serverPort: server.port!,
      channelOptions:
          ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

    final client = BaseMindClient('validToken', null, options);
    final stream = client.requestStreamingPrompt({'key': 'value'});

    await for (var _ in stream) {
      continue;
    }

    expect(mockService.templateVariableValue, equals("value"));

    await client.close();
    await server.shutdown();
  });
  test("requestStreamingPrompt sends promptConfigId", () async {
    final mockService = MockAPIGatewayServer();
    final server = Server.create(services: [mockService]);
    await server.serve(address: 'localhost', port: 0);

    final options = ClientOptions(
      serverAddress: 'localhost',
      serverPort: server.port!,
      channelOptions:
          ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

    final client = BaseMindClient('validToken', "abc", options);
    final stream = client.requestStreamingPrompt({'key': 'value'});

    await for (var _ in stream) {
      continue;
    }

    expect(mockService.promptConfigId, equals("abc"));

    await client.close();
    await server.shutdown();
  });
  test("requestStreamingPrompt sends auth header", () async {
    final mockService = MockAPIGatewayServer();
    final server = Server.create(services: [mockService]);
    await server.serve(address: 'localhost', port: 0);

    final options = ClientOptions(
      serverAddress: 'localhost',
      serverPort: server.port!,
      channelOptions:
          ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

    final client = BaseMindClient('validToken', null, options);
    final stream = client.requestStreamingPrompt({'key': 'value'});

    await for (var _ in stream) {
      continue;
    }

    expect(mockService.metadata!["authorization"], equals("Bearer validToken"));

    await client.close();
    await server.shutdown();
  });
  test(
      "requestStreamingPrompt throws MissingPromptVariableException when the server returns invalidArgument",
      () async {
    var mockService = MockAPIGatewayServer();
    mockService.exc =
        GrpcError.invalidArgument('missing template variable test');

    final server = Server.create(services: [mockService]);
    await server.serve(address: 'localhost', port: 0);

    final options = ClientOptions(
      serverAddress: 'localhost',
      serverPort: server.port!,
      channelOptions:
          ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

    final client = BaseMindClient('validToken', null, options);

    try {
      final stream = client.requestStreamingPrompt({'key': 'value'});
      await for (var _ in stream) {
        continue;
      }

      fail('expected exception');
    } on MissingPromptVariableException catch (e) {
      expect(e.message, equals('missing template variable test'));
    }

    await client.close();
    await server.shutdown();
  });
  test(
      "requestStreamingPrompt throws MissingPromptVariableException with default message when the server returns invalidArgument without a message",
      () async {
    var mockService = MockAPIGatewayServer();
    mockService.exc = GrpcError.invalidArgument();

    final server = Server.create(services: [mockService]);
    await server.serve(address: 'localhost', port: 0);

    final options = ClientOptions(
      serverAddress: 'localhost',
      serverPort: server.port!,
      channelOptions:
          ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

    final client = BaseMindClient('validToken', null, options);

    try {
      final stream = client.requestStreamingPrompt({'key': 'value'});
      await for (var _ in stream) {
        continue;
      }

      fail('expected exception');
    } on MissingPromptVariableException catch (e) {
      expect(
          e.message,
          equals(
              "a value for an expected template variable was not passed to the request"));
    }

    await client.close();
    await server.shutdown();
  });
  test(
      "requestStreamingPrompt throws APIGatewayException when the server returns a non-invalidArgument error",
      () async {
    var mockService = MockAPIGatewayServer();
    mockService.exc = GrpcError.internal('something went wrong');

    final server = Server.create(services: [mockService]);
    await server.serve(address: 'localhost', port: 0);

    final options = ClientOptions(
      serverAddress: 'localhost',
      serverPort: server.port!,
      channelOptions:
          ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

    final client = BaseMindClient('validToken', null, options);

    try {
      final stream = client.requestStreamingPrompt({'key': 'value'});
      await for (var _ in stream) {
        continue;
      }

      fail('expected exception');
    } on APIGatewayException catch (e) {
      expect(e.message, equals("something went wrong"));
    }

    await client.close();
    await server.shutdown();
  });
  test(
      "requestStreamingPrompt throws APIGatewayException with default message when the server returns a non-invalidArgument error without a message",
      () async {
    var mockService = MockAPIGatewayServer();
    mockService.exc = GrpcError.internal();

    final server = Server.create(services: [mockService]);
    await server.serve(address: 'localhost', port: 0);

    final options = ClientOptions(
      serverAddress: 'localhost',
      serverPort: server.port!,
      channelOptions:
          ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

    final client = BaseMindClient('validToken', null, options);

    try {
      final stream = client.requestStreamingPrompt({'key': 'value'});
      await for (var _ in stream) {
        continue;
      }

      fail('expected exception');
    } on APIGatewayException catch (e) {
      expect(e.message, equals("the API gateway returned an error"));
    }

    await client.close();
    await server.shutdown();
  });
  test("requestStreamingPrompt prompt logs message when requesting prompt",
      () async {
    final server = Server.create(services: [MockAPIGatewayServer()]);
    await server.serve(address: 'localhost', port: 0);

    final mock = MockLogger();

    final options = ClientOptions(
      serverAddress: 'localhost',
      serverPort: server.port!,
      debug: true,
      logger: mock,
      channelOptions:
          ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

    final client = BaseMindClient('validToken', null, options);
    client.requestStreamingPrompt({'key': 'value'});

    verify(mock.fine("creating client instance")).called(1);
    verify(mock.fine("requesting streaming prompt")).called(1);

    await client.close();
    await server.shutdown();
  });
  test("requestStreamingPrompt prompt logs message when catching exception",
      () async {
    var mockService = MockAPIGatewayServer();
    mockService.exc = GrpcError.invalidArgument();

    final server = Server.create(services: [mockService]);
    await server.serve(address: 'localhost', port: 0);

    final mockLogger = MockLogger();

    final options = ClientOptions(
      serverAddress: 'localhost',
      serverPort: server.port!,
      debug: true,
      logger: mockLogger,
      channelOptions:
          ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

    final client = BaseMindClient('validToken', null, options);
    try {
      final stream = client.requestStreamingPrompt({'key': 'value'});
      await for (var _ in stream) {
        continue;
      }

      fail('expected exception');
    } on MissingPromptVariableException {
      expect(verify(mockLogger.fine(captureAny)).captured, hasLength(3));
    }

    await client.close();
    await server.shutdown();
  });
}
