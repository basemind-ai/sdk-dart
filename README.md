# BaseMind.AI Dart SDK

<div align="center">

[![Discord](https://img.shields.io/discord/1153195687459160197)](https://discord.gg/ZSV2CQ86yg)

</div>

The BaseMind.AI Dart SDK is a gRPC client library for connecting with the BaseMind.AI platform.

## Installation

Add the dependency in your application's `pubspec.yaml`:

```shell
dart pub add basemind
```

## Usage

Before using the client you have to initialize it. The init function requires an `apiKey` that you can create using the
BaseMind platform (visit https://basemind.ai):

```dart
// TODO
```

Once the client is initialized, you can use it to interact with the AI model(s) you configured in the BaseMind dashboard.

### Prompt Request/Response

You can request an LLM prompt using the `requestPrompt` method, which expects a dictionary of string key/value pairs -
correlating with any template variables defined in the dashboard (if any):

```dart
// TODO
```

### Prompt Streaming

You can also stream a prompt response using the `requestStream` method:

```dart
// TODO
```

Similarly to the `requestPrompt` method, `requestStream` expects a mapping of strings (if any template variables are
defined in the dashboard).

### Error Handling

// TODO

### Options

// TODO

### Passing Prompt Config ID

// TODO

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
