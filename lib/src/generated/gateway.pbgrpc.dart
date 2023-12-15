//
//  Generated code. Do not modify.
//  source: proto/gateway/v1/gateway.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'gateway.pb.dart' as $0;

export 'gateway.pb.dart';

@$pb.GrpcServiceName('gateway.v1.APIGatewayService')
class APIGatewayServiceClient extends $grpc.Client {
  static final _$requestPrompt = $grpc.ClientMethod<$0.PromptRequest, $0.PromptResponse>(
      '/gateway.v1.APIGatewayService/RequestPrompt',
      ($0.PromptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.PromptResponse.fromBuffer(value));
  static final _$requestStreamingPrompt = $grpc.ClientMethod<$0.PromptRequest, $0.StreamingPromptResponse>(
      '/gateway.v1.APIGatewayService/RequestStreamingPrompt',
      ($0.PromptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.StreamingPromptResponse.fromBuffer(value));

  APIGatewayServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.PromptResponse> requestPrompt($0.PromptRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestPrompt, request, options: options);
  }

  $grpc.ResponseStream<$0.StreamingPromptResponse> requestStreamingPrompt($0.PromptRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$requestStreamingPrompt, $async.Stream.fromIterable([request]), options: options);
  }
}

@$pb.GrpcServiceName('gateway.v1.APIGatewayService')
abstract class APIGatewayServiceBase extends $grpc.Service {
  $core.String get $name => 'gateway.v1.APIGatewayService';

  APIGatewayServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.PromptRequest, $0.PromptResponse>(
        'RequestPrompt',
        requestPrompt_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PromptRequest.fromBuffer(value),
        ($0.PromptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PromptRequest, $0.StreamingPromptResponse>(
        'RequestStreamingPrompt',
        requestStreamingPrompt_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.PromptRequest.fromBuffer(value),
        ($0.StreamingPromptResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.PromptResponse> requestPrompt_Pre($grpc.ServiceCall call, $async.Future<$0.PromptRequest> request) async {
    return requestPrompt(call, await request);
  }

  $async.Stream<$0.StreamingPromptResponse> requestStreamingPrompt_Pre($grpc.ServiceCall call, $async.Future<$0.PromptRequest> request) async* {
    yield* requestStreamingPrompt(call, await request);
  }

  $async.Future<$0.PromptResponse> requestPrompt($grpc.ServiceCall call, $0.PromptRequest request);
  $async.Stream<$0.StreamingPromptResponse> requestStreamingPrompt($grpc.ServiceCall call, $0.PromptRequest request);
}
