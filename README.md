<div align="center">
  
![Header with AI](https://github.com/basemind-ai/sdk-dart/assets/30323315/f74e21f9-9103-4518-9088-94497c6dba82)

</div>

<div align="center">

[![Discord](https://img.shields.io/discord/1153195687459160197)](https://discord.gg/ZSV2CQ86yg)

</div>

# BaseMind.AI Dart SDK

The BaseMind.AI Dart SDK is a gRPC client library for connecting with the BaseMind.AI platform.

## Installation

Add the dependency in your application's `pubspec.yaml`:

With Flutter:
```shell
flutter pub add basemind
```

With Dart:
```shell
dart pub add basemind
```

## Usage

Before using the client you have to initialize it. The init function requires an `apiKey` that you can create using the
BaseMind platform (visit https://basemind.ai):

```dart
import 'package:basemind/client.dart';

final client = BaseMindClient('<API_KEY>');
```

Once the client is initialized, you can use it to interact with the AI model(s) you configured in the BaseMind dashboard.

### Prompt Request/Response

You can request an LLM prompt using the `requestPrompt` method, which expects a dictionary of string key/value pairs -
correlating with any template variables defined in the dashboard (if any):

```dart
import 'package:basemind/client.dart';

final client = BaseMindClient('<API_KEY>');

Future<String> handlePromptRequest(String userInput) async {
  final response = await client.requestPrompt({'userInput': userInput});
  return response.content;
}
```

### Prompt Streaming

You can also stream a prompt response using the `requestStream` method:

```dart
import 'package:basemind/client.dart';

final client = BaseMindClient('<API_KEY>');

handlePromptStream(String userInput) {
  final stream = client.requestStream({'userInput': userInput});
  stream.listen((response) {
    print(response.content);
  });
}
```

And you can of course use the `requestStream` method with async/await:

```dart
import 'package:basemind/client.dart';

final client = BaseMindClient('<API_KEY>');

Future<List<String>> handlePromptStream(String userInput) async {
  final stream = client.requestStream({'userInput': userInput});

  var chunks = [];

  await for (var response in stream) {
    chunk.add(response.content);
  }

  return chunks;
}
```

Similarly to the `requestPrompt` method, `requestStream` expects a mapping of strings (if any template variables are
defined in the dashboard).

### Error Handling

All errors thrown by the client are subclasses of BaseMindException. Errors are thrown in the following cases:

1. The api key is empty (MissingAPIKeyException).
2. A server side or connectivity error occurred (APIGatewayException)
3. A required template variable was not provided in the mapping passed to the request (MissingPromptVariableException).

### Options

You can pass an options object to the client:

```dart
import 'package:basemind/client.dart';

final options = ClientOptions(
   serverAddress: '127.0.0.1',
   serverPort: 8080,
   debug: true,
   logger: Logger('my-logger'),
   channelOptions:
   ChannelOptions(credentials: ChannelCredentials.insecure()),
);

final client = BaseMindClient('<API_KEY>', null, options);
```

-   `logger`: an instance of [logging.Logger](https://pub.dev/packages/logging) to use for logging debug messages.
-   `debug`: if set to true (default false) the client will log debug messages.
-   `serverAddress`: the host of the BaseMind Gateway server to use.
-   `serverPort`: the server port.
-   `channelOptions`: gRPC channel options to use for connecting to the server.

### Passing Prompt Config ID

The `BaseMindClient constructor also accepts an optional `promptConfigId parameter. This parameter is null by default
which means the client will use the prompt configuration defined as default in the dashboard. You can also pass a
specific prompt config ID to the client:

```dart
import 'package:basemind/client.dart';

final client = BaseMindClient('<API_KEY>', "c5f5d1fd-d25d-4ba2-b103-8c85f48a679d");
```

`Note`: you can have multiple client instances with different `promptConfigId` values set. This allows you to use
multiple model configurations within a single application.

## Local Development

<u>Repository Structure:</u>

```text
root                        # repository root, holding all tooling configurations
├─── .github                # GitHub CI/CD and other configurations
├─── .idea                  # IDE configurations that are shared
├─── proto/gateway          # Git submodule that includes the protobuf schema
├─── bin                    # CLI commands
└─── lib                    # the Dart SDK code
```

### Setup

1. Clone to repository to your local machine including the submodules.

    ```shell
    git clone --recurse-submodules https://github.com/basemind-ai/sdk-dart.git
    ```

2. Install [TaskFile](https://taskfile.dev/) and the following prerequisites:

    - Python >= 3.11
    - IntelliJ (optional but recommended)

3. Execute the setup task with:

```shell
task setup
```

This will setup [pre-commit](https://pre-commit.com/) and the other required dependencies.

### Linting

To lint the project, execute the lint command:

```shell
task lint
```

### Updating Dependencies

To update the dependencies, execute the update-dependencies command:

```shell
task update
```

This will update the dependencies in the [pubspec file](./pubspec.yaml). It will also update
the pre-commit hooks.

### Generating gRPC Stubs

To generate the gRPC stubs, execute the generate command:

```shell
task generate
```

## Contribution

The SDK is open source.

Pull requests are welcome - as long as they address an issue or substantially improve the SDK or the test app.

Note: Tests are mandatory for the SDK - untested code will not be merged.
